//
//  KEMapViewController.m
//  Wezi
//
//  Created by Evgeniy Karkan on 5/8/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEMapViewController.h"
#import "KECityAnnotation.h"
#import "Place.h"
#import "KEAppDelegate.h"
#import "KEViewController.h"
#import "KEDataManager.h"
#import "KEReachabilityUtil.h"
#import "SVProgressHUD.h"

static NSString * const kKENavBar			  = @"navbar.png";
static NSString * const kKEPlusButton		  = @"plus_button.png";
static NSString * const kKEPlusButtonClick    = @"plus_button_click.png";
static NSString * const kKEDoneButton		  = @"done_button.png";
static NSString * const kKEDoneButtonClick    = @"done_button_click.png";

@interface KEMapViewController ()

@property (nonatomic, strong)       CLGeocoder *geocoder;
@property (nonatomic, strong)       NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)       KECityAnnotation *myAnnotation;
@property (nonatomic, strong)       KEDataManager *dataManager;
@property (nonatomic, readwrite)    BOOL isContextActivated;
@property (nonatomic, strong)       NSString *bufferCityName;

@end

@implementation KEMapViewController

#pragma mark - Viewcontroller live cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.map.delegate = self;
	self.geocoder = [[CLGeocoder alloc]init];
    self.map.showsUserLocation = YES;
    self.isContextActivated = NO;
    self.dataManager = [KEDataManager sharedDataManager];
	self.managedObjectContext = [self.dataManager managedObjectContextFromAppDelegate];
    [self addCustomButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - MapView delegate method & geocoding

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
	if (oldState == MKAnnotationViewDragStateDragging) {
		CLLocation *location = [[CLLocation alloc] initWithLatitude:self.myAnnotation.coordinate.latitude longitude:self.myAnnotation.coordinate.longitude];
		[self.geocoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks, NSError *error) {
		    if (error) {
		        return;
			}
			
		    NSString *geocodedAddress;
		    NSString *geocodedHome;
		    NSString *geoLocality;
		    NSString *geoSublocality;
			
		    if (placemarks && placemarks.count > 0) {
		        CLPlacemark *placemark = [placemarks objectAtIndex:0];
				
		        geocodedAddress = placemark.thoroughfare;
		        geocodedHome = placemark.subThoroughfare;
		        geoLocality = placemark.locality;
		        geoSublocality = placemark.name;
			}
			
		    NSString *fooSubtitle;
		    NSString *fooTitle;
			
		    if (geocodedAddress) {
		        if (geocodedHome) {
		            fooSubtitle = [NSString stringWithFormat:@"%@,%@", geocodedAddress, geocodedHome];
				}
		        else {
		            fooSubtitle = [NSString stringWithFormat:@"%@", geocodedAddress];
				}
			}
		    else {
		        fooSubtitle = [NSString stringWithFormat:@"%@", geoSublocality];
			}
		    if (geoLocality) {
		        fooTitle = [NSString stringWithFormat:@"%@", geoLocality];
		        self.bufferCityName = fooSubtitle;
			}
		    else {
		        fooTitle = [NSString stringWithFormat:@"%@", geoSublocality];
			}
			
		    if (fooSubtitle != nil) {
		        [self.myAnnotation performSelector:@selector(setSubtitle:)
		                                withObject:fooSubtitle];
			}
		    if (fooTitle != nil) {
		        [self.myAnnotation performSelector:@selector(setTitle:)
		                                withObject:fooTitle];
			}
		}];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation> )annotation
{
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}
	if ([annotation isKindOfClass:[KECityAnnotation class]]) {
		MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
		if (pinView == nil) {
			pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Pin"];
			pinView.pinColor = MKPinAnnotationColorRed;
			pinView.animatesDrop = YES;
			pinView.canShowCallout = YES;
			pinView.draggable = YES;
			[pinView setSelected:YES animated:YES];
		}
		return pinView;
	}
	else {
		return nil;
	}
}

#pragma mark - Actions 

- (IBAction)chooseLocation:(id)sender
{
	CLLocation *item = [[CLLocation alloc]initWithLatitude:self.myAnnotation.coordinate.latitude longitude:self.myAnnotation.coordinate.longitude];
	
	if ([[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
		[self.objectToDelegate addPressedWithCoordinate:item];
	}
	
	NSError *error = nil;
	NSArray *places = [self.managedObjectContext executeFetchRequest:[self.dataManager requestWithEntityName:@"Place"] error:&error];
	
	if ([places count] == 19) {
		NSLog(@"COUNT IS %i", [places count]);
		return;
	}
	
	Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
	
	if (place != nil) {
		place.latitude = self.myAnnotation.coordinate.latitude;
		place.longitude = self.myAnnotation.coordinate.longitude;
		place.city = self.bufferCityName;
		NSError *savingError = nil;
		
		if ([[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
			if ([self.managedObjectContext save:&savingError]) {
				NSLog(@"Successfully saving the context");
				self.isContextActivated = YES;
			}
			else {
				NSLog(@"Failed to save the context. Error = %@", [savingError localizedDescription]);
			}
		}
		else {
			[SVProgressHUD showErrorWithStatus:@"Internet dropped. Couldn't save the location"];
		}
	}
	else {
		NSLog(@"Failed to create new place");
	}
}

- (IBAction)dropPinPressed:(id)sender
{
    [self performPinDrop];
}

- (void)performPinDrop
{
    self.myAnnotation = [[KECityAnnotation alloc] init];
    self.myAnnotation.coordinate = self.map.centerCoordinate;
    self.myAnnotation.title = @"Chosen location";
    self.myAnnotation.subtitle = @"Drag to change location";
    [self.map addAnnotation:self.myAnnotation];
    [self.map selectAnnotation:self.myAnnotation animated:YES];
}

#pragma mark - Configurate UI 

- (void)addCustomButtons
{
    UIImage *backgroundImage = [UIImage imageNamed:kKENavBar];
    [self.mapNavBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIButton *done = [[UIButton alloc] initWithFrame:CGRectMake(475, 5, 60, 30)];
    [done setImage:[UIImage imageNamed:kKEDoneButton] forState:UIControlStateNormal];
    [done setImage:[UIImage imageNamed:kKEDoneButtonClick] forState:UIControlStateHighlighted];
    [done addTarget:self action:@selector(chooseLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *plus = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60, 30)];
    [plus setImage:[UIImage imageNamed:kKEPlusButton] forState:UIControlStateNormal];
    [plus setImage:[UIImage imageNamed:kKEPlusButtonClick] forState:UIControlStateHighlighted];
    [plus addTarget:self action:@selector(dropPinPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapNavBar addSubview:done];
    [self.mapNavBar addSubview:plus];
}

@end
