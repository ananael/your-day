//
//  RSSDetailViewController.m
//  YourDay
//
//  Created by Michael Hoffman on 4/28/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "RSSDetailViewController.h"

@interface RSSDetailViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;



@end

@implementation RSSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.toolbar.translucent = NO;
    
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSURL *url = [NSURL URLWithString:[self.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self.webView addSubview:actInd];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:nil repeats:YES];
    
}

-(void) loading
{
    if (!self.webView.loading)
    {
        [actInd stopAnimating];
        
    } else
    {
        [actInd startAnimating];
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
