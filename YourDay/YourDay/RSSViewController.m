//
//  RSSViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 4/27/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "RSSViewController.h"
#import <SWRevealViewController.h>
#import "RSSDetailViewController.h"
#import "Constants.h"
#import "MethodsCache.h"

@interface RSSViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIButton *worldButton;
@property (weak, nonatomic) IBOutlet UIButton *technologyButton;
@property (weak, nonatomic) IBOutlet UIButton *businessButton;
@property (weak, nonatomic) IBOutlet UIButton *entertainmentButton;
@property (weak, nonatomic) IBOutlet UIView *container2;
@property (weak, nonatomic) IBOutlet UILabel *rssLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *worldContainer;
@property (weak, nonatomic) IBOutlet UIImageView *worldImage;
@property (weak, nonatomic) IBOutlet UIButton *bbcWorldButton;
@property (weak, nonatomic) IBOutlet UIButton *reutersWorldButton;
@property (weak, nonatomic) IBOutlet UIButton *usaNewsWorldButton;
@property (weak, nonatomic) IBOutlet UIButton *usaTodayWorldButton;
@property (weak, nonatomic) IBOutlet UIButton *closeWorldButton;

@property (weak, nonatomic) IBOutlet UIView *sciTechContainer;
@property (weak, nonatomic) IBOutlet UIImageView *sciTechImage;
@property (weak, nonatomic) IBOutlet UIButton *bbcTechButton;
@property (weak, nonatomic) IBOutlet UIButton *nasaSciButton;
@property (weak, nonatomic) IBOutlet UIButton *reutersTechButton;
@property (weak, nonatomic) IBOutlet UIButton *techworldButton;
@property (weak, nonatomic) IBOutlet UIButton *closeTechButton;

@property (weak, nonatomic) IBOutlet UIView *businessContainer;
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UIButton *bbcBusinessButton;
@property (weak, nonatomic) IBOutlet UIButton *forbesBusinessButton;
@property (weak, nonatomic) IBOutlet UIButton *reutersBusinessButton;
@property (weak, nonatomic) IBOutlet UIButton *wiredBusinessButton;
@property (weak, nonatomic) IBOutlet UIButton *closeBusinessButton;

@property (weak, nonatomic) IBOutlet UIView *entertainmentContainer;
@property (weak, nonatomic) IBOutlet UIImageView *entertainmentImage;
@property (weak, nonatomic) IBOutlet UIButton *bbcEntertainmentButton;
@property (weak, nonatomic) IBOutlet UIButton *hrEntertainmentNewsButton;
@property (weak, nonatomic) IBOutlet UIButton *hrEntertainmentBoxOfficeButton;
@property (weak, nonatomic) IBOutlet UIButton *reutersEntertainmentButton;
@property (weak, nonatomic) IBOutlet UIButton *closeEntertainmentButton;

@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSMutableArray *feeds;
@property (strong, nonatomic) NSMutableDictionary *item;
@property (strong, nonatomic) NSMutableString *rssTitle;
@property (strong, nonatomic) NSMutableString *rssLink;
@property (strong, nonatomic) NSString *element;

@property (strong, nonatomic) MethodsCache *methods;

- (IBAction)worldTapped:(id)sender;
- (IBAction)technologyTapped:(id)sender;
- (IBAction)businessTapped:(id)sender;
- (IBAction)entertainmentTapped:(id)sender;

- (IBAction)bbcWorldTapped:(id)sender;
- (IBAction)reutersWorldTapped:(id)sender;
- (IBAction)usaNewsWorldTapped:(id)sender;
- (IBAction)usaTodayWorldTapped:(id)sender;
- (IBAction)closeTapped:(id)sender;

- (IBAction)bbcTechTapped:(id)sender;
- (IBAction)nasaSciTapped:(id)sender;
- (IBAction)reutersTechTapped:(id)sender;
- (IBAction)techworldTapped:(id)sender;

- (IBAction)bbcBusinessTapped:(id)sender;
- (IBAction)forbesBusinessTapped:(id)sender;
- (IBAction)reutersBusinessTapped:(id)sender;
- (IBAction)wiredBusinessTapped:(id)sender;

- (IBAction)bbcEntertainmentTapped:(id)sender;
- (IBAction)hrEntertainmentNewsTapped:(id)sender;
- (IBAction)hrEntertainmentBoxOfficeTapped:(id)sender;
- (IBAction)reutersEntertainmentTapped:(id)sender;


@end

@implementation RSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.entertainmentImage.image = [UIImage imageNamed:@"theater masks"];
    
    self.backgroundImage.backgroundColor = [UIColor colorWithRed:167.0/255.0 green:205.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    self.methods = [MethodsCache new];
    
    self.worldContainer.hidden = YES;
    self.sciTechContainer.hidden = YES;
    self.businessContainer.hidden = YES;
    self.entertainmentContainer.hidden = YES;
    
    [self.methods containerFillColor:[self containersArray]];
    [self.methods buttonBorder:[self closeButtonsArray]];
    [self.methods buttonFillColor:[self closeButtonsArray]];
    [self.methods feedButtonCenterText:[self feedButtonsArray]];
    
    NSString *closeButtonText = @"close";
    [self.methods formatCloseButton:[self closeButtonsArray] withString:closeButtonText kern:10.0 scaleHeight:1.0 scaleWidth:1.0];
    
    [self.methods containerBottomBorder:[self containersArray] comparedToMainView:self.view];
    
    //Implements the slide-out view controller
    SWRevealViewController *revealVC = self.revealViewController;
    if (revealVC)
    {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)closeButtonsArray
{
    NSArray *closeButtons = @[self.closeBusinessButton, self.closeEntertainmentButton, self.closeTechButton, self.closeWorldButton];
    
    return closeButtons;
}

-(NSArray *)feedButtonsArray
{
    NSArray *feedButtons = @[self.bbcWorldButton, self.reutersWorldButton, self.usaNewsWorldButton, self.usaTodayWorldButton, self.bbcTechButton, self.nasaSciButton, self.reutersTechButton, self.techworldButton, self.bbcBusinessButton, self.forbesBusinessButton, self.reutersBusinessButton, self.wiredBusinessButton, self.bbcEntertainmentButton, self.hrEntertainmentNewsButton, self.hrEntertainmentBoxOfficeButton, self.reutersEntertainmentButton];
    
    return feedButtons;
}

-(NSArray *)containersArray
{
    NSArray *containerArray = @[self.container1, self.container2, self.worldContainer, self.sciTechContainer, self.businessContainer, self.entertainmentContainer];
    
    return containerArray;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.feeds count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rssCell" forIndexPath:indexPath];
 
 // Configure the cell...
     
     cell.textLabel.text = [[self.feeds objectAtIndex:indexPath.row]objectForKey:@"title"];
 
     return cell;
 }


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.element = elementName;
    
    if ([self.element isEqualToString:@"item"])
    {
        self.item = [[NSMutableDictionary alloc]init];
        self.rssTitle = [[NSMutableString alloc]init];
        self.rssLink = [[NSMutableString alloc]init];
        
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [self.item setObject:self.rssTitle forKey:@"title"];
        [self.item setObject:self.rssLink forKey:@"link"];
        
        [self.feeds addObject:[self.item copy]];
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.element isEqualToString:@"title"])
    {
        [self.rssTitle appendString:string];
    } else if ([self.element isEqualToString:@"link"])
    {
        [self.rssLink appendString:string];
    }
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.tableView reloadData];
    
}

- (void)LoadRSSFeedWithURLString:(NSString *)urlString
{
    self.feeds = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:urlString];
    self.parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    self.parser.delegate = self;
    self.parser.shouldResolveExternalEntities = NO;
    [self.parser parse];
    
}

- (void)showRSSFeedMenu:(UIView *)container
{
    container.hidden = NO;
    
    self.container1.hidden = YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"rssDetailSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [self.feeds[indexPath.row]objectForKey:@"link"];
        [[segue destinationViewController]setUrl:string];
    }
    
}


- (IBAction)worldTapped:(id)sender
{
    [self showRSSFeedMenu:self.worldContainer];
    
}

- (IBAction)technologyTapped:(id)sender
{
    [self showRSSFeedMenu:self.sciTechContainer];
    
}

- (IBAction)businessTapped:(id)sender
{
    [self showRSSFeedMenu:self.businessContainer];
}

- (IBAction)entertainmentTapped:(id)sender
{
    [self showRSSFeedMenu:self.entertainmentContainer];
}

- (IBAction)bbcWorldTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:BBC_WORLD_URL];
    
    self.rssLabel.text = @"BBC World Headlines";
}

- (IBAction)reutersWorldTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:REUTERS_WORLD_URL];
    
    self.rssLabel.text = @"Reuters World Headlines";
}

- (IBAction)usaNewsWorldTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:USA_NEWS_URL];
    
    self.rssLabel.text = @"USANews & World Report Headlines";
}

- (IBAction)usaTodayWorldTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:USA_TODAY_TOP_URL];
    
    self.rssLabel.text = @"USAToday Top Stories";
}

- (IBAction)bbcTechTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:BBC_TECH_URL];
    
    self.rssLabel.text = @"BBC Tech News";
}

- (IBAction)nasaSciTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:NASA_SCIENCE_URL];
    
    self.rssLabel.text = @"NASA Science News";
}

- (IBAction)reutersTechTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:REUTERS_TECH_URL];
    
    self.rssLabel.text = @"Reuters Tech News";
}

- (IBAction)techworldTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:TECHWORLD_URL];
    
    self.rssLabel.text = @"Techworld News";
}

- (IBAction)bbcBusinessTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:BBC_BUSINESS_URL];
    
    self.rssLabel.text = @"BBC Business News";
}

- (IBAction)forbesBusinessTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:FORBES_BUSINESS_URL];
    
    self.rssLabel.text = @"Forbes Business News";
}

- (IBAction)reutersBusinessTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:REUTERS_BUSINESS_URL];
    
    self.rssLabel.text = @"Reuters Business News";
}

- (IBAction)wiredBusinessTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:WIRED_BUSINESS_URL];
    
    self.rssLabel.text = @"WIRED Business News";
}

- (IBAction)bbcEntertainmentTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:BBC_ENTERTAINMENT_URL];
    
    self.rssLabel.text = @"BBC Entertainment News";
}

- (IBAction)hrEntertainmentNewsTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:THR_ENTERTAINMENT_URL];
    
    self.rssLabel.text = @"Hollywood Reporter News";
}

- (IBAction)hrEntertainmentBoxOfficeTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:THR_BOX_OFFICE_OURL];
    
    self.rssLabel.text = @"Hollywood Reporter Box Office";
}

- (IBAction)reutersEntertainmentTapped:(id)sender
{
    [self LoadRSSFeedWithURLString:REUTERS_ENTERTAINMENT_URL];
    
    self.rssLabel.text = @"Reuters Entertainment News";
}

- (IBAction)closeTapped:(id)sender
{
    self.container1.hidden = NO;
    
    self.worldContainer.hidden = YES;
    self.sciTechContainer.hidden = YES;
    self.businessContainer.hidden = YES;
    self.entertainmentContainer.hidden = YES;
    
//    NSArray *containers = @[self.worldContainer, self.sciTechContainer, self.businessContainer, self.entertainmentContainer];
//    for (UIView *container in containers)
//    {
//        [UIView transitionFromView:container
//                            toView:self.container1
//                          duration:1.0
//                           options:UIViewAnimationOptionTransitionCrossDissolve
//                        completion:^(BOOL finished) {
//                            self.container1.hidden = NO;
//                            self.worldContainer.hidden = YES;
//                            self.sciTechContainer.hidden = YES;
//                            self.businessContainer.hidden = YES;
//                            self.entertainmentContainer.hidden = YES;
//                        }];
//    }
    
    
    
}














@end
