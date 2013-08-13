//
//  SUAppDelegate.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AFHTTPClient;

@interface KEAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong)   UIWindow *window;
@property (nonatomic, strong)   AFHTTPClient *client;

@end
