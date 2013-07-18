//
//  KEForecast.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/30/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KETommorowForecast : NSObject

@property (nonatomic, strong) NSString *conditionOnForecast;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *weekDay;
@property (nonatomic, strong) NSNumber *dayNumber;
@property (nonatomic, strong) NSNumber *yearNumber;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *wind;
@property (nonatomic, strong) NSString *highTemperature;
@property (nonatomic, strong) NSNumber *lowTemperature;
@property (nonatomic, strong) NSString *iconURL;

- (id)initWithCondition:(NSString *)forecastCondition
              withMonth:(NSString *)forecastMonth
            withWeekDay:(NSString *)forecastWeekDay
          withDayNumber:(NSNumber *)forecastDayNumber
         withYearNumber:(NSNumber *)forecastYearNumber
           withHumidity:(NSNumber *)forecastHumidity
               withWind:(NSNumber *)forecastWind
    withHighTemperature:(NSString *)forecastHighTemperature
     withLowTemperature:(NSNumber *)forecastLowTemperature
            withIconURL:(NSString *)forecastIconURL;

@end
