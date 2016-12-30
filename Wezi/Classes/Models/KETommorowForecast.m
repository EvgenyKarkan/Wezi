//
//  KEForecast.m
//  Wezi
//
//  Created by Evgeny Karkan on 4/30/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


#import "KETommorowForecast.h"


@implementation KETommorowForecast;

- (instancetype)initWithCondition:(NSString *)forecastCondition
                        withMonth:(NSString *)forecastMonth
                      withWeekDay:(NSString *)forecastWeekDay
                    withDayNumber:(NSNumber *)forecastDayNumber
                   withYearNumber:(NSNumber *)forecastYearNumber
                     withHumidity:(NSNumber *)forecastHumidity
                         withWind:(NSNumber *)forecastWind
              withHighTemperature:(NSString *)forecastHighTemperature
               withLowTemperature:(NSNumber *)forecastLowTemperature
                      withIconURL:(NSString *)forecastIconURL
{
    self = [super init];
    
    if (self) {
        _conditionOnForecast = forecastCondition;
        _month               = forecastMonth;
        _weekDay             = forecastWeekDay;
        _dayNumber           = forecastDayNumber;
        _yearNumber          = forecastYearNumber;
        _humidity            = forecastHumidity;
        _wind                = forecastWind;
        _highTemperature     = forecastHighTemperature;
        _lowTemperature      = forecastLowTemperature;
        _iconURL             = forecastIconURL;
    }
    
    return self;
}

@end
