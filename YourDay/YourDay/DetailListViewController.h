//
//  DetailListViewController.h
//  YourDay
//
//  Created by Michael Hoffman on 4/5/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@interface DetailListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) List *toDoList;
@property (strong, nonatomic) NSArray *toDoItems;

@end
