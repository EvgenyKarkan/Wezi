//
//  KEReachabilityWrapper.m
//  Wezi
//
//  Created by Evgeniy Karkan on 13.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEReachabilityUtil.h"
#import "Reachability.h"
#import "AFHTTPClient.h"

static NSString * const kKEURL = @"http://google.com";
static NSString * const kKEYesInternet = @"YesInternet";
static NSString * const kKENoInternet = @"NoInternet";

@interface KEReachabilityUtil ()

@property (nonatomic, strong) AFHTTPClient *client;

@end


@implementation KEReachabilityUtil;

#pragma mark - Singleton stuff

static KEReachabilityUtil *sharedUtil = nil;

+ (instancetype)sharedUtil
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedUtil = [[KEReachabilityUtil alloc] init];
	});
	
	return sharedUtil;
}

+ (id)allocWithZone:(NSZone *)zone
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedUtil = nil;
	    sharedUtil = [super allocWithZone:zone];
	});
	
	return sharedUtil;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

#pragma mark - Public API

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
	self.client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kKEURL]];
	
	[self.client setReachabilityStatusChangeBlock: ^(AFNetworkReachabilityStatus status) {
	    if (status == AFNetworkReachabilityStatusNotReachable) {
	        [[NSNotificationCenter defaultCenter] postNotificationName:kKENoInternet
	                                                            object:nil];
		}
	    else {
	        [[NSNotificationCenter defaultCenter] postNotificationName:kKEYesInternet
	                                                            object:nil];
		}
	}];
}

@end
