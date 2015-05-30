//
//  WeatherViewController.h
//  YourDay
//
//  Created by Michael Hoffman on 3/25/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Forecastr+CLLocation.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableDictionary *resultsDictionary;

@end
