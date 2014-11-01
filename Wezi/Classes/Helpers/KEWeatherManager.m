//
//  KEWeatherManager.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEWeatherManager.h"
#import "KEAfterAfterTommorowForecast.h"
#import "KEAfterTommorowForecast.h"
#import "SVProgressHUD.h"
#import "WeatherAPIKey.h"

static NSString * const kWeatherUndergroundAPIBaseURLString = @"http://api.wunderground.com/api/";


@implementation KEWeatherManager;

#pragma mark - Singleton stuff

static id _sharedClient = nil;

+ (instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		NSString *baseURLString = [kWeatherUndergroundAPIBaseURLString stringByAppendingString:kWeatherUndergroundAPIKey];
		_sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    
    return _sharedClient;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = nil;
        _sharedClient = [super allocWithZone:zone];
    });
    
    return _sharedClient;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

#pragma mark - Public API

- (void)getCurrentWeatherObservationForLocation:(CLLocation *)location completion:(void(^)(KEObservation *observation, NSMutableDictionary *days, NSError *error))completion
{
    if (location) {
        NSString *getPath = [NSString stringWithFormat:@"geolookup/conditions/forecast/q/%.6f,%.6f.json", location.coordinate.latitude,
                                                                                       location.coordinate.longitude];
        KEWeatherManager *client = [KEWeatherManager sharedClient];
        [client getPath:getPath
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    KEObservation *observation = [KEObservation observationWithDictionary:responseObject[@"current_observation"]];
						//NSLog(@"Reaponce %@", responseObject);
					NSMutableDictionary *threeDays = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                      [self fillTommorowWithResponse:responseObject], @"Tommorow",
                                                      [self fillAfterTommorowWithResponse:responseObject], @"AfterTommorow",
                                                      [self fillAfterAfterTommorowWithResponse:responseObject], @"AfterAfterTommorow", nil];
                    
                    self.days = threeDays;
                    completion(observation, self.days, nil);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    completion(nil, nil, error);
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                    }
                }
         ];
    }
    else {
        completion(nil, nil, [NSError errorWithDomain:@"Invalid Location as argument" code: - 1 userInfo:nil]);
        [SVProgressHUD showErrorWithStatus:@"Error occured: invalid location"];
    }
}

#pragma mark - Populate forecast models 

- (KETommorowForecast *)fillTommorowWithResponse:(id)response
{
    KETommorowForecast *tommorow = [[KETommorowForecast alloc]initWithCondition:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKey:@"conditions"]
                                                      withMonth:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"date.monthname"]
                                                    withWeekDay:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"date.weekday_short"]
                                                  withDayNumber:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"date.day"]
                                                 withYearNumber:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"date.year"]
                                                   withHumidity:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKey:@"avehumidity"]
                                                       withWind:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"avewind.kph"]
                                            withHighTemperature:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"high.celsius"]
                                             withLowTemperature:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKeyPath:@"low.celsius"]
                                                    withIconURL:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][1] valueForKey:@"icon_url"]];
    
     return tommorow;
}

- (KEAfterTommorowForecast *)fillAfterTommorowWithResponse:(id)response
{
    KEAfterTommorowForecast *afterTommorow = [[KEAfterTommorowForecast alloc]initWithCondition:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKey:@"conditions"]
                                                           withMonth:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"date.monthname"]
                                                         withWeekDay:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"date.weekday_short"]
                                                       withDayNumber:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"date.day"]
                                                      withYearNumber:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"date.year"]
                                                        withHumidity:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKey:@"avehumidity"]
                                                            withWind:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"avewind.kph"]
                                                 withHighTemperature:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"high.celsius"]
                                                  withLowTemperature:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKeyPath:@"low.celsius"]
                                                         withIconURL:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][2] valueForKey:@"icon_url"]];
    return afterTommorow;
}

- (KEAfterAfterTommorowForecast *)fillAfterAfterTommorowWithResponse:(id)response
{
    KEAfterAfterTommorowForecast *afterAfterTommorow = [[KEAfterAfterTommorowForecast alloc]initWithCondition:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKey:@"conditions"]
                                                                withMonth:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"date.monthname"]
                                                              withWeekDay:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"date.weekday_short"]
                                                            withDayNumber:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"date.day"]
                                                           withYearNumber:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"date.year"]
                                                             withHumidity:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKey:@"avehumidity"]
                                                                 withWind:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"avewind.kph"]
                                                      withHighTemperature:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"high.celsius"]
                                                       withLowTemperature:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKeyPath:@"low.celsius"]
                                                              withIconURL:[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"][3] valueForKey:@"icon_url"]];

     return afterAfterTommorow;
}

@end
