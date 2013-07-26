//
//  KEDataManager.h
//  Wezi
//
//  Created by Evgeniy Karkan on 19.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEDataManager : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedDataManager;
- (NSManagedObjectContext *)managedObjectContextFromDataManager;
- (NSFetchRequest *)requestWithEntityName:(NSString *)entity;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
