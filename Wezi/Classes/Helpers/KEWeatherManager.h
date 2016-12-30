//
//  KEWeatherManager.h
//  Wezi
//
//  Created by Evgeny Karkan on 4/29/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "AFNetworking.h"
#import "KEObservation.h"
#import "KETommorowForecast.h"

@interface KEWeatherManager : AFHTTPClient

@property (nonatomic, strong) NSMutableDictionary *days;

+ (instancetype)sharedClient;
- (void)getCurrentWeatherObservationForLocation:(CLLocation *)location
									 completion:(void(^)(KEObservation *observation, NSMutableDictionary *days, NSError *error))completion;

@end
