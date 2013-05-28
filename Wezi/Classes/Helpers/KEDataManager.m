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
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    return self.managedObjectContext;
}

- (NSFetchRequest *)requestWithEntityName:(NSString *)entityName
{
    NSFetchRequest *fetchRequst = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:[sharedDataManager managedObjectContextFromAppDelegate]];
    [fetchRequst setEntity:entity];
    
    return self.fetchRequest;
}
@end
