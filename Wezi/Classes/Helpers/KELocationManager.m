//
//  KELocationManager.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KELocationManager.h"
#import "Flurry.h"

NSString * const kKELocationDidChangeNotificationKey = @"locationManagerlocationDidChange";
static NSUInteger const kKEFilter = 1000;

@interface KELocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong)    CLLocationManager *locationManager;
@property (nonatomic, assign)    BOOL isMonitoringLocation;
@property (nonatomic, assign)    BOOL isPermitted;

@end

@implementation KELocationManager

#pragma mark - Singleton stuff

static id _sharedLocationManager = nil;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationManager = [[KELocationManager alloc] init];
    });
    
    return _sharedLocationManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationManager = nil;
        _sharedLocationManager = [super allocWithZone:zone];
    });
    
    return _sharedLocationManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Public API

- (void)startMonitoringLocationChanges
{
    if ([CLLocationManager locationServicesEnabled]) {
        if (!self.isMonitoringLocation) {
            self.isMonitoringLocation = YES;
            self.locationManager.delegate = self;
            [self.locationManager startMonitoringSignificantLocationChanges];
        }
    }
	else {
		UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
		                                                                message:@"This app requires location services to be enabled"
		                                                               delegate:nil
		                                                      cancelButtonTitle:@"OK"
		                                                      otherButtonTitles:nil];
		[servicesDisabledAlert show];
	}
}

- (void)stopMonitoringLocationChanges
{
    if (_locationManager) {
        [self.locationManager stopMonitoringSignificantLocationChanges];
        self.locationManager.delegate = nil;
        self.isMonitoringLocation = NO;
        self.locationManager = nil;
    }
}

#pragma mark - Accessors

- (CLLocationManager *)locationManager
{
	if (!_locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
		[_locationManager setDistanceFilter:kKEFilter];
		[_locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
	}
	
	return _locationManager;
}

- (CLLocation *)currentLocation
{
    return self.locationManager.location;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    if (newLocation) {
        userInfo[@"newLocation"] = newLocation;
    }
    if (oldLocation) {
        userInfo[@"oldLocation"] = oldLocation;
    }
    
		[[NSNotificationCenter defaultCenter] postNotificationName:kKELocationDidChangeNotificationKey
															object:self
														  userInfo:userInfo];
	[Flurry setLatitude:manager.location.coordinate.latitude
			  longitude:manager.location.coordinate.longitude
	 horizontalAccuracy:manager.location.horizontalAccuracy
	   verticalAccuracy:manager.location.verticalAccuracy];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	if ([error code] == kCLErrorDenied) {
		UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Denied"
		                                                                message:@"This app requires current location services to be allowed"
		                                                               delegate:nil
		                                                      cancelButtonTitle:@"OK"
		                                                      otherButtonTitles:nil];
		[servicesDisabledAlert show];
	}
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	NSString *value = nil;
	
	if (status == kCLAuthorizationStatusDenied) {
		value = @"NoCurrentLocation";
	}
	else if (status == kCLAuthorizationStatusAuthorized) {
		value = @"CurrentLocation";
		self.isPermitted = YES;
	}
	
	if (status) {
		NSDictionary *dictionary = @{@"Access": value};
		[[NSNotificationCenter defaultCenter] postNotificationName:@"HandlePermissions"
															object:self
														  userInfo:dictionary];
	}
}

@end
