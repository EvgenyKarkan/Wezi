//
//  KEForecast.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/30/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface KETommorowForecast : NSObject

@property (nonatomic, copy  ) NSString *conditionOnForecast;
@property (nonatomic, copy  ) NSString *month;
@property (nonatomic, copy  ) NSString *weekDay;
@property (nonatomic, strong) NSNumber *dayNumber;
@property (nonatomic, strong) NSNumber *yearNumber;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *wind;
@property (nonatomic, copy  ) NSString *highTemperature;
@property (nonatomic, strong) NSNumber *lowTemperature;
@property (nonatomic, copy  ) NSString *iconURL;

- (instancetype)initWithCondition:(NSString *)forecastCondition
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
