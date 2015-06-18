//
//  WeeklyWeatherTableViewCell.h
//  YourDay
//
//  Created by Michael Hoffman on 4/7/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeklyWeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weatherDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UIView *container2;
@property (weak, nonatomic) IBOutlet UILabel *precipLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
