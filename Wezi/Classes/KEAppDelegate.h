//
//  SUAppDelegate.h
//  Wezi
//
//  Created by Evgeny Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@class AFHTTPClient;

@interface KEAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow     *window;
@property (nonatomic, strong) AFHTTPClient *client;

@end
