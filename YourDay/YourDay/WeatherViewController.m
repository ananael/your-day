//
//  WeatherViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 3/25/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "WeatherViewController.h"
#import <SWRevealViewController.h>
#import "Constants.h"
#import "MethodsCache.h"
#import "WeeklyWeatherViewController.h"


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

@property (weak, nonatomic) IBOutlet UIView *buttonContainer;

@property (strong, nonatomic) NSMutableArray *contentBoxes;
@property (strong, nonatomic) NSMutableArray *degreeArray;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSMutableArray *temperatures;
@property (strong, nonatomic) NSMutableArray *hours;

@property (strong, nonatomic) Forecastr *forecastr;

@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) MethodsCache *methods;



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
    
    self.methods = [MethodsCache new];
    
    self.locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    self.locationManager.delegate = self; // setting the delegate of locationManager to self.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    [self.locationManager startUpdatingLocation];  //requesting location updates
    
    NSLog(@"View Did Load values: %@", [self deviceLocation]);
    
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
    
    // Creates the views (boxes) inside the Scroll View
    self.contentBoxes = [NSMutableArray new];
    self.timeArray = [NSMutableArray new];
    self.degreeArray = [NSMutableArray new];
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
        [self.degreeArray addObject:weatherLabelBox];
        [self.contentBoxes addObject:hourlyContentBox];
        
        [self.scrollContent addSubview:hourlyContentBox];
        
    }
    
    //Button segues to WeeklyWeatherVC
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [moreButton addTarget:self action:@selector(moreButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.backgroundColor = [UIColor whiteColor];
    moreButton.layer.cornerRadius = 20;
    [moreButton setTitle:@"more" forState:UIControlStateNormal];
    [moreButton setTitleColor:[self.methods navyFog] forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:12];
    [self.buttonContainer addSubview:moreButton];
    
    
    self.temperatures = [NSMutableArray new];
    self.hours = [NSMutableArray new];
    

    self.forecastr = [Forecastr sharedManager];
    self.forecastr.apiKey = FORECAST_API_KEY;
    
    [self.forecastr getForecastForLocation:self.locationManager.location
                                      time:nil
                                exclusions:nil
                                    extend:nil
                                   success:^(id JSON)
    {
        float latitude = self.locationManager.location.coordinate.latitude;
        float longitude = self.locationManager.location.coordinate.longitude;
        
        [self.forecastr getForecastForLatitude:latitude
                                     longitude:longitude
                                          time:nil
                                    exclusions:nil
                                        extend:nil
                                       success:^(id JSON)
        {
            self.resultsDictionary = JSON;
            
            NSLog(@"Temp: %@ \n Today: %@ \n Lat & Long: %f , %f", self.resultsDictionary[@"currently"][@"temperature"], self.resultsDictionary[@"daily"][@"data"], self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
            
            
            self.hiTempLabel.text = [self.methods convertToHiTemperature:self.resultsDictionary[@"daily"][@"data"][0][@"apparentTemperatureMax"]];
            self.weatherDescriptionLabel.text = self.resultsDictionary[@"currently"][@"summary"];
            self.currentTempLabel.text = [self.methods convertToTemperature:self.resultsDictionary[@"currently"][@"temperature"]];
            self.loTempLabel.text = [self.methods convertToLoTemperature:self.resultsDictionary[@"daily"][@"data"][0][@"apparentTemperatureMin"]];
            self.feelsLikeTempLabel.text = [self.methods convertToTemperature:self.resultsDictionary[@"currently"][@"apparentTemperature"]];
            
            //Pulls in the time starting with the array[1]
            //Time for the hour after the current hour
            for (NSInteger i = 1; i < 25; i++)
            {
                NSNumber *eachHour;
                eachHour = self.resultsDictionary[@"hourly"][@"data"][i][@"time"];
                
                [self.hours addObject:eachHour];
            }
            
            for (NSInteger i=0; i<[self.timeArray count]; i++)
            {
                UILabel *hourLabel;
                
                hourLabel = [self.timeArray objectAtIndex:i];
                hourLabel.text = [self.methods convertEpochTimeToHumanHours:[self.hours objectAtIndex:i]];
                hourLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
                hourLabel.textColor = [UIColor whiteColor];
                hourLabel.textAlignment = NSTextAlignmentCenter;
                
            }
            
            //Pulls in the temperature starting with the array[1]
            //Temperature to match the hour
            for (NSInteger i = 1; i < 25; i++)
            {
                NSNumber *hourlyTemp;
                hourlyTemp = self.resultsDictionary[@"hourly"][@"data"][i][@"temperature"];
                
                [self.temperatures addObject:hourlyTemp];
            }
            
            for (NSInteger i=0; i<[self.temperatures count]; i++)
            {
                UILabel *degreeLabel;
                
                degreeLabel = [self.degreeArray objectAtIndex:i];
                degreeLabel.text = [self.methods convertToTemperature:[self.temperatures objectAtIndex:i]];
                degreeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
                degreeLabel.textColor = [UIColor whiteColor];
                degreeLabel.textAlignment = NSTextAlignmentCenter;
                
            }
            
            
                                       }
                                       failure:^(NSError *error, id response) {
                                           NSLog(@"Error while retrieving forecast: %@", [self.forecastr messageForError:error withResponse:response]);
                                       }];
                                   }
                                   failure:^(NSError *error, id response) {
                                       NSLog(@"Error while retrieving forecast: %@", [self.forecastr messageForError:error withResponse:response]);
                                   }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)containersArray
{
    NSArray *containerViews = @[self.mainDesignContainer, self.container1, self.container2, self.container3, self.scrollContainer, self.scrollContent, self.buttonContainer];
    return containerViews;
}

//TODO: Remove this method
//Used in NSLog
-(NSString *) deviceLocation
{
    return [NSString stringWithFormat:@"latitude: %f  longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
//    self.latitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
//    self.longitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
//    self.altitude.text = [NSString stringWithFormat:@"%.0f m",crnLoc.altitude];
//    self.speed.text = [NSString stringWithFormat:@"%.1f m/s", crnLoc.speed];
    
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"From the method: %@", crnLoc);
}

- (IBAction)moreButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"weeklySegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"weeklySegue"])
    {
        WeeklyWeatherViewController *weeklyVC = segue.destinationViewController;
        weeklyVC.resultsDictionary = self.resultsDictionary;
        
    }
    
 
}


@end
