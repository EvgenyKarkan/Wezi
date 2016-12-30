//
//  KEReachabilityWrapper.h
//  Wezi
//
//  Created by Evgeny Karkan on 13.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface KEReachabilityUtil : NSObject

+ (instancetype)sharedUtil;
- (BOOL)checkInternetConnection;
- (void)checkInternetConnectionWithNotification;

@end
