//
//  WeatherViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 3/25/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "WeatherViewController.h"
#import <SWRevealViewController.h>


@interface WeatherViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *mainDesignContainer;
@property (weak, nonatomic) IBOutlet UIImageView *mainDesign;

//Containers 1, 2, and 3 reside within the mainDesignContainer
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIImageView *currentWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *hiTempLabel;

@property (weak, nonatomic) IBOutlet UIView *container2;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIView *container3;
@property (weak, nonatomic) IBOutlet UILabel *loTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeTempLabel;

@property (weak, nonatomic) IBOutlet UIView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContent;

@property (strong, nonatomic) NSMutableArray *contentBoxes;
@property (strong, nonatomic) NSMutableArray *labelArray;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSArray *temperatures;
@property (strong, nonatomic) NSArray *hours;


@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.mainDesign.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.backgroundView.image = [UIImage imageNamed:@"Earth-2048h.jpg"];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //Implements the slide-out view controller
    SWRevealViewController *revealVC = self.revealViewController;
    if (revealVC)
    {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        //Places a UIView overlay on the Front View Controller to prevent user interaction when the Rear View Controller is active
        self.revealViewController.shouldUseFrontViewOverlay = YES;
        
    }
    
    
    
    // TODO: Make as method- "containersClearColor"
    for (UIView *containers in [self containersArray])
    {
        containers.backgroundColor = [UIColor clearColor];
    }
    
    //TODO: Make as method- "weatherPageBlue"
    UIColor *navyFog = [UIColor colorWithRed:61.0/255 green:73.0/255 blue:96.0/255 alpha:1.0];
    
    self.currentTempLabel.textColor = navyFog;
    self.feelsLabel.textColor = navyFog;
    self.feelsLikeTempLabel.textColor = navyFog;
    
    //Creates TOP and BOTTOM borders for scrollContainer
    CGFloat border = 1;
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.scrollContainer.frame.size.width, border);
    topBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.scrollContainer.layer addSublayer:topBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.scrollContainer.frame.size.height, self.scrollContainer.frame.size.width, border);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.scrollContainer.layer addSublayer:bottomBorder];
    
    
    //Dummy content
    self.temperatures = @[@"67°", @"10°", @"-14°", @"104°", @"75°", @"8°", @"55°", @"93°", @"-24°", @"32°", @"100°", @"0°", @"20°", @"13°", @"60°", @"87°", @"42°", @"91°", @"2°", @"71°", @"88°", @"-7°", @"59°", @"89°"];
    
    self.hours = @[@"12 AM", @"1 AM", @"2 AM", @"3 AM", @"4 AM", @"5 AM", @"6 AM", @"7 AM", @"8 AM", @"9 AM", @"10 AM", @"11 AM", @"12 PM", @"1 PM", @"2 PM", @"3 PM", @"4 PM", @"5 PM", @"6 PM", @"7 PM", @"8 PM", @"9 PM", @"10 PM", @"11 PM"];
    
    self.contentBoxes = [NSMutableArray new];
    self.timeArray = [NSMutableArray new];
    self.labelArray = [NSMutableArray new];
    for (NSInteger i = 0; i < 960; i = i+40)
    {
        UIView *hourlyContentBox = [[UIView alloc]initWithFrame:CGRectMake(i, 0, 40, 80)];
        hourlyContentBox.backgroundColor = [UIColor clearColor];
        
        UILabel *timeBox = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 36, 15)];
        timeBox.backgroundColor = [UIColor clearColor];
        
        UIImageView *hourlyIconBox = [[UIImageView alloc]initWithFrame:CGRectMake(2, 20, 36, 36)];
        hourlyIconBox.backgroundColor = [UIColor blueColor];
        
        UILabel *weatherLabelBox = [[UILabel alloc]initWithFrame:CGRectMake(2, 58, 36, 20)];
        weatherLabelBox.backgroundColor = [UIColor clearColor];
        
        
        
        [hourlyContentBox addSubview:timeBox];
        [hourlyContentBox addSubview:hourlyIconBox];
        [hourlyContentBox addSubview:weatherLabelBox];
        
        [self.timeArray addObject:timeBox];
        [self.labelArray addObject:weatherLabelBox];
        [self.contentBoxes addObject:hourlyContentBox];
        
        [self.scrollContent addSubview:hourlyContentBox];
        
    }
    
    //Keep outside for-loop.
    //If put inside for-loop, result will be the same, but system runs thru labeling everytime a new box is added
    //E.g. "98", "98, 67", "98, 67, 100", "98, 67, 100, 77", etc. until all label have text
    for (NSInteger i=0; i<[self.temperatures count]; i++)
    {
        UILabel *degreeLabel;
        
        degreeLabel = [self.labelArray objectAtIndex:i];
        degreeLabel.text = [self.temperatures objectAtIndex:i];
        degreeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        degreeLabel.textColor = [UIColor whiteColor];
        degreeLabel.textAlignment = NSTextAlignmentCenter;
        
        //TODO: Remove this NSLog
        NSLog(@"object: %@", degreeLabel.text);
    }
    
    for (NSInteger i=0; i<[self.timeArray count]; i++)
    {
        UILabel *hourLabel;
        
        hourLabel = [self.timeArray objectAtIndex:i];
        hourLabel.text = [self.hours objectAtIndex:i];
        hourLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
        hourLabel.textColor = [UIColor whiteColor];
        hourLabel.textAlignment = NSTextAlignmentCenter;
        
        //TODO: Remove this NSLog
        NSLog(@"Time: %@", hourLabel.text);
    }
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)containersArray
{
    NSArray *containerViews = @[self.mainDesignContainer, self.container1, self.container2, self.container3, self.scrollContainer, self.scrollContent];
    return containerViews;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
