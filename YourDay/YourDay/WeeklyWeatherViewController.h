//
//  WeeklyWeatherViewController.h
//  YourDay
//
//  Created by Michael Hoffman on 4/5/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeklyWeatherViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *resultsDictionary;

@end
