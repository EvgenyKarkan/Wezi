//
//  KEObservation.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEObservation : NSObject

@property (nonatomic, strong) NSDictionary  *location;
@property (nonatomic, strong) NSString      *timeString;
@property (nonatomic, strong) NSString      *weatherDescription;
@property (nonatomic, strong) NSString      *windShortAbbreviation;
@property (nonatomic, strong) NSNumber      *windSpeed;
@property (nonatomic, strong) NSString      *pressure;
@property (nonatomic, strong) NSString      *relativeHumidity;
@property (nonatomic, strong) NSString      *iconName;
@property (nonatomic, strong) NSString      *iconUrl;
@property (nonatomic, strong) NSNumber      *temperatureC;

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary;

@end
