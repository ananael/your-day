//
//  RSSDetailViewController.h
//  YourDay
//
//  Created by Michael Hoffman on 4/28/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSDetailViewController : UIViewController <UIWebViewDelegate> {
    
    IBOutlet UIActivityIndicatorView *actInd;
    NSTimer *timer;
    
}

@property (copy, nonatomic) NSString *url;

@end
