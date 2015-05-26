//
//  MethodsCache.m
//  YourDay
//
//  Created by Michael Hoffman on 4/30/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import "MethodsCache.h"

@implementation MethodsCache


-(UIColor *)navyFog
{
    UIColor *navyFog = [UIColor colorWithRed:61.0/255 green:73.0/255 blue:96.0/255 alpha:1.0];
    return navyFog;
}

-(void)buttonBorder:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

-(void)buttonFillColor:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.backgroundColor = [UIColor clearColor];
    }
}

-(void)containerFillColor:(NSArray *)array
{
    for (UIView *view in array)
    {
        view.backgroundColor = [UIColor clearColor];
    }
}

-(void)createContainerBottomBorderWithDimensions:(UIView *)containerView andMainView:(UIView *)selfView
{
    CGFloat border = 2;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor whiteColor].CGColor;
    bottomBorder.frame = CGRectMake(0, containerView.bounds.size.height, selfView.bounds.size.width, border);
    bottomBorder.borderWidth = border;
    [containerView.layer addSublayer:bottomBorder];
}

-(void)containerBottomBorder:(NSArray *)array comparedToMainView:(UIView *)selfView
{
    for (UIView *container in array)
    {
        [self createContainerBottomBorderWithDimensions:container andMainView:selfView];
    }
}

-(void)feedButtonCenterText:(NSArray *)array
{
    for (UIButton *button in array)
    {
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
}

-(void)vericalLabel:(UILabel *)label scaleHeight:(CGFloat)floatX scaleWidth:(CGFloat)floatY
{
    label.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(M_PI_2*3), floatX, floatY);
}

-(void)attributedString:(NSString *)string forLabel:(UILabel *)label withKern:(CGFloat)spacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedString addAttribute:NSKernAttributeName value:@(spacing) range:NSMakeRange(0, [string length])];
    label.attributedText = attributedString;
}

-(void)createVerticalLabelforButton:(UIButton *)button withString:(NSString *)string kern:(CGFloat)spacing scaleHeight:(CGFloat)floatX scaleWidth:(CGFloat)floatY
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-button.frame.size.height*0.375, -button.frame.size.width*0.167, button.frame.size.height, button.frame.size.height)];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.textColor = [self navyFog];
    label.backgroundColor = [UIColor clearColor];
    
    [self attributedString:string forLabel:label withKern:10.0f];
    [self vericalLabel:label scaleHeight:floatX scaleWidth:floatY];
    
    [button addSubview:label];
}

-(void)formatCloseButton:(NSArray *)array withString:(NSString *)string kern:(CGFloat)spacing scaleHeight:(CGFloat)floatX scaleWidth:(CGFloat)floatY
{
    for (UIButton *button in array)
    {
        [self createVerticalLabelforButton:button
                                withString:string
                                      kern:spacing
                               scaleHeight:floatX
                                scaleWidth:floatY];
    }
}

-(void) convertEpochTimeToHumanReadable:(NSTimeInterval)time
{
    NSDate *humanDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *resultString = [formatter stringFromDate:humanDate];
    
    NSLog(@"Real Time: %@", resultString);
}

-(NSString *) convertDecimalToRoundedString:(NSNumber *)number
{
    CGFloat convertNumber = [number floatValue];
    NSString *roundedString = [NSString stringWithFormat:@"%.0f",convertNumber];
    
    return roundedString;
}

-(NSString *) convertToTemperature:(NSNumber *)number
{
    NSString *convertedNumber = [self convertDecimalToRoundedString:number];
    NSString *temperatureString = [NSString stringWithFormat:@"%@°", convertedNumber];
    return temperatureString;
}

-(NSString *) convertEpochTimeToHumanHours:(NSNumber *)number
{
    NSInteger convertedNumber = [number integerValue];
    NSTimeInterval time = convertedNumber;
    NSDate *humanDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h a"];
    
    NSString *truncatedTime = [formatter stringFromDate:humanDate];
    
    return truncatedTime;
}

-(NSString *) convertToHiTemperature:(NSNumber *)number
{
    NSString *convertedNumber = [self convertDecimalToRoundedString:number];
    NSString *temperatureString = [NSString stringWithFormat:@"hi: %@°", convertedNumber];
    return temperatureString;
}

-(NSString *) convertToLoTemperature:(NSNumber *)number
{
    NSString *convertedNumber = [self convertDecimalToRoundedString:number];
    NSString *temperatureString = [NSString stringWithFormat:@"lo: %@°", convertedNumber];
    return temperatureString;
}














@end
