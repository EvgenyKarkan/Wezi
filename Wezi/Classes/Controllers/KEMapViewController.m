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

@interface KEMapViewController ()

@property (nonatomic, strong)       CLGeocoder *geocoder;
@property (nonatomic, strong)       KECityAnnotation *myAnnotation;
@property (nonatomic, strong)       NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)       KEViewController *viewController;
@property (nonatomic, readwrite)    BOOL isContextActivated;

@end

@implementation KEMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.map.delegate = self;
    self.geocoder = [[CLGeocoder alloc]init];
    self.map.showsUserLocation = YES;
    self.viewController = [[KEViewController alloc]init];
    self.isContextActivated = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
	if (oldState == MKAnnotationViewDragStateDragging) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:self.myAnnotation.coordinate.latitude  longitude:self.myAnnotation.coordinate.longitude];
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
             if (error) {return;}
             
             NSString *geocodedAddress;
             NSString *geocodedHome;
             NSString *geoLocality;
             NSString *geoSublocality;
             
             if (placemarks && placemarks.count > 0) {
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 
                 geocodedAddress = placemark.thoroughfare;
                 geocodedHome = placemark.subThoroughfare;
                 geoLocality = placemark.locality; //city
                 geoSublocality = placemark.name;
             }
            
             NSString *fooSubtitle;
             NSString *fooTitle;
             
                 if (geocodedAddress) {
                     if (geocodedHome) {
                         fooSubtitle = [NSString stringWithFormat:@"%@,%@", geocodedAddress,geocodedHome];
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

- (void)performPinDrop
{
    self.myAnnotation = [[KECityAnnotation alloc] init];
    self.myAnnotation.coordinate = self.map.centerCoordinate;
    self.myAnnotation.title = @"Chosen location";
    self.myAnnotation.subtitle = @"Drag to change location";
    [self.map addAnnotation:self.myAnnotation];
    [self.map selectAnnotation:self.myAnnotation animated:YES];
    
}

- (IBAction)dropPinPressed:(id)sender
{
    [self performPinDrop];
}

- (IBAction)chooseLocation:(id)sender
{
    CLLocation *item = [[CLLocation alloc]initWithLatitude:self.myAnnotation.coordinate.latitude longitude:self.myAnnotation.coordinate.longitude];
    
    [self.objectToDelegate addPressedWithCoordinate:item];
 
    // creating Entity 
    KEAppDelegate *appDelegate = (KEAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequst = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    [fetchRequst setEntity:entity];
    
    NSError *error = nil;
    NSArray *places = [self.managedObjectContext executeFetchRequest:fetchRequst error:&error];
    if ([places count] == 19) {
        NSLog(@" COUNT IS %i", [places count]);
            return;
    }

    Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    
    if (place != nil) {
        place.latitude = self.myAnnotation.coordinate.latitude;
        place.longitude = self.myAnnotation.coordinate.longitude;
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"Successfully saving the context");
            self.isContextActivated = YES;
        }
        else {
            NSLog(@"Failed to save the context. Error = %@", [savingError localizedDescription]);
        }
    }
    else {
        NSLog(@"Failed to create new place");
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Foo" object:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[KECityAnnotation class]]) {
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        if (pinView ==nil) {
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Pin"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout =YES;
            pinView.draggable = YES;
        }
        return pinView;
    }
    else {
        return nil;
    }
}

@end
