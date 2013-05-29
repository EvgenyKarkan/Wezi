//
//  KEDataManager.m
//  Wezi
//
//  Created by Каркан Евгений on 19.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEDataManager.h"
#import "KEAppDelegate.h"

static KEDataManager *sharedDataManager = nil;

@implementation KEDataManager

+ (KEDataManager *)sharedDataManager
{
    return sharedDataManager;
}

+ (void)initialize
{
    sharedDataManager = [[KEDataManager alloc] init];
}

- (NSManagedObjectContext *)managedObjectContextFromAppDelegate
{
    KEAppDelegate *appDelegate = (KEAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext * managedObjectContext = [[NSManagedObjectContext alloc]init];
    managedObjectContext = [appDelegate managedObjectContext];
    
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
