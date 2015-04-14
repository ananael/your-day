//
//  ListsDataStore.h
//  YourDay
//
//  Created by Michael Hoffman on 4/10/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ListsDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSArray *lists;
@property (strong, nonatomic) NSArray *items;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void) fetchData;
- (void) generateTestData;

+ (instancetype) sharedListsDataStore;

@end
