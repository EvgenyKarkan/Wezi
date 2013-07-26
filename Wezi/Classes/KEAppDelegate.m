//
//  SUAppDelegate.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEAppDelegate.h"
#import "Place.h"
#import "KEReachabilityUtil.h"
#import "AFHTTPClient.h"
#import "KEDataManager.h"

static NSString * const kKEToolBar = @"toolbar.png";

@implementation KEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:kKEToolBar]
							forToolbarPosition:UIToolbarPositionAny
									barMetrics:UIBarMetricsDefault];
	
	[[KEReachabilityUtil sharedUtil] checkInternetConnectionWithNotification];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [[KEDataManager sharedDataManager] saveContext];
}

@end
