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


@interface WeeklyWeatherViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WeeklyWeatherTableViewCell *cellPrototype;

//Dummy data
@property (strong, nonatomic) NSArray *weatherDetailArray;
@property (strong, nonatomic) NSArray *dayArray;


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
    
    SWRevealViewController *revealVC = self.revealViewController;
    if (revealVC)
    {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
    // TODO: Remove dummy data
    //Dummy data
    self.weatherDetailArray = @[@"Could be snow", @"Could be rain", @"Could be sleet, but what about Dick Tracy.  That's a mighty fine name.", @"Could be hail", @"Could be tornado. Put the chickens back in the coop!", @"Could be thunderstorm", @"Could be cloudy"];
    
    self.dayArray = @[@"sun", @"mon", @"tue", @"wed", @"thu", @"fri", @"sat"];
    
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
    return [self.weatherDetailArray count];
}

-(NSString *)labelTextForRow:(NSInteger)row
{
    return [self.weatherDetailArray objectAtIndex:row];
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
     
     [self sizeOfLabel:cell.weatherDetailLabel withText:self.weatherDetailArray[indexPath.row]];
     cell.weatherDetailLabel.text = self.weatherDetailArray[indexPath.row];
     
     //cell.dayLabel.transform = CGAffineTransformMakeRotation(M_PI_2*3);
     cell.dayLabel.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(M_PI_2*3), 1.25, 1.25);
     cell.dayLabel.textColor = [UIColor blackColor];
     cell.dayLabel.text = self.dayArray[indexPath.row];
     
     cell.weatherDetailLabel.textColor = [UIColor blackColor];
     
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
         cell.weatherDetailLabel.textColor = [UIColor whiteColor];
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
