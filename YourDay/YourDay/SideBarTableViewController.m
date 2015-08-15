//
//  SideBarTableViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 4/5/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "SideBarTableViewController.h"
#import <SWRevealViewController.h>
#import "RevealViewController.h"
#import "WeatherViewController.h"
#import "WeeklyWeatherViewController.h"
#import "TodoListViewController.h"
#import "RSSViewController.h"


@interface SideBarTableViewController ()

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation SideBarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:213.0/255 green:233.0/255 blue:247.0/255 alpha:0.9];
    
    self.menuItems = @[@"title", @"current", @"todo", @"rss"];
    
    
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
    return [self.menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    //TODO: consider removing this code
    //Set the attributes of a specific indexPath
    
    if (indexPath.row == 0)
    {
        cell.backgroundColor = [UIColor whiteColor];
        
    } else
    {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    //Changes the selected cell's highlight color
    UIView *highlightCell = [UIView new];
    [highlightCell setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    cell.selectedBackgroundView = highlightCell;
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController *)segue.destinationViewController;
    destViewController.title = [[self.menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    UINavigationController *navController;
    
    if ([segue.identifier isEqualToString:@"currentPush"])
    {
        navController = segue.destinationViewController;
        RevealViewController *revealVC = (RevealViewController *)navController.topViewController;
        revealVC.navigationItem.title = @"Current Conditions";
        
    } else if ([segue.identifier isEqualToString:@"todoPush"])
    {
        navController = segue.destinationViewController;
        TodoListViewController *todoVC = (TodoListViewController *)navController.topViewController;
        todoVC.navigationItem.title = @"To-Do Lists";
        
    } else if ([segue.identifier isEqualToString:@"rssPush"])
    {
        navController = segue.destinationViewController;
        RSSViewController *rssVC = (RSSViewController *)navController.topViewController;
        rssVC.navigationItem.title = @"News Feeds";
        
    }
    
    
}












@end
