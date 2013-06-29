//
//  SUViewController.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import "KEViewController.h"
#import "SVProgressHUD.h"
#import "KEWeatherManager.h"
#import "KELocationManager.h"
#import "GradientView.h"
#import "KEObservation.h"
#import "KEWindowView.h"
#import "KEAfterAfterTommorowForecast.h"
#import "KEAfterTommorowForecast.h"
#import "KEMapViewController.h"
#import "KEAppDelegate.h"
#import "Place.h"
#import "KEDataManager.h"
#import "NSString+CommaSubString.h"
#import "KEUIImageFactoryUtil.h"
#import "KEReachabilityUtil.h"
#import "KEDecoratorUtil.h"

@interface KEViewController () <UIScrollViewDelegate,KECoordinateFillProtocol>

@property (nonatomic, strong)       KEWindowView *templateView;
@property (nonatomic, strong)       KEObservation *geo;
@property (nonatomic, strong)       KEMapViewController *mapViewController;
@property (nonatomic, strong)       KEDataManager *dataManager;
@property (nonatomic, strong)       NSMutableArray *entityArrayCoreData;
@property (nonatomic, strong)       NSMutableArray *viewWithCoreData;
@property (nonatomic, strong)       NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)       CLLocation *loc;

@property (nonatomic, readwrite)    BOOL isShownMapPopover;
@property (nonatomic, readwrite)    BOOL pageControlBeingUsed;
@property (nonatomic, assign)       BOOL internetDroppedFirstly;

@end

@implementation KEViewController

- (void)prepareForLoading
{
    NSError *error = nil;
    NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"]
                                                               error:&error];
    self.entityArrayCoreData = [NSMutableArray arrayWithArray:places];
    self.viewWithCoreData = [[NSMutableArray alloc] init];
        
    for (int i = 1; i <= [places count]; i++) {
        KEWindowView *aView = [KEWindowView returnWindowView];
        aView.frame = CGRectMake((self.scrollView.contentOffset.x + 1024 *i) + 52, 40/*30*/, 920, 580);
        [self.scrollView addSubview:aView];
        [self.viewWithCoreData addObject:aView];
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:[[places objectAtIndex:i-1] latitude]
                                                         longitude:[[places objectAtIndex:i-1] longitude]];
        
        [self reloadDataWithNewLocation:location withView:aView];
    }
    self.pageControl.numberOfPages = [places count] + 1 ;
    self.scrollView.contentSize = CGSizeMake(1024 * ([places count] + 1), self.scrollView.contentSize.height);
    
   
}

#pragma mark - UIViewController lice cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self subscribeToReachabilityNotifications];
  
    if (![[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
        self.internetDroppedFirstly = YES;
    }
    else {
        [self subscribeToReachabilityNotifications];
        [self setupViews];
        
        KEWeatherManager *weather = [KEWeatherManager sharedClient];
        weather.delegate = self;
        
        __weak KEViewController *weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:kLocationDidChangeNotificationKey
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification *note) {
                                                                 [weakSelf reloadData];
        }];
        
        [[KELocationManager sharedManager] startMonitoringLocationChanges];
        
        [self configurateUIElements];
        self.dataManager = [KEDataManager sharedDataManager];
        self.managedObjectContext = [self.dataManager managedObjectContextFromAppDelegate];
        [self prepareForLoading];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[KELocationManager sharedManager] stopMonitoringLocationChanges];
}

#pragma mark - UI configuration and update

- (void)configurateUIElements
{
    self.scrollView.delegate = self;
    
	self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self
                         action:@selector(changePage:)
               forControlEvents:UIControlEventValueChanged];
    
    self.templateView = [KEWindowView returnWindowView];
    self.templateView.frame = CGRectMake(52, 40/*30*/, 920, 580);
    [self.scrollView addSubview:self.templateView];
    
    self.mapViewController = [[KEMapViewController alloc]init];
    self.mapViewController.objectToDelegate = self;
    self.isShownMapPopover = NO;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"navbar.png"];
    [self.navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [KEDecoratorUtil decorateWithShadow:self.navBar withOffsetValue:4.0f];
    [KEDecoratorUtil decorateWithShadow:self.downBar withOffsetValue:-4.0f];
    self.weziImage.image = [UIImage imageNamed:@"wezi_logo.png"];
    
    [self addCustomButtons];
}

- (void)addCustomButtons
{
    UIButton *refresh = [[UIButton alloc] initWithFrame:CGRectMake(959, 5, 60, 30)];
    [refresh setImage:[UIImage imageNamed:@"refresh_button.png"] forState:UIControlStateNormal];
    [refresh setImage:[UIImage imageNamed:@"refresh_button_click.png"] forState:UIControlStateHighlighted];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *trash = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60, 30)];
    [trash setImage:[UIImage imageNamed:@"trash_button.png"] forState:UIControlStateNormal];
    [trash setImage:[UIImage imageNamed:@"trash_button_click.png"] forState:UIControlStateHighlighted];
    [trash addTarget:self action:@selector(deletePage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar addSubview:refresh];
    [self.navBar addSubview:trash];
    
    UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 60, 30)];
    [add setImage:[UIImage imageNamed:@"plus_button.png"] forState:UIControlStateNormal];
    [add setImage:[UIImage imageNamed:@"plus_button_click.png"] forState:UIControlStateHighlighted];
    [add addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
   
    UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(959, 10, 60, 30)];
    [share setImage:[UIImage imageNamed:@"share_button.png"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"share_button_click.png"] forState:UIControlStateHighlighted];
        //[share addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.downBar addSubview:add];
    [self.downBar addSubview:share];
}

- (void)setupViews
{
//    self.observationContainerView.clipsToBounds = YES;
//    self.observationContainerView.layer.cornerRadius = 6.0f;
//    self.observationContainerView.layer.borderColor = [[UIColor whiteColor] CGColor];
//    self.observationContainerView.layer.borderWidth  = 3.0f;
    
//    self.shadowContainerView.backgroundColor = [UIColor clearColor];
//    self.shadowContainerView.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.shadowContainerView.layer.shadowOffset = CGSizeZero;
//    self.shadowContainerView.layer.shadowOpacity = 0.95f;
//    self.shadowContainerView.layer.shadowRadius = 10.0f;
//    self.shadowContainerView.hidden = YES;
    
}

- (void)updateUIWithObservationForCurrentLocation:(KEObservation *)observation
{
    if (observation) {
        
            //self.shadowContainerView.hidden = YES;
    

        
//        [self.weatherUndegroundImageView setImageWithURL:[NSURL URLWithString:observation.weatherUndergroundImageInfo[@"url"]]];
//        
//        self.locationLabel.text = observation.location[@"full"];
//        self.currentTemperatureLabel.text = observation.feelsLikeTemperatureC;
//        //self.feelsLikeTemperatureLabel.text = [@"Feels like " stringByAppendingString:observation.feelsLikeTemperatureDescription];
//        self.weatherDescriptionLabel.text = observation.weatherDescription;
//        self.windDescriptionLabel.text = observation.windDescription;
//        self.humidityLabel.text = observation.relativeHumidity;
//        
//        self.devointLabel.text = observation.dewpointDescription;
//        self.lastUpdateLAbel.text = observation.timeString;
        
     
        [self.templateView.conditionIcon setImage:[KEUIImageFactoryUtil imageDependsOnURL:observation.iconUrl]];
        NSString *string = [NSString stringWithFormat:@"%@ %@",[observation.temperatureC stringValue],@"°C"];
        self.templateView.currentTemperature.text = string;
        self.templateView.currentCondition.text = observation.weatherDescription;
        self.templateView.place.text = [NSString subStringBeforeFirstCommaInString:observation.location[@"full"]];
        self.templateView.windAbbreviation.text = observation.windShortAbbreviation;
        self.templateView.wind.text = [observation.windSpeed stringValue];
        self.templateView.humidity.text = observation.relativeHumidity;
        self.templateView.pressure.text = observation.pressure;
    }
    
}

- (void)updateUIForView:(KEWindowView *)viewtoUpdate observetion:(KEObservation *)observation
{
    if (observation) {
        [viewtoUpdate.conditionIcon setImage:[KEUIImageFactoryUtil imageDependsOnURL:observation.iconUrl]];
        NSString *string = [NSString stringWithFormat:@"%@ %@",[observation.temperatureC stringValue],@"°C"];
        viewtoUpdate.currentTemperature.text = string;
        viewtoUpdate.currentCondition.text = observation.weatherDescription;
        viewtoUpdate.place.text = [NSString subStringBeforeFirstCommaInString:observation.location[@"full"]];
        viewtoUpdate.windAbbreviation.text = observation.windShortAbbreviation;
        viewtoUpdate.wind.text = [observation.windSpeed stringValue];
        viewtoUpdate.humidity.text = observation.relativeHumidity;
        viewtoUpdate.pressure.text = observation.pressure;
        viewtoUpdate.timeStamp.text = observation.timeString;
    }
}

#pragma -  i add it
//
- (void)updateTommorowWithForecast:(KETommorowForecast *)forecast withView:(KEWindowView *)viewToUpdate
{
    [viewToUpdate.tomorrowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:forecast.iconURL]];
    viewToUpdate.tommorowTemp.text = forecast.highTemperature;
    NSLog(@" viewToUpdate.tommorowTemp.text %@", viewToUpdate.tommorowTemp.text );
    
//    NSLog(@"AfTom %@", forecast.conditionOnForecast  );
//    NSLog(@" %@", forecast.month  );
//    NSLog(@" %@", forecast.weekDay  );
//    NSLog(@" %@", forecast.dayNumber  );
//    NSLog(@" %@", forecast.yearNumber  );
//    NSLog(@" %@", forecast.humidity  );
//    NSLog(@" %@", forecast.wind  );
//    NSLog(@" %@", forecast.highTemperature  );
//    NSLog(@" %@", forecast.lowTemperature  );
}

- (void)updateAfterTomorrowWithForecast:(KEAfterTommorowForecast *)forecast withView:(KEWindowView *)viewToUpdate
{
    [viewToUpdate.afterTommorowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:forecast.iconURL]];
    viewToUpdate.afterTommorowTemp.text = forecast.highTemperature;

    
//    NSLog(@"AfTom %@", forecast.conditionOnForecast  );
//    NSLog(@" %@", forecast.month  );
//    NSLog(@" %@", forecast.weekDay  );
//    NSLog(@" %@", forecast.dayNumber  );
//    NSLog(@" %@", forecast.yearNumber  );
//    NSLog(@" %@", forecast.humidity  );
//    NSLog(@" %@", forecast.wind  );
//    NSLog(@" %@", forecast.highTemperature  );
//    NSLog(@" %@", forecast.lowTemperature  );
}

- (void)updateAfterAfterTommorowWithForecast:(KEAfterAfterTommorowForecast *)forecast withView:(KEWindowView *)viewToUpdate
{
    [viewToUpdate.afterAfterTommorowView setImageWithURL:[NSURL URLWithString:forecast.iconURL]];
    viewToUpdate.afrerAfterTommorowTemp.text = forecast.highTemperature;

    
//    NSLog(@"AfAfTom %@", forecast.conditionOnForecast  );
//    NSLog(@" %@", forecast.month  );
//    NSLog(@" %@", forecast.weekDay  );
//    NSLog(@" %@", forecast.dayNumber  );
//    NSLog(@" %@", forecast.yearNumber  );
//    NSLog(@" %@", forecast.humidity  );
//    NSLog(@" %@", forecast.wind  );
//    NSLog(@" %@", forecast.highTemperature  );
//    NSLog(@" %@", forecast.lowTemperature  );
}

#pragma mark - Requests

- (void)reloadData
{
    KEWeatherManager *client = [KEWeatherManager sharedClient];
    CLLocation *location = [[KELocationManager sharedManager] currentLocation];
    [SVProgressHUD show];
    
    __weak KEViewController *weakSelf = self;

    [client getCurrentWeatherObservationForLocation:location completion:^(KEObservation *observation, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        else {
             [weakSelf updateUIWithObservationForCurrentLocation:observation];
             [SVProgressHUD showSuccessWithStatus:@"Ok!"];
        }
    }];
    
    [client getForecastObservationForLocation:location completion:^(NSMutableDictionary *days, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        else {
             [weakSelf updateTommorowWithForecast:[days valueForKey:@"Tommorow"] withView:self.templateView];
             [weakSelf updateAfterTomorrowWithForecast:[days valueForKey:@"AfterTommorow"] withView:self.templateView];
             [weakSelf updateAfterAfterTommorowWithForecast:[days valueForKey:@"AfterAfterTommorow"] withView:self.templateView];
             [SVProgressHUD showSuccessWithStatus:@"Ok!"];
        }
    }];
}

- (void)reloadDataWithNewLocation:(CLLocation *)newLocation withView:(KEWindowView *)viewToUpdate
{
    KEWeatherManager *client = [KEWeatherManager sharedClient];
    [SVProgressHUD show];
    
    __weak KEViewController *weakSelf = self;
    
     [client getCurrentWeatherObservationForLocation:newLocation completion:^(KEObservation *observation, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        else {
            [weakSelf updateUIForView:viewToUpdate observetion:observation];
            [SVProgressHUD showSuccessWithStatus:@"Ok!"];
        }
    }];
    
    [client getForecastObservationForLocation:newLocation completion:^(NSMutableDictionary *days, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        else {
            [weakSelf updateTommorowWithForecast:[days valueForKey:@"Tommorow"] withView:viewToUpdate];
            [weakSelf updateAfterTomorrowWithForecast:[days valueForKey:@"AfterTommorow"] withView:viewToUpdate];
            [weakSelf updateAfterAfterTommorowWithForecast:[days valueForKey:@"AfterAfterTommorow"] withView:viewToUpdate];
            [SVProgressHUD showSuccessWithStatus:@"Ok!"];
        }
    }];
}

#pragma mark - Actions

- (IBAction)changePage:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(1024 * self.pageControl.currentPage, 0) animated:YES];
    self.pageControlBeingUsed = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segPop"]) {
        self.currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        self.mapViewController = [segue destinationViewController];
        [self.mapViewController setObjectToDelegate:self];
    }
}

- (IBAction)goToMap:(id)sender
{
    [self performSegueWithIdentifier:@"segPop" sender:self];
}

- (IBAction)refresh:(id)sender
{
    if ([[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
        if (self.pageControl.currentPage != 0) {
            NSError *error = nil;
            NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"]
                                                                       error:&error];
            
            self.entityArrayCoreData = [NSMutableArray arrayWithArray:places];
            
            self.loc = [[CLLocation alloc]initWithLatitude:[[self.entityArrayCoreData objectAtIndex:self.pageControl.currentPage - 1] latitude]
                                                 longitude:[[self.entityArrayCoreData objectAtIndex:self.pageControl.currentPage - 1] longitude]];
            
            if (self.pageControl.currentPage == [self.entityArrayCoreData count]) {
                [self reloadDataWithNewLocation:self.loc
                                       withView:[self.viewWithCoreData objectAtIndex:self.pageControl.currentPage - 1]];
            }
            else {
                [self reloadDataWithNewLocation:self.loc
                                       withView:[self.viewWithCoreData objectAtIndex:self.pageControl.currentPage - 1]];
            }
        }
        else {
            [self reloadData]; 
        }

    }
    else {
        [SVProgressHUD showErrorWithStatus:@"Internet dropped. Refresh unavailable."];
    }
}

- (void)addPressedWithCoordinate:(CLLocation *)location 
{
    if ([self.entityArrayCoreData count] == 0) {
        [self.entityArrayCoreData addObject:location];
    }
 
    [[self.currentPopoverSegue popoverController] dismissPopoverAnimated: YES];
    self.isShownMapPopover = NO;
    
    if (self.pageControl.numberOfPages == 20) {
        [SVProgressHUD showErrorWithStatus:@"Oops.. Sorry Maximum 20 cities"];
        return;
    }
    if (self.pageControl.numberOfPages < 20) {
        self.pageControl.numberOfPages += 1;
    }    
    if (self.pageControl.numberOfPages == 2) {
        KEWindowView *foo = [KEWindowView returnWindowView];
        foo.frame = CGRectMake(1076, 40/*30*/, 920, 580);
        [self.scrollView addSubview:foo];
        [self.viewWithCoreData addObject:foo];
        
        if ([self.entityArrayCoreData count] == 1) {
            [self.entityArrayCoreData addObject:location];
        }
     
        dispatch_queue_t dummyQueue = dispatch_queue_create("dummyQueue", nil);
        dispatch_async(dummyQueue, ^{
            [self reloadDataWithNewLocation:location withView:foo];
            });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(1024, 0) animated:YES];
        });
    }    
    else if (self.pageControl.numberOfPages > 2) {
        [self.entityArrayCoreData addObject:location];
        KEWindowView *bar = [KEWindowView returnWindowView];
        
        if (self.pageControl.currentPage == self.pageControl.numberOfPages - 2) {
            bar.frame = CGRectMake((self.scrollView.contentOffset.x + 1076), 40/*30*/, 920, 580);
        }
        else {
            bar.frame = CGRectMake((self.scrollView.contentOffset.x + 1024 * (self.pageControl.numberOfPages - self.pageControl.currentPage - 1) + 52), 40/*30*/, 920, 580);
        }
        
        [self.scrollView addSubview:bar];
        [self.viewWithCoreData addObject:bar];
        
        dispatch_queue_t dummyQueue = dispatch_queue_create("dummyQueue", nil);
        dispatch_async(dummyQueue, ^{
            [self reloadDataWithNewLocation:location withView:bar];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(1024 * (self.pageControl.numberOfPages - 1),0) animated:YES];
                //self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
        });
    }
    if (self.pageControlBeingUsed) {
        self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.pageControl.numberOfPages, self.scrollView.frame.size.height);
}

- (IBAction)deletePage:(id)sender
{
    if (self.pageControl.currentPage != 0) {
        [[self.viewWithCoreData objectAtIndex:self.pageControl.currentPage - 1 ] removeFromSuperview];
    }
    [UIView animateWithDuration:0.3 animations:^{
        for (UIView *dummyObject in self.viewWithCoreData) {
            NSUInteger index = [self.viewWithCoreData indexOfObject:dummyObject];
            if ((index > self.pageControl.currentPage -1) && (self.pageControl.currentPage != 0)) {
                CGRect fullScreenRect = CGRectMake(dummyObject.frame.origin.x - 1024, 40/*30*/, 920, 580);
                [dummyObject setFrame:fullScreenRect];
            }
        }
        if (self.pageControl.currentPage != 0) {
            [self.viewWithCoreData removeObjectAtIndex:self.pageControl.currentPage -1];
            [self.entityArrayCoreData removeObjectAtIndex:self.pageControl.currentPage -1];  

            NSError *error = nil;
            NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"]
                                                                       error:&error];
            if ([places count] > 0) {
                Place *aPlace = [places objectAtIndex:self.pageControl.currentPage - 1];
                [self.managedObjectContext deleteObject:aPlace];
                
                NSError *savingError = nil;
                if ([self.managedObjectContext save:&savingError]) {
                    NSLog(@"Successfully delete object");
                    NSLog(@"Array of entity is %@", [places description]);
                    self.entityArrayCoreData = [NSMutableArray arrayWithArray:places];
                }
                else {
                    NSLog(@"Fail to delete ");
                }
            }
            else {
                NSLog(@"Could not find entiyt in context");
           }
        }
        self.pageControl.numberOfPages = [self.viewWithCoreData count] + 1;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.pageControl.numberOfPages, self.scrollView.frame.size.height);
    }];
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (!self.pageControlBeingUsed) {
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	self.pageControlBeingUsed = NO;
}

#pragma mark - iOS 5.1 support 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

#pragma mark - Subscribing to reachability notifications and handling them on UI

- (void)subscribeToReachabilityNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onYesInternet) name:@"YesInternet" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNoInternet) name:@"NoInternet" object:nil];
}

- (void)onYesInternet
{
    [SVProgressHUD showSuccessWithStatus:@"Internet active"];
    if (self.internetDroppedFirstly) {
        self.internetDroppedFirstly = NO;
        [self viewDidLoad];
    }
}

- (void)onNoInternet
{
    [SVProgressHUD showErrorWithStatus:@"Internet dropped"];
}

- (void)viewDidUnload
{
    [self setNavBar:nil];
    
    [self setDownBar:nil];
    [super viewDidUnload];
}

@end
