//
//  KEWeatherManager.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "KEObservation.h"
#import "KETommorowForecast.h"

@protocol UpdateUIWithForecast <NSObject>

@end

@interface KEWeatherManager : AFHTTPClient

@property (nonatomic,assign) id <UpdateUIWithForecast> delegate;
@property (nonatomic, strong) NSMutableDictionary *days;

+ (instancetype)sharedClient;
- (void)getCurrentWeatherObservationForLocation:(CLLocation *)location
                                     completion:(void(^)(KEObservation *observation, NSError *error))completion;
- (void)getForecastObservationForLocation:(CLLocation *)location
                               completion:(void(^)(NSMutableDictionary *threeDays, NSError *error))completion;

@end
