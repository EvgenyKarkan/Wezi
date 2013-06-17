//
//  KEReachabilityWrapper.m
//  Wezi
//
//  Created by Каркан Евгений on 13.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEReachabilityUtil.h"
#import "Reachability.h"
#import "AFHTTPClient.h"

@interface KEReachabilityUtil ()

@property (nonatomic, strong) AFHTTPClient *client;

@end

@implementation KEReachabilityUtil

+ (instancetype)sharedUtil
{
    static KEReachabilityUtil *sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtil = [[KEReachabilityUtil alloc] init]; 
    });
    return sharedUtil;
}

- (BOOL)checkInternetConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)checkInternetConnectionWithNotification
{
    self.client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://google.com"]];
    
    [self.client setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoInternet"
                                                                object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YesInternet"
                                                                object:nil];
        }
    }];
}

@end
