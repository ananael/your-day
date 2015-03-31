//
//  WeatherViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 3/25/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *mainDesignContainer;
@property (weak, nonatomic) IBOutlet UIImageView *mainDesign;
@property (weak, nonatomic) IBOutlet UIView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContent;

@property (strong, nonatomic) NSMutableArray *contentBoxes;
@property (strong, nonatomic) NSMutableArray *labelArray;
@property (strong, nonatomic) NSArray *temperatures;


@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.mainDesign.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.scrollContainer.backgroundColor = [UIColor clearColor];
    self.scrollContent.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
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
    self.temperatures = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X"];
    
    self.contentBoxes = [NSMutableArray new];
    self.labelArray = [NSMutableArray new];
    for (NSInteger i = 0; i < 960; i = i+40)
    {
        UIView *hourlyContentBox = [[UIView alloc]initWithFrame:CGRectMake(i, 0, 40, 80)];
        hourlyContentBox.backgroundColor = [UIColor clearColor];
        
        UIImageView *hourlyIconBox = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 36, 36)];
        hourlyIconBox.backgroundColor = [UIColor blueColor];
        
        UILabel *weatherLabelBox = [[UILabel alloc]initWithFrame:CGRectMake(2, 58, 36, 20)];
        weatherLabelBox.backgroundColor = [UIColor clearColor];
        
        [self.labelArray addObject:weatherLabelBox];
        
        [hourlyContentBox addSubview:hourlyIconBox];
        [hourlyContentBox addSubview:weatherLabelBox];
        [self.contentBoxes addObject:hourlyContentBox];
        [self.scrollContent addSubview:hourlyContentBox];
        
    }
    
    //Keep outside for-loop.
    //If put inside for-loop, result will be the same, but system runs thru labeling everytime a new box is added
    //E.g. "98", "98, 67", "98, 67, 100", "98, 67, 100, 77", etc. until all label have text
    for (NSInteger i=0; i<[self.temperatures count]; i++)
    {
        UILabel *label;
        
        label = [self.labelArray objectAtIndex:i];
        label.text = [self.temperatures objectAtIndex:i];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        NSLog(@"object: %@", label.text);
    }
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
