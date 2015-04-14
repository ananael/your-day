//
//  List.h
//  YourDay
//
//  Created by Michael Hoffman on 4/10/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface List : NSManagedObject

@property (nonatomic, retain) NSString * listName;
@property (nonatomic, retain) NSSet *item;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addItemObject:(Task *)value;
- (void)removeItemObject:(Task *)value;
- (void)addItem:(NSSet *)values;
- (void)removeItem:(NSSet *)values;

@end
