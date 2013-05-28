//
//  KEDataManager.h
//  Wezi
//
//  Created by Каркан Евгений on 19.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEDataManager : NSObject

@property (nonatomic, strong)       NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)       NSFetchRequest *fetchRequest;

+ (KEDataManager *)sharedDataManager;

- (NSManagedObjectContext *)managedObjectContextFromAppDelegate;
- (NSFetchRequest *)requestWithEntityName:(NSString *)entity;

@end
