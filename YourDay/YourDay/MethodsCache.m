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

-(NSString *) convertEpochTimeToHumanDay:(NSNumber *)number
{
    NSInteger convertedNumber = [number integerValue];
    NSTimeInterval time = convertedNumber;
    NSDate *humanDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE"];
    
    NSString *lowercaseDayFormat = [[formatter stringFromDate:humanDate] lowercaseStringWithLocale:[NSLocale currentLocale]];
    
    return lowercaseDayFormat;
}

-(NSString *) convertEpochTimeToHumanDate:(NSNumber *)number
{
    NSInteger convertedNumber = [number integerValue];
    NSTimeInterval time = convertedNumber;
    NSDate *humanDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d"];
    
    //NSString *lowercaseFormat = [[formatter stringFromDate:humanDate] lowercaseStringWithLocale:[NSLocale currentLocale]];
    NSString *truncatedDate = [formatter stringFromDate:humanDate];
    
    return truncatedDate;
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

-(NSString *) convertToHumidityLabel:(NSNumber *)number
{
    CGFloat convertNumber = [number floatValue];
    NSString *humidityString = [NSString stringWithFormat:@"hum: %.0f%%", (convertNumber*100)];
    
    return humidityString;
}

-(NSString *) convertToPrecipProbability:(NSString *)precipType Probability:(NSNumber *)number
{
    CGFloat convertNumber = [number floatValue];
    if (precipType == nil)
    {
        NSString *precipString = [NSString stringWithFormat:@"0%% precipitation"];
        return precipString;
    }
    if ((convertNumber < 1.0f))
    {
        NSString *precipString = [NSString stringWithFormat:@"%@? %.0f%% chance", precipType, (convertNumber*100)];
        return precipString;
    }
    
    NSString *precipString = [NSString stringWithFormat:@"%@? 100%% chance", precipType];
    return precipString;
    
}

-(NSString *) convertToWindBearing:(NSNumber *)number1 AndSpeed:(NSNumber *)number2
{
    NSString *windWithSpeed = [NSString stringWithFormat:@"wind: %@ %@ mph", [self convertToWindDirection:number1], [self convertDecimalToRoundedString:number2]];
    return windWithSpeed;
}

-(NSString *) convertToVisibilityLabel:(NSNumber *)number
{
    if (number == nil) {
        NSString *visibilityString = [NSString stringWithFormat:@"visibility: no data"];
        return visibilityString;
    }
    NSString *visibilityString = [NSString stringWithFormat:@"visibility: %@ mi", [self convertDecimalToRoundedString:number]];
    return visibilityString;
}

-(NSString *) convertToWindDirection:(NSNumber *)number
{
    NSInteger convertedNumber = [number integerValue];
    NSString *direction;
    
    if ((convertedNumber >= 0) && (convertedNumber <= 11))
    {
        direction = @"N";
    } else if ((convertedNumber >= 12) && (convertedNumber <= 34))
    {
        direction = @"NNE";
    } else if ((convertedNumber >= 35) && (convertedNumber <= 57))
    {
        direction = @"NE";
    } else if ((convertedNumber >= 58) && (convertedNumber <= 79))
    {
        direction = @"ENE";
    } else if ((convertedNumber >= 80) && (convertedNumber <= 101))
    {
        direction = @"E";
    } else if ((convertedNumber >= 102) && (convertedNumber <= 124))
    {
        direction = @"ESE";
    } else if ((convertedNumber >= 125) && (convertedNumber <= 146))
    {
        direction = @"SE";
    } else if ((convertedNumber >= 147) && (convertedNumber <= 169))
    {
        direction = @"SSE";
    } else if ((convertedNumber >= 170) && (convertedNumber <= 191))
    {
        direction = @"S";
    } else if ((convertedNumber >= 192) && (convertedNumber <= 214))
    {
        direction = @"SSW";
    } else if ((convertedNumber >= 215) && (convertedNumber <= 236))
    {
        direction = @"SW";
    } else if ((convertedNumber >= 237) && (convertedNumber <= 259))
    {
        direction = @"WSW";
    } else if ((convertedNumber >= 260) && (convertedNumber <= 281))
    {
        direction = @"W";
    } else if ((convertedNumber >= 282) && (convertedNumber <= 304))
    {
        direction = @"WNW";
    } else if ((convertedNumber >= 305) && (convertedNumber <= 326))
    {
        direction = @"NW";
    } else if ((convertedNumber >= 327) && (convertedNumber <= 349))
    {
        direction = @"NNW";
    } else if ((convertedNumber >= 350) && (convertedNumber <= 360))
    {
        direction = @"N";
    }
    
    return direction;
}

-(void) convertString:(NSString *)icon ToDarkIcon:(UIImageView *)view
{
    if ([icon isEqualToString:@"clear-day"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-sunny"];
    }
    else if ([icon isEqualToString:@"partly-cloudy-day"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-pc-day"];
    }
    else if ([icon isEqualToString:@"partly-cloudy-night"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-pc-night"];
    }
    else if ([icon isEqualToString:@"cloudy"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-cloudy"];
    }
    else if ([icon isEqualToString:@"rain"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-rain-cloud"];
    }
    else if ([icon isEqualToString:@"thunderstorm"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-thunderstorm"];
    }
    else if ([icon isEqualToString:@"clear-night"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-moon"];
    }
    else if ([icon isEqualToString:@"hail"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-hail"];
    }
    else if ([icon isEqualToString:@"snow"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-snowflake"];
    }
    else if ([icon isEqualToString:@"tornado"])
    {
        view.image = [UIImage imageNamed:@"icon-dark-tornado"];
    }
}

-(void) convertString:(NSString *)icon ToLightIcon:(UIImageView *)view
{
    if ([icon isEqualToString:@"clear-day"])
    {
        view.image = [UIImage imageNamed:@"icon-light-sunny"];
    }
    else if ([icon isEqualToString:@"partly-cloudy-day"])
    {
        view.image = [UIImage imageNamed:@"icon-light-pc-day"];
    }
    else if ([icon isEqualToString:@"partly-cloudy-night"])
    {
        view.image = [UIImage imageNamed:@"icon-light-pc-night"];
    }
    else if ([icon isEqualToString:@"cloudy"])
    {
        view.image = [UIImage imageNamed:@"icon-light-cloudy"];
    }
    else if ([icon isEqualToString:@"rain"])
    {
        view.image = [UIImage imageNamed:@"icon-light-rain-cloud"];
    }
    else if ([icon isEqualToString:@"thunderstorm"])
    {
        view.image = [UIImage imageNamed:@"icon-light-thunderstorm"];
    }
    else if ([icon isEqualToString:@"clear-night"])
    {
        view.image = [UIImage imageNamed:@"icon-light-moon"];
    }
    else if ([icon isEqualToString:@"hail"])
    {
        view.image = [UIImage imageNamed:@"icon-light-hail"];
    }
    else if ([icon isEqualToString:@"snow"])
    {
        view.image = [UIImage imageNamed:@"icon-light-snowflake"];
    }
    else if ([icon isEqualToString:@"tornado"])
    {
        view.image = [UIImage imageNamed:@"icon-light-tornado"];
    }
}









@end
