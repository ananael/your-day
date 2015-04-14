//
//  Task.h
//  YourDay
//
//  Created by Michael Hoffman on 4/10/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * item;
@property (nonatomic, retain) NSManagedObject *listName;

@end
