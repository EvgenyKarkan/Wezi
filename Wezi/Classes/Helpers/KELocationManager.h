//
//  KELocationManager.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLocationDidChangeNotificationKey;

@interface KELocationManager : NSObject

@property (nonatomic, readonly)     CLLocation *currentLocation;
@property (nonatomic, readonly)     BOOL isMonitoringLocation;

+ (instancetype)sharedManager;

- (void)startMonitoringLocationChanges;
- (void)stopMonitoringLocationChanges;

@end
