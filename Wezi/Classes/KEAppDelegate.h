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

@property (nonatomic, strong)           UIWindow *window;
@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong)           AFHTTPClient *client;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
