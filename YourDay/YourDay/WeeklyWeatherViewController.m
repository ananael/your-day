//
//  WeeklyWeatherViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 4/5/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "WeeklyWeatherViewController.h"
#import <SWRevealViewController.h>
#import "WeeklyWeatherTableViewCell.h"
#import "MethodsCache.h"


@interface WeeklyWeatherViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WeeklyWeatherTableViewCell *cellPrototype;

@property (strong, nonatomic) NSMutableArray *dayArray;
@property (strong, nonatomic) NSMutableArray *summaryArray;
@property (strong, nonatomic) NSMutableArray *temperatureArray;
@property (strong, nonatomic) NSMutableArray *humidityArray;
@property (strong, nonatomic) NSMutableArray *precipArray;
@property (strong, nonatomic) NSMutableArray *windArray;
@property (strong, nonatomic) NSMutableArray *visibilityArray;
@property (strong, nonatomic) NSMutableArray *iconArray;
@property (strong, nonatomic) NSMutableArray *dateArray;

@property (strong, nonatomic) MethodsCache *methods;


//Dummy data
//@property (strong, nonatomic) NSArray *weatherDetailArray;
@property (strong, nonatomic) NSArray *numberArray;
@property (strong, nonatomic) NSMutableArray *oneArray;
@property (strong, nonatomic) NSMutableArray *twoArray;
@property (strong, nonatomic) NSMutableArray *threeArray;


@end

@implementation WeeklyWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.backgroundImage.image = [UIImage imageNamed:@"Earth-2048h-inverted.jpg"];
    
    self.cellPrototype = [self.tableView dequeueReusableCellWithIdentifier:@"weatherCell"];
    
    self.methods = [MethodsCache new];
    
    //Implements the slide-out view controller
    SWRevealViewController *revealVC = self.revealViewController;
    if (revealVC)
    {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
    //Data broken down into appropriate arrays for tableview cells
    self.dayArray = [NSMutableArray new];
    self.summaryArray = [NSMutableArray new];
    self.temperatureArray = [NSMutableArray new];
    self.humidityArray = [NSMutableArray new];
    self.precipArray = [NSMutableArray new];
    self.windArray = [NSMutableArray new];
    self.visibilityArray = [NSMutableArray new];
    self.iconArray = [NSMutableArray new];
    self.dateArray = [NSMutableArray new];
    
    for (NSInteger i=0; i<7; i++)
    {
        //Each day and Date
        NSNumber *epochTime;
        NSString *convertedDay;
        NSString *convertedDate;
        epochTime = self.resultsDictionary[@"daily"][@"data"][i][@"time"];
        convertedDay = [self.methods convertEpochTimeToHumanDay:epochTime];
        convertedDate = [self.methods convertEpochTimeToHumanDate:epochTime];
        [self.dayArray addObject:convertedDay];
        [self.dateArray addObject:convertedDate];
        
        //Each day's weather in sentence format
        NSString *weatherSummary;
        weatherSummary = self.resultsDictionary[@"daily"][@"data"][i][@"summary"];
        [self.summaryArray addObject:weatherSummary];
        
        //Each day's expected high temperature
        NSString *convertedTemp;
        convertedTemp = [self.methods convertToTemperature:self.resultsDictionary[@"daily"][@"data"][i][@"temperatureMax"]];
        [self.temperatureArray addObject:convertedTemp];
        
        //Each day's expected humidity level
        NSString *humidity;
        humidity = [self.methods convertToHumidityLabel:self.resultsDictionary[@"daily"][@"data"][i][@"humidity"]];
        [self.humidityArray addObject:humidity];
        
        //Each day's expected precipitation
        NSString *precipitation;
        precipitation = [self.methods convertToPrecipProbability:self.resultsDictionary[@"daily"][@"data"][i][@"precipType"] Probability:self.resultsDictionary[@"daily"][@"data"][i][@"precipProbability"]];
        [self.precipArray addObject:precipitation];
        
        //Each day's wind direction and speed
        NSString *windInfo;
        windInfo = [self.methods convertToWindBearing:self.resultsDictionary[@"daily"][@"data"][i][@"windBearing"] AndSpeed:self.resultsDictionary[@"daily"][@"data"][i][@"windSpeed"]];
        [self.windArray addObject:windInfo];
        
        //Each day's expected visibility
        NSString *visibility;
        visibility = [self.methods convertToVisibilityLabel:self.resultsDictionary[@"daily"][@"data"][i][@"visibility"]];
        [self.visibilityArray addObject:visibility];
        
        //Each day's icon summary used to select appropriate icon image
        NSString *iconInfo;
        iconInfo = self.resultsDictionary[@"daily"][@"data"][i][@"icon"];
        [self.iconArray addObject:iconInfo];
        
    }
    
    
    
    NSLog(@"FROM WEEKLY WEATHER: %@", self.resultsDictionary[@"currently"]);
    NSLog(@"%@", self.temperatureArray);
    NSLog(@"%@", self.summaryArray);
    NSLog(@"%@", self.dayArray);
    NSLog(@"%@", self.dateArray);
    NSLog(@"%@", self.humidityArray);
    NSLog(@"%@", self.precipArray);
    NSLog(@"%@", self.windArray);
    NSLog(@"%@", self.visibilityArray);
    NSLog(@"%@", self.iconArray);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    return [self.summaryArray count];
}

-(NSString *)labelTextForRow:(NSInteger)row
{
    return [self.summaryArray objectAtIndex:row];
}

-(CGSize) sizeOfLabel:(UILabel *)label withText:(NSString *)text
{
    
    label.font = [UIFont fontWithName:label.font.fontName size:13]; // Storyboard Label font unless specified.
    label.text = text;
    label.numberOfLines = 0; //"0" represents unlimited lines
    CGSize maximumLabelSize = CGSizeMake(320, INFINITY); //The width with infinite height
    
    CGSize expectedSize = [label sizeThatFits:maximumLabelSize];
    expectedSize.height = ceilf(expectedSize.height); //Rounds up to nearest integer value
    expectedSize.width = ceilf(expectedSize.width); //Rounds up to nearest integer value
    
    return expectedSize;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat labelHeight = [self sizeOfLabel:self.cellPrototype.weatherDetailLabel withText:[self labelTextForRow:indexPath.row]].height;
    
    //    CGFloat textFieldHeight = [self sizeOfTextField:self.cellPrototype.weatherDetailLabel withText:[self textFieldTextForRow:indexPath.row]].height;
    
    //Use the textFields Storyboard height for use in the "combinedHeight" calculation instead of the "sizeOfTextField" method
    CGFloat container1Height = self.cellPrototype.container1.frame.size.height;
    
    CGFloat padding = 2;
    CGFloat combinedHeight = padding * 2 + labelHeight + padding * 3 + container1Height + padding * 2;
    CGFloat minimumHeight = 108; //Size of Storyboard prototype cell
    
    return MAX(combinedHeight, minimumHeight);
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 WeeklyWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
 
 // Configure the cell...
     
     [self sizeOfLabel:cell.weatherDetailLabel withText:self.summaryArray[indexPath.row]];
     cell.weatherDetailLabel.text = self.summaryArray[indexPath.row];
     cell.weatherDetailLabel.textColor = [UIColor blackColor];
     
     //cell.dayLabel.transform = CGAffineTransformMakeRotation(M_PI_2*3);
     cell.dayLabel.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(M_PI_2*3), 1.25, 1.25);
     cell.dayLabel.textColor = [UIColor blackColor];
     cell.dayLabel.text = self.dayArray[indexPath.row];
     
     cell.tempLabel.text = self.temperatureArray[indexPath.row];
     
     cell.humidityLabel.text = self.humidityArray[indexPath.row];
     
     cell.precipLabel.text = self.precipArray[indexPath.row];
     
     cell.windLabel.text = self.windArray[indexPath.row];
     
     cell.visibilityLabel.text = self.visibilityArray[indexPath.row];
     
     //"Style" choices for this method are: @"light", @"dark", @"black"
     [self.methods convertWeatherType:self.iconArray[indexPath.row] ForView:cell.weatherIcon UsingIconStyle:@"black"];
     
     cell.dateLabel.text = self.dateArray[indexPath.row];
     cell.dateLabel.textColor = [UIColor blackColor];
     
     //Even though this code specifies modifications only to cell at index.row == 0,
     //the textcolor change effected the last cell.
     //To resolve, the cells named in the "IF" statement were given a color in the lines above.
     if (indexPath.row == 0)
     {
         CGFloat border = 1;
         CALayer *topBorder = [CALayer layer];
         topBorder.borderColor = [UIColor blackColor].CGColor;
         topBorder.frame = CGRectMake(0, 0, self.view.bounds.size.width, border);
         topBorder.borderWidth = border;
         [cell.contentView.layer addSublayer:topBorder];
         
         cell.dayLabel.text = @"now";
         cell.dayLabel.textColor = [UIColor whiteColor];
         cell.tempLabel.text = [self.methods convertToTemperature:self.resultsDictionary[@"currently"][@"temperature"]];
         cell.weatherDetailLabel.text = self.resultsDictionary[@"currently"][@"summary"];
         cell.weatherDetailLabel.textColor = [UIColor whiteColor];
         cell.humidityLabel.text = [self.methods convertToHumidityLabel:self.resultsDictionary[@"currently"][@"humidity"]];
         cell.precipLabel.text = [self.methods convertToPrecipProbability:self.resultsDictionary[@"currently"][@"precipType"] Probability:self.resultsDictionary[@"currently"][@"precipProbability"]];
         cell.windLabel.text = [self.methods convertToWindBearing:self.resultsDictionary[@"currently"][@"windBearing"] AndSpeed:self.resultsDictionary[@"currently"][@"windSpeed"]];
         cell.visibilityLabel.text = [self.methods convertToVisibilityLabel:self.resultsDictionary[@"currently"][@"visibility"]];
        
         //"Style" choices for this method are: @"light", @"dark", @"black"
         [self.methods convertWeatherType:self.resultsDictionary[@"currently"][@"icon"] ForView:cell.weatherIcon UsingIconStyle:@"light"];
         
         cell.dateLabel.textColor = [UIColor whiteColor];
     }
     
     CGFloat border = 1;
     CALayer *bottomBorder = [CALayer layer];
     bottomBorder.borderColor = [UIColor blackColor].CGColor;
     bottomBorder.frame = CGRectMake(0, cell.bounds.size.height, self.view.bounds.size.width, border);
     bottomBorder.borderWidth = border;
     [cell.contentView.layer addSublayer:bottomBorder];
     
     cell.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
 return cell;
 }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/









@end
