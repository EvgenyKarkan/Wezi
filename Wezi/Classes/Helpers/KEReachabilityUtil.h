//
//  KEReachabilityWrapper.h
//  Wezi
//
//  Created by Каркан Евгений on 13.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEReachabilityUtil : NSObject

+ (instancetype)sharedUtil;
- (BOOL)checkInternetConnection;
- (void)checkInternetConnectionWithNotification;

@end
