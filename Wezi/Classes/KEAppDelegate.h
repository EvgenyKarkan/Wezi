//
//  SUAppDelegate.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Protocol <NSObject>

- (void)returnTrue;
- (void)returnFalse;

@end

@class AFHTTPClient;
@interface KEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) AFHTTPClient *client;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
