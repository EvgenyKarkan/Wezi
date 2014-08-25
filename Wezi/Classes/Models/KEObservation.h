//
//  KEObservation.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//


@interface KEObservation : NSObject

@property (nonatomic, strong) NSDictionary *location;
@property (nonatomic, copy  ) NSString     *timeString;
@property (nonatomic, copy  ) NSString     *weatherDescription;
@property (nonatomic, copy  ) NSString     *windShortAbbreviation;
@property (nonatomic, strong) NSNumber     *windSpeed;
@property (nonatomic, copy  ) NSString     *pressure;
@property (nonatomic, copy  ) NSString     *relativeHumidity;
@property (nonatomic, copy  ) NSString     *iconName;
@property (nonatomic, copy  ) NSString     *iconUrl;
@property (nonatomic, strong) NSNumber     *temperatureC;

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary;

@end
