//
//  KEWeatherManager.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import "KEWeatherManager.h"
#import "WeatherAPIKey.h"
#import "KEAfterTommorowForecast.h"
#import "KEAfterAfterTommorowForecast.h"
#import "SVProgressHUD.h"

static NSString * const kWeatherUndergroundAPIBaseURLString = @"http://api.wunderground.com/api/";

@implementation KEWeatherManager

#pragma mark - Singleton

+ (instancetype)sharedClient
{
    static KEWeatherManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseURLString = [kWeatherUndergroundAPIBaseURLString stringByAppendingString:kWeatherUndergroundAPIKey];
        sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    return sharedClient;
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

#pragma mark - Public API

- (void)getCurrentWeatherObservationForLocation:(CLLocation *)location completion:(void(^)(KEObservation *observation, NSError *error))completion
{
    if (location) {
        NSString *getPath = [NSString stringWithFormat:@"conditions/q/%.6f,%.6f.json", location.coordinate.latitude,
                                                                                       location.coordinate.longitude];
        KEWeatherManager *client = [KEWeatherManager sharedClient];
        
        [client getPath:getPath
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    KEObservation *observation = [KEObservation observationWithDictionary:responseObject[@"current_observation"]]; // maybe to change it
                    completion(observation, nil);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    completion(nil, error);
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                        NSLog(@"Error occured%@", [error localizedDescription]);
                    }
                }
         ];
    }
    else {
        completion(nil, [NSError errorWithDomain:@"Invalid Location as argument" code: - 1 userInfo:nil]);
        [SVProgressHUD showErrorWithStatus:@"Error: invalid location"];
    }
}
#pragma mark - I Add it

- (void)getForecastObservationForLocation:(CLLocation *)location completion:(void(^)(NSMutableDictionary *days, NSError *error))completion
{
    if(location) {
        NSString *getPath = [NSString stringWithFormat:@"forecast/lang:EN/q/%.6f,%.6f.json", location.coordinate.latitude,
                                                                                              location.coordinate.longitude];
        KEWeatherManager *client = [KEWeatherManager sharedClient];
        
        [client getPath:getPath
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        //NSLog(@" Response   %@", responseObject  );
                    NSMutableDictionary *threeDays = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                      [self fillTommorowWithResponse:responseObject], @"Tommorow",
                                                      [self fillAfterTommorowWithResponse:responseObject], @"AfterTommorow",
                                                      [self fillAfterAfterTommorowWithResponse:responseObject], @"AfterAfterTommorow", nil];
                    
                    self.days = threeDays;
                    
                    completion(self.days, nil);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    completion(nil, error);
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                    }
                }
        ];
    }
}

#pragma mark - init forecast models 

- (KETommorowForecast *)fillTommorowWithResponse:(id)response
{
    KETommorowForecast *tommorow = [[KETommorowForecast alloc]initWithCondition:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKey:@"conditions"]
                                                      withMonth:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"date.monthname"]
                                                    withWeekDay:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"date.weekday_short"]
                                                  withDayNumber:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"date.day"]
                                                 withYearNumber:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"date.year"]
                                                   withHumidity:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKey:@"avehumidity"]
                                                       withWind:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"avewind.kph"]
                                            withHighTemperature:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"high.celsius"]
                                             withLowTemperature:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKeyPath:@"low.celsius"]
                                                    withIconURL:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:1] valueForKey:@"icon_url"]];
    
     return tommorow;
}

- (KEAfterTommorowForecast *)fillAfterTommorowWithResponse:(id)response
{
    KEAfterTommorowForecast *afterTommorow = [[KEAfterTommorowForecast alloc]initWithCondition:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKey:@"conditions"]
                                                           withMonth:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"date.monthname"]
                                                         withWeekDay:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"date.weekday_short"]
                                                       withDayNumber:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"date.day"]
                                                      withYearNumber:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"date.year"]
                                                        withHumidity:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKey:@"avehumidity"]
                                                            withWind:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"avewind.kph"]
                                                 withHighTemperature:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"high.celsius"]
                                                  withLowTemperature:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKeyPath:@"low.celsius"]
                                                         withIconURL:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:2] valueForKey:@"icon_url"]];

    return afterTommorow;
}

- (KEAfterAfterTommorowForecast *)fillAfterAfterTommorowWithResponse:(id)response
{
    KEAfterAfterTommorowForecast *afterAfterTommorow = [[KEAfterAfterTommorowForecast alloc]initWithCondition:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKey:@"conditions"]
                                                                withMonth:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"date.monthname"]
                                                              withWeekDay:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"date.weekday_short"]
                                                            withDayNumber:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"date.day"]
                                                           withYearNumber:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"date.year"]
                                                             withHumidity:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKey:@"avehumidity"]
                                                                 withWind:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"avewind.kph"]
                                                      withHighTemperature:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"high.celsius"]
                                                       withLowTemperature:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKeyPath:@"low.celsius"]
                                                              withIconURL:[[[response valueForKeyPath:@"forecast.simpleforecast.forecastday"] objectAtIndex:3] valueForKey:@"icon_url"]];

     return afterAfterTommorow;
}

@end
