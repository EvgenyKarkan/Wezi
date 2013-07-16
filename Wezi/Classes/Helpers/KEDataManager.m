//
//  KEDataManager.m
//  Wezi
//
//  Created by Evgeniy Karkan on 19.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEDataManager.h"
#import "KEAppDelegate.h"

@implementation KEDataManager

#pragma mark - Singleton stuff

static id __sharedInstance = nil;

+ (instancetype)sharedDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[KEDataManager alloc] init];
    });
    
    return __sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = nil;
        __sharedInstance = [super allocWithZone:zone];
    });
    
    return __sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Core Data stuff

- (NSManagedObjectContext *)managedObjectContextFromAppDelegate
{
    KEAppDelegate *appDelegate = (KEAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    id managedObjectContext = [appDelegate managedObjectContext];
    
    return managedObjectContext;
}

- (NSFetchRequest *)requestWithEntityName:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:[self managedObjectContextFromAppDelegate]];
    [fetchRequest setEntity:entity];
    
    return fetchRequest;
}

@end
