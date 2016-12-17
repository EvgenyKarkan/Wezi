//
//  SUViewController.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEViewController.h"
#import "KEAfterAfterTommorowForecast.h"
#import "KEAfterTommorowForecast.h"
#import "KEDataManager.h"
#import "KEDecoratorUtil.h"
#import "KELocationManager.h"
#import "KEMailProvider.h"
#import "KEMapViewController.h"
#import "KEObservation.h"
#import "KEReachabilityUtil.h"
#import "KEShareViewController.h"
#import "KESocialProvider.h"
#import "KESplashScreenUtil.h"
#import "KEUIImageFactoryUtil.h"
#import "KEWeatherManager.h"
#import "KEWindowView.h"
#import "NSString+CommaSubString.h"
#import "Place.h"
#import "SVProgressHUD.h"

static NSUInteger const kKESelfWidth		  = 1024;
static NSUInteger const kKESelfWidthWithDelta = 1076;
static NSUInteger const kKEDeltaX			  = 52;
static NSUInteger const kKEDeltaY			  = 40;
static NSUInteger const kKEWindowW			  = 920;
static NSUInteger const kKEWindowH			  = 580;
static CGFloat	  const kKEShadowOffset		  = 4.0f;
static NSInteger  const kKELegitimateValue	  = 100;
static NSString * const kKERefreshButton      = @"refresh_button.png";
static NSString * const kKERefreshButtonClick = @"refresh_button_click.png";
static NSString * const kKETrashButton        = @"trash_button.png";
static NSString * const kKETrashButtonClick   = @"trash_button_click.png";
static NSString * const kKEPlusButton		  = @"plus_button.png";
static NSString * const kKEPlusButtonClick    = @"plus_button_click.png";
static NSString * const kKEShareButton        = @"share_button.png";
static NSString * const kKEShareButtonClick   = @"share_button_click.png";
static NSString * const kKENavBar			  = @"navbar.png";
static NSString * const kKEWeziLogo			  = @"wezi_logo.png";
static NSString * const kKEMapPopoverSegue    = @"segPop";
static NSString * const kKESharePopoverSegue  = @"shareSegue";
static NSString * const kKENoData			  = @"N/A";
static NSString * const kKEIconsBundle        = @"Icons.bundle";
static NSString * const kKEForecastBundle     = @"ForecastIcons.bundle";


@interface KEViewController () <UIScrollViewDelegate, KECoordinateFillProtocol, KEPopoverHideProtocol, KESocialProvideProtocol>

@property (nonatomic, strong) KEWindowView           *templateView;
@property (nonatomic, strong) KEObservation          *geo;
@property (nonatomic, strong) KEMapViewController    *mapViewController;
@property (nonatomic, strong) KEShareViewController  *shareViewController;
@property (nonatomic, strong) KEDataManager          *dataManager;
@property (nonatomic, strong) NSMutableArray         *entityArrayCoreData;
@property (nonatomic, strong) NSMutableArray         *viewWithCoreData;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CLLocation             *location;
@property (nonatomic, assign) BOOL isShownMapPopover;
@property (nonatomic, assign) BOOL pageControlBeingUsed;
@property (nonatomic, assign) BOOL internetDroppedFirstly;
@property (nonatomic, assign) BOOL internetDropped;

@end


@implementation KEViewController;

- (void)prepareForLoading
{
    NSError *error = nil;
    NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"]
                                                               error:&error];
    self.entityArrayCoreData = [NSMutableArray arrayWithArray:places];
    self.viewWithCoreData    = [[NSMutableArray alloc] init];
    
    NSUInteger counter = [places count];
    
	for (NSUInteger i = 1; i <= counter; i++) {
        KEWindowView *aView = [KEWindowView returnWindowView];
        aView.frame         = CGRectMake((self.scrollView.contentOffset.x + kKESelfWidth * i) + kKEDeltaX, kKEDeltaY, kKEWindowW, kKEWindowH);
        
		[self.scrollView addSubview:aView];
		[self.viewWithCoreData addObject:aView];
		
		CLLocation *location = [[CLLocation alloc]initWithLatitude:[places[i - 1] latitude]
		                                                 longitude:[places[i - 1] longitude]];
		
		[self reloadDataWithNewLocation:location withView:aView withHUD:NO];
	}
    self.pageControl.numberOfPages = [places count] + 1;
    self.scrollView.contentSize    = CGSizeMake(kKESelfWidth * ([places count] + 1), self.scrollView.contentSize.height);
}

#pragma mark - UIViewController life cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self subscribeToReachabilityNotifications];
	[self subscribeToCurrentLocationTrackingWithPemissionsNotification];
	
	static dispatch_once_t splash;
	dispatch_once(&splash, ^{
	    [KESplashScreenUtil showSplashScreenOnView:self.view];
	});
	
	if (![[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
		self.internetDroppedFirstly = YES;
		[self configurateUIElements];
		self.pageControl.numberOfPages = 1;
	}
	else {		
		__weak KEViewController *weakSelf = self;
		[[NSNotificationCenter defaultCenter] addObserverForName:kKELocationDidChangeNotificationKey
		                                                  object:nil
		                                                   queue:[NSOperationQueue mainQueue]
		                                              usingBlock: ^(NSNotification *note) {
														  [weakSelf reloadDataWithHUD:NO];
													  }];
		
		[[KELocationManager sharedManager] startMonitoringLocationChanges];
		
		[self configurateUIElements];
        
        self.dataManager          = [KEDataManager sharedDataManager];
        self.managedObjectContext = [self.dataManager managedObjectContextFromDataManager];
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
    
    self.templateView       = [KEWindowView returnWindowView];
    self.templateView.frame = CGRectMake(kKEDeltaX, kKEDeltaY, kKEWindowW, kKEWindowH);
    [self.scrollView addSubview:self.templateView];
	
	if ((![KELocationManager sharedManager].currentLocation) || (![[KEReachabilityUtil sharedUtil] checkInternetConnection])) {
		for (UIView *subview in [self.templateView subviews]) {
			if (!subview.hidden) {
				subview.hidden = YES;
			}
		}
        self.templateView.sadView.hidden       = NO;
        self.templateView.backImageView.hidden = NO;
	}
	
    self.mapViewController                  = [[KEMapViewController alloc]init];
    self.mapViewController.objectToDelegate = self;
    self.isShownMapPopover = NO;
    
    self.navBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    
    UIImage *backgroundImage = [KEViewController imageWithImage: [UIImage imageNamed:kKENavBar] scaledToSize: self.navBar.frame.size]; //;
    [self.navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [KEDecoratorUtil decorateWithShadow:self.navBar withOffsetValue: kKEShadowOffset];
    [KEDecoratorUtil decorateWithShadow:self.downBar withOffsetValue: -kKEShadowOffset];
    self.weziImage.image = [UIImage imageNamed:kKEWeziLogo];
    
    [self addCustomButtons];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)addCustomButtons
{
		//#warning Magic
		//TODO: add pixel perfect stuff below !!!
	UIButton *refresh = [[UIButton alloc] initWithFrame:CGRectMake(959, 20, 60, 30)];
	[refresh setImage:[UIImage imageNamed:kKERefreshButton] forState:UIControlStateNormal];
	[refresh setImage:[UIImage imageNamed:kKERefreshButtonClick] forState:UIControlStateHighlighted];
	[refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
	UIButton *trash = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 60, 30)];
	[trash setImage:[UIImage imageNamed:kKETrashButton] forState:UIControlStateNormal];
	[trash setImage:[UIImage imageNamed:kKETrashButtonClick] forState:UIControlStateHighlighted];
	[trash addTarget:self action:@selector(deletePage:) forControlEvents:UIControlEventTouchUpInside];
    
	[self.navBar addSubview:refresh];
	[self.navBar addSubview:trash];
    
	UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 60, 30)];
	[add setImage:[UIImage imageNamed:kKEPlusButton] forState:UIControlStateNormal];
	[add setImage:[UIImage imageNamed:kKEPlusButtonClick] forState:UIControlStateHighlighted];
	[add addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
    
	UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(959, 10, 60, 30)];
	[share setImage:[UIImage imageNamed:kKEShareButton] forState:UIControlStateNormal];
	[share setImage:[UIImage imageNamed:kKEShareButtonClick] forState:UIControlStateHighlighted];
	[share addTarget:self action:@selector(showSharePopover) forControlEvents:UIControlEventTouchUpInside];
    
	[self.downBar addSubview:add];
	[self.downBar addSubview:share];
}

- (void)updateUIWithObservationForCurrentLocation:(KEObservation *)observation forecastDays:(NSMutableDictionary *)days
{
	if (observation) {
		[self.templateView.conditionIcon setImage:[KEUIImageFactoryUtil imageDependsOnURL:observation.iconUrl bundleName:kKEIconsBundle]];
		
		if (([observation.temperatureC floatValue] < -kKELegitimateValue) || ([observation.temperatureC floatValue] > kKELegitimateValue)) {
			self.templateView.currentTemperature.text = kKENoData;
		}
		else {
			NSString *string = [NSString stringWithFormat:@"%.1f %@", [observation.temperatureC floatValue], @"°C"];
			self.templateView.currentTemperature.text = string;
		}
		
		self.templateView.currentCondition.text = observation.weatherDescription;
		self.templateView.place.text = [NSString subStringBeforeFirstCommaInString:observation.location[@"full"]];
		self.templateView.windAbbreviation.text = observation.windShortAbbreviation;
		
		if ([observation.windSpeed floatValue] < 0.0f) {
			self.templateView.wind.text = kKENoData;
		}
		else {
			self.templateView.wind.text = [NSString stringWithFormat:@"%.1f %@", [observation.windSpeed floatValue], @"kph"];
		}
		
		if (([observation.relativeHumidity integerValue] < 0) || ([observation.relativeHumidity integerValue] > kKELegitimateValue)) {
			self.templateView.humidity.text = kKENoData;
		}
		else {
			self.templateView.humidity.text = observation.relativeHumidity;
		}
		
		if (([observation.pressure floatValue] < 0.0f) || ([observation.pressure floatValue] > 50.0f)) {
			self.templateView.pressure.text = kKENoData;
		}
		else {
			self.templateView.pressure.text = [NSString stringWithFormat:@"%.2f %@", [observation.pressure floatValue], @"inHg"];
		}
		
		self.templateView.timeStamp.text = observation.timeString;
		
		[self.templateView.tomorrowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:((KETommorowForecast *)[days valueForKey:@"Tommorow"]).iconURL
																			  bundleName:kKEIconsBundle]];
		self.templateView.tommorowTemp.text = [NSString stringWithFormat:@"%@ %@", ((KETommorowForecast *)[days valueForKey:@"Tommorow"]).highTemperature, @"°C"];
		self.templateView.dateT.text = [NSString stringWithFormat:@"%@, %@ of %@",
										 ((KETommorowForecast *)[days valueForKey:@"Tommorow"]).weekDay,
										 [((KETommorowForecast *)[days valueForKey:@"Tommorow"]).dayNumber stringValue],
										 ((KETommorowForecast *)[days valueForKey:@"Tommorow"]).month];
		
		[self.templateView.afterTommorowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:((KEAfterTommorowForecast *)[days valueForKey:@"AfterTommorow"]).iconURL																		   bundleName:kKEIconsBundle]];
		self.templateView.afterTommorowTemp.text = [NSString stringWithFormat:@"%@ %@",
													((KEAfterTommorowForecast *)[days valueForKey:@"AfterTommorow"]).highTemperature, @"°C"];
		self.templateView.dateAT.text = [NSString stringWithFormat:@"%@, %@ of %@",
										  ((KEAfterTommorowForecast *)[days valueForKey:@"AfterTommorow"]).weekDay,
										  [((KEAfterTommorowForecast *)[days valueForKey:@"AfterTommorow"]).dayNumber stringValue],
										  ((KEAfterTommorowForecast *)[days valueForKey:@"AfterTommorow"]).month];
		
		[self.templateView.afterAfterTommorowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:
															((KEAfterAfterTommorowForecast *)[days valueForKey:@"AfterAfterTommorow"]).iconURL
																						bundleName:kKEIconsBundle]];
		self.templateView.afrerAfterTommorowTemp.text = [NSString stringWithFormat:@"%@ %@",
														 ((KEAfterAfterTommorowForecast *)[days valueForKey:@"AfterAfterTommorow"]).highTemperature, @"°C"];
		self.templateView.dateAAT.text = [NSString stringWithFormat:@"%@, %@ of %@",
										  ((KEAfterAfterTommorowForecast *)[days valueForKey:@"AfterAfterTommorow"]).weekDay,
										  [((KEAfterAfterTommorowForecast *)[days valueForKey:@"AfterAfterTommorow"]).dayNumber stringValue],
										  ((KEAfterAfterTommorowForecast *)[days valueForKey:@"AfterAfterTommorow"]).month];
	}
}

- (void)updateUIForView:(KEWindowView *)viewtoUpdate observation:(KEObservation *)observation
{
	if (observation) {
		[viewtoUpdate.conditionIcon setImage:[KEUIImageFactoryUtil imageDependsOnURL:observation.iconUrl bundleName:kKEIconsBundle]];
		
		if (([observation.temperatureC floatValue] < -kKELegitimateValue) || ([observation.temperatureC floatValue] > kKELegitimateValue)) {
			viewtoUpdate.currentTemperature.text = kKENoData;
		}
		else {
			NSString *string = [NSString stringWithFormat:@"%.1f %@", [observation.temperatureC floatValue], @"°C"];
			viewtoUpdate.currentTemperature.text = string;
		}
		
		viewtoUpdate.currentCondition.text = observation.weatherDescription;
		viewtoUpdate.place.text = [NSString subStringBeforeFirstCommaInString:observation.location[@"full"]];
		viewtoUpdate.windAbbreviation.text = observation.windShortAbbreviation;
		
		if ([observation.windSpeed floatValue] < 0.0f) {
			viewtoUpdate.wind.text = kKENoData;
		}
		else {
			viewtoUpdate.wind.text = [NSString stringWithFormat:@"%.1f %@", [observation.windSpeed floatValue], @"kph"];
		}
		
		if (([observation.relativeHumidity integerValue] < 0) || ([observation.relativeHumidity integerValue] > kKELegitimateValue)) {
			viewtoUpdate.humidity.text = kKENoData;
		}
		else {
			viewtoUpdate.humidity.text = observation.relativeHumidity;
		}
		
		if (([observation.pressure floatValue] < 0.0f) || ([observation.pressure floatValue] > 50.0f)) {
			viewtoUpdate.pressure.text = kKENoData;
		}
		else {
			viewtoUpdate.pressure.text = [NSString stringWithFormat:@"%.2f %@", [observation.pressure floatValue], @"inHg"];
		}
		
		viewtoUpdate.timeStamp.text = observation.timeString;
	}
}

- (void)updateTommorowWithForecast:(KETommorowForecast *)forecast withView:(KEWindowView *)viewToUpdate
{
	[viewToUpdate.tomorrowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:forecast.iconURL bundleName:kKEForecastBundle]];
	viewToUpdate.tommorowTemp.text = [NSString stringWithFormat:@"%@ %@", forecast.highTemperature, @"°C"];
	viewToUpdate.dateT.text = [NSString stringWithFormat:@"%@, %@ of %@", forecast.weekDay, [forecast.dayNumber stringValue], forecast.month];
}

- (void)updateAfterTomorrowWithForecast:(KEAfterTommorowForecast *)forecast withView:(KEWindowView *)viewToUpdate
{
    [viewToUpdate.afterTommorowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:forecast.iconURL bundleName:kKEForecastBundle]];
    viewToUpdate.afterTommorowTemp.text = [NSString stringWithFormat:@"%@ %@",forecast.highTemperature,@"°C"];
    viewToUpdate.dateAT.text = [NSString stringWithFormat:@"%@, %@ of %@", forecast.weekDay, [forecast.dayNumber stringValue], forecast.month];
}

- (void)updateAfterAfterTommorowWithForecast:(KEAfterAfterTommorowForecast *)forecast withView:(KEWindowView *)viewToUpdate
{
	[viewToUpdate.afterAfterTommorowView setImage:[KEUIImageFactoryUtil imageDependsOnURL:forecast.iconURL bundleName:kKEForecastBundle]];
	viewToUpdate.afrerAfterTommorowTemp.text = [NSString stringWithFormat:@"%@ %@", forecast.highTemperature, @"°C"];
	viewToUpdate.dateAAT.text = [NSString stringWithFormat:@"%@, %@ of %@", forecast.weekDay, [forecast.dayNumber stringValue], forecast.month];
}

#pragma mark - Current location permissions handling

- (void)handleCurrentLocationPermission:(NSNotification *)notification
{
	if ([(notification.userInfo)[@"Access"] isEqualToString:@"CurrentLocation"]) {
		for (UIView *subview in [self.templateView subviews]) {
			if (subview.hidden) {
				subview.hidden = NO;
			}
		}
		if (!self.templateView.sadView.hidden) {
			self.templateView.sadView.hidden = YES;
		}
		[self refreshCurrentLocation];
	}
	else {
		for (UIView *subview in [self.templateView subviews]) {
			if (!subview.hidden) {
				subview.hidden = YES;
			}
		}
		self.templateView.backImageView.hidden = NO;
		if (self.templateView.sadView.hidden) {
			self.templateView.sadView.hidden = NO;
		}
	}
}

- (void)refreshCurrentLocation
{	
	if ([KELocationManager sharedManager].currentLocation) {
		[[KELocationManager sharedManager] startMonitoringLocationChanges];
		for (UIView *subview in [self.templateView subviews]) {
			if (subview.hidden) {
				subview.hidden = NO;
			}
		}
		self.templateView.sadView.hidden = YES;
	}
	else {
		[[KELocationManager sharedManager] startMonitoringLocationChanges];
	}
}

#pragma mark - Requests stuff

- (void)reloadDataWithHUD:(BOOL)isHUD
{
	KEWeatherManager *client = [KEWeatherManager sharedClient];
	CLLocation *location = [[KELocationManager sharedManager] currentLocation];
	
	if (isHUD) {
		[SVProgressHUD show];
	}

	__weak KEViewController *weakSelf = self;
	
	[client getCurrentWeatherObservationForLocation:location completion: ^(KEObservation *observation, NSMutableDictionary *days, NSError *error) {
	    if (error) {
	        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
		}
	    else {
	        [weakSelf updateUIWithObservationForCurrentLocation:observation forecastDays:days];
	        if (isHUD) {
	            [SVProgressHUD showSuccessWithStatus:@"Data has been updated"];
			}
		}
	}];
}

	//#warning MAgic strings
- (void)reloadDataWithNewLocation:(CLLocation *)newLocation withView:(KEWindowView *)viewToUpdate withHUD:(BOOL)isHUD
{
	KEWeatherManager *client = [KEWeatherManager sharedClient];
	
	if (isHUD) {
		[SVProgressHUD show];
	}
	
	__weak KEViewController *weakSelf = self;
	
	[client getCurrentWeatherObservationForLocation:newLocation completion: ^(KEObservation *observation, NSMutableDictionary *days, NSError *error) {
	    if (error) {
	        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
		}
	    else {
	        [weakSelf updateUIForView:viewToUpdate observation:observation];
	        [weakSelf updateTommorowWithForecast:[days valueForKey:@"Tommorow"] withView:viewToUpdate];
	        [weakSelf updateAfterTomorrowWithForecast:[days valueForKey:@"AfterTommorow"] withView:viewToUpdate];
	        [weakSelf updateAfterAfterTommorowWithForecast:[days valueForKey:@"AfterAfterTommorow"] withView:viewToUpdate];
	        if (isHUD) {
	            [SVProgressHUD showSuccessWithStatus:@"Data has been updated"];
			}
		}
	}];
}

#pragma mark - Actions stuff

- (IBAction)changePage:(id)sender
{
	[self.scrollView setContentOffset:CGPointMake(kKESelfWidth * self.pageControl.currentPage, 0) animated:YES];
	self.pageControlBeingUsed = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:kKEMapPopoverSegue]) {
		self.currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
		self.mapViewController = [segue destinationViewController];
		[self.mapViewController setObjectToDelegate:self];
	}
	if ([[segue identifier] isEqualToString:kKESharePopoverSegue]) {
		self.currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
		self.shareViewController = [segue destinationViewController];
		[self.shareViewController setFirstDelegate:self];
		[self.shareViewController setSecondDelegate:self];
	}
}

- (IBAction)goToMap:(id)sender
{
	if (self.pageControl.numberOfPages == 5/*20*/) {
        [SVProgressHUD showErrorWithStatus:@"Maximum 5 cities for this version of Wezi"];
        return;
    }
	
    [self performSegueWithIdentifier:kKEMapPopoverSegue sender:self];
}

- (IBAction)refresh:(id)sender
{
	if ([[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
		if (self.pageControl.currentPage != 0) {
			NSError *error = nil;
			NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"]
			                                                           error:&error];
			
			self.entityArrayCoreData = [NSMutableArray arrayWithArray:places];
			
			self.location = [[CLLocation alloc]initWithLatitude:[(self.entityArrayCoreData)[self.pageControl.currentPage - 1] latitude]
													  longitude:[(self.entityArrayCoreData)[self.pageControl.currentPage - 1] longitude]];
			
			if (self.pageControl.currentPage == [self.entityArrayCoreData count]) {
				[self reloadDataWithNewLocation:self.location
				                       withView:(self.viewWithCoreData)[self.pageControl.currentPage - 1]
										withHUD:YES];
			}
			else {
				[self reloadDataWithNewLocation:self.location
				                       withView:(self.viewWithCoreData)[self.pageControl.currentPage - 1]
										withHUD:YES];
			}
		}
		else {
			[self reloadDataWithHUD:YES];
		}
	}
	else {
		[SVProgressHUD showErrorWithStatus:@"Internet dropped. Refresh unavailable"];
	}
}

- (void)addPressedWithCoordinate:(CLLocation *)location 
{
    if ([self.entityArrayCoreData count] == 0) {
        [self.entityArrayCoreData addObject:location];
    }
 
    [[self.currentPopoverSegue popoverController] dismissPopoverAnimated: YES];
    self.isShownMapPopover = NO;
    
    if (self.pageControl.numberOfPages < 5/*20*/) {
        self.pageControl.numberOfPages += 1;
    }    
    if (self.pageControl.numberOfPages == 2) {
        KEWindowView *foo = [KEWindowView returnWindowView];
        foo.frame = CGRectMake(kKESelfWidthWithDelta, kKEDeltaY, kKEWindowW, kKEWindowH);
        [self.scrollView addSubview:foo];
        [self.viewWithCoreData addObject:foo];
        
        if ([self.entityArrayCoreData count] == 1) {
            [self.entityArrayCoreData addObject:location];
        }
     
        dispatch_queue_t dummyQueue = dispatch_queue_create("dummyQueue", nil);
        dispatch_async(dummyQueue, ^{
            [self reloadDataWithNewLocation:location withView:foo withHUD:NO];
		});
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(kKESelfWidth, 0) animated:YES];
        });
    }    
    else if (self.pageControl.numberOfPages > 2) {
        [self.entityArrayCoreData addObject:location];
        KEWindowView *bar = [KEWindowView returnWindowView];
        
        if (self.pageControl.currentPage == self.pageControl.numberOfPages - 2) {
            bar.frame = CGRectMake((self.scrollView.contentOffset.x + kKESelfWidthWithDelta), kKEDeltaY, kKEWindowW, kKEWindowH);
        }
        else {
            bar.frame = CGRectMake((self.scrollView.contentOffset.x + kKESelfWidth * (self.pageControl.numberOfPages - self.pageControl.currentPage - 1) + kKEDeltaX), kKEDeltaY, kKEWindowW, kKEWindowH);
        }
        
        [self.scrollView addSubview:bar];
        [self.viewWithCoreData addObject:bar];
        
        dispatch_queue_t dummyQueue = dispatch_queue_create("dummyQueue", nil);
        dispatch_async(dummyQueue, ^{
            [self reloadDataWithNewLocation:location withView:bar withHUD:NO];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(kKESelfWidth * (self.pageControl.numberOfPages - 1),0) animated:YES];
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
		[(self.viewWithCoreData)[self.pageControl.currentPage - 1] removeFromSuperview];
	}
	else if (self.pageControl.currentPage == 0) {
		[SVProgressHUD showErrorWithStatus:@"You can not delete the current location place"];
	}
	[UIView animateWithDuration:0.3f animations: ^{
	    for (UIView * dummyObject in self.viewWithCoreData) {
	        NSUInteger index = [self.viewWithCoreData indexOfObject:dummyObject];
	        if ((index > self.pageControl.currentPage - 1) && (self.pageControl.currentPage != 0)) {
	            CGRect fullScreenRect = CGRectMake(dummyObject.frame.origin.x - kKESelfWidth, kKEDeltaY, kKEWindowW, kKEWindowH);
	            [dummyObject setFrame:fullScreenRect];
			}
		}
		
	    if (self.pageControl.currentPage != 0) {
	        [self.viewWithCoreData removeObjectAtIndex:self.pageControl.currentPage - 1];
	        [self.entityArrayCoreData removeObjectAtIndex:self.pageControl.currentPage - 1];
			
	        NSError *error = nil;
	        NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"]
	                                                                   error:&error];
	        if ([places count] > 0) {
	            Place *aPlace = places[self.pageControl.currentPage - 1];
	            [self.managedObjectContext deleteObject:aPlace];
				
	            NSError *savingError = nil;
	            if ([self.managedObjectContext save:&savingError]) {
	                self.entityArrayCoreData = [NSMutableArray arrayWithArray:places];
				}
	            else {
					[SVProgressHUD showErrorWithStatus:@"Fail to delete"];
				}
			}
	        else {
				[SVProgressHUD showErrorWithStatus:@"Could not find entity in context"];
			}
		}
	    self.pageControl.numberOfPages = [self.viewWithCoreData count] + 1;
	    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.pageControl.numberOfPages, self.scrollView.frame.size.height);
	}];
}

- (void)showSharePopover
{	
    [self performSegueWithIdentifier:kKESharePopoverSegue sender:self];
}

#pragma mark - ScrollView delegate stuff

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
	if (!self.pageControlBeingUsed) {
		CGFloat pageWidth = self.scrollView.frame.size.width;
		NSInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
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

#pragma mark - Social delegate

- (void)provideSocialMediaWithSender:(id)sender
{
	[KESocialProvider provideSocialMediaWithSender:sender withObject:self];
}

- (void)hideSharePopover
{
	[[self.currentPopoverSegue popoverController] dismissPopoverAnimated:YES];
}

#pragma mark - Mail composer delegate method

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	switch (result) {
		case MFMailComposeResultCancelled:
			break;
			
		case MFMailComposeResultSaved:
			break;
			
		case MFMailComposeResultSent:
			[SVProgressHUD showSuccessWithStatus:@"Mail sent"];
			break;
			
		case MFMailComposeResultFailed:
			[SVProgressHUD showErrorWithStatus:@"Mail failed"];
			break;
			
		default:
			break;
	}
	
	[self dismissViewControllerAnimated:YES completion:nil];
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
	//#warning Magic strings
- (void)subscribeToReachabilityNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onYesInternet) name:@"YesInternet" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNoInternet) name:@"NoInternet" object:nil];
}

- (void)onYesInternet
{
	if (self.internetDropped) {
		[SVProgressHUD showSuccessWithStatus:@"Internet active"];
	}
	
	if (self.internetDroppedFirstly) {
		self.internetDroppedFirstly = NO;
		[self viewDidLoad];
	}
}

- (void)onNoInternet
{
    [SVProgressHUD showErrorWithStatus:@"Internet dropped"];
	self.internetDropped = YES;
}

#pragma mark - Subscribing to location permissions notifications

- (void)subscribeToCurrentLocationTrackingWithPemissionsNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCurrentLocationPermission:)
                                                 name:@"HandlePermissions"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshCurrentLocation)
                                                 name:@"RefreshCurrentLocation"
                                               object:nil];
}

@end
