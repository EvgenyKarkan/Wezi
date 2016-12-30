//
//  SUAppDelegate.m
//  Wezi
//
//  Created by Evgeny Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEAppDelegate.h"
#import "AFHTTPClient.h"
#import "KEDataManager.h"
#import "KEReachabilityUtil.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


static NSString * const kKEToolBar = @"toolbar.png";
static NSString * const kKERefresh = @"RefreshCurrentLocation";


@implementation KEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:kKEToolBar]
                            forToolbarPosition:UIToolbarPositionAny
                                    barMetrics:UIBarMetricsDefault];
    
    [[KEReachabilityUtil sharedUtil] checkInternetConnectionWithNotification];
    
    [Fabric with:@[[Crashlytics class]]];

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kKERefresh object:self];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[KEDataManager sharedDataManager] saveContext];
}

@end
