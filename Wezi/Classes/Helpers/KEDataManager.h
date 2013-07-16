//
//  KEDataManager.h
//  Wezi
//
//  Created by Evgeniy Karkan on 19.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEDataManager : NSObject

+ (instancetype)sharedDataManager;
- (NSManagedObjectContext *)managedObjectContextFromAppDelegate;
- (NSFetchRequest *)requestWithEntityName:(NSString *)entity;

@end
