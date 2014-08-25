//
//  KEForecast.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/30/13.
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
        self.conditionOnForecast = forecastCondition;
        self.month               = forecastMonth;
        self.weekDay             = forecastWeekDay;
        self.dayNumber           = forecastDayNumber;
        self.yearNumber          = forecastYearNumber;
        self.humidity            = forecastHumidity;
        self.wind                = forecastWind;
        self.highTemperature     = forecastHighTemperature;
        self.lowTemperature      = forecastLowTemperature;
        self.iconURL             = forecastIconURL;
    }
    
    return self;
}

@end
