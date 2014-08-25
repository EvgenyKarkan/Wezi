//
//  KELocationManager.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//



extern NSString * const kKELocationDidChangeNotificationKey;


@interface KELocationManager : NSObject

@property (nonatomic, readonly) CLLocation *currentLocation;
@property (nonatomic, readonly) BOOL       isMonitoringLocation;

+ (instancetype)sharedManager;
- (void)startMonitoringLocationChanges;
- (void)stopMonitoringLocationChanges;

@end
