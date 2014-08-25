//
//  KEObservation.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import "KEObservation.h"


@implementation KEObservation;

+ (NSDictionary *)keyMapping
{
    static NSDictionary *keyMapping = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        keyMapping = @{
                       @"display_location"             : @"location",
                       @"observation_time"             : @"timeString",
                       @"weather"                      : @"weatherDescription",
                       @"wind_dir"                     : @"windShortAbbreviation",
                       @"wind_kph"                     : @"windSpeed",
                       @"relative_humidity"            : @"relativeHumidity",
                       @"pressure_in"                  : @"pressure",
                       @"icon_url"                     : @"iconUrl",
                       @"temp_c"                       : @"temperatureC"
                       };
    });
    
    return keyMapping;
}

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary
{
    KEObservation *observation = nil;
    
    if (dictionary) {
        observation = [[KEObservation alloc] init];
        NSDictionary *keyMapping = [self keyMapping];
        for (NSString *key in keyMapping) {
            id value = dictionary[key];
            if (value) {
                [observation setValue:value forKey:keyMapping[key]];
            }
        }
    }
    
    return observation;
}

@end
