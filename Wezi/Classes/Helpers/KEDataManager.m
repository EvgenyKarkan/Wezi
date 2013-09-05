//
//  KEDataManager.m
//  Wezi
//
//  Created by Evgeniy Karkan on 19.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEDataManager.h"
#import "KEAppDelegate.h"
#import "SVProgressHUD.h"

@implementation KEDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Singleton stuff

static id _sharedInstance = nil;

+ (instancetype)sharedDataManager
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedInstance = [[KEDataManager alloc] init];
	});
	
	return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedInstance = nil;
	    _sharedInstance = [super allocWithZone:zone];
	});
	
	return _sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

#pragma mark - Core Data stuff

- (NSManagedObjectContext *)managedObjectContextFromDataManager
{
	return self.managedObjectContext;
}

- (NSFetchRequest *)requestWithEntityName:(NSString *)entityName
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
	                                          inManagedObjectContext:[self managedObjectContextFromDataManager]];
	[fetchRequest setEntity:entity];
	
	return fetchRequest;
}

- (void)saveContext
{
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Unresolved error %@, %@", error, [error userInfo]]];
			abort();
		}
	}
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Wezi" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Wezi.sqlite"];
	
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Unresolved error %@, %@", error, [error userInfo]]];
		abort();
	}
	
	return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
