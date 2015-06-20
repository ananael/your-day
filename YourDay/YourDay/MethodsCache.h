//
//  MethodsCache.h
//  YourDay
//
//  Created by Michael Hoffman on 4/30/15.
//  Copyright (c) 2015 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MethodsCache : NSObject

-(UIColor *)navyFog;
-(void)buttonBorder:(NSArray *)array;
-(void)buttonFillColor:(NSArray *)array;
-(void)containerFillColor:(NSArray *)array;
-(void)changeLabelText:(NSArray *)array ToColor:(UIColor *)color;
-(void)createContainerBottomBorderWithDimensions:(UIView *)containerView
                                     andMainView:(UIView *)selfView;

-(void)containerBottomBorder:(NSArray *)array comparedToMainView:(UIView *)selfView;

-(void)feedButtonCenterText:(NSArray *)array;
-(void)attributedString:(NSString *)string forLabel:(UILabel *)label withKern:(CGFloat)spacing;

-(void)createVerticalLabelforButton:(UIButton *)button
                         withString:(NSString *)string
                               kern:(CGFloat)spacing
                        scaleHeight:(CGFloat)floatX
                         scaleWidth:(CGFloat)floatY;

-(void)formatCloseButton:(NSArray *)array
              withString:(NSString *)string
                    kern:(CGFloat)spacing
             scaleHeight:(CGFloat)floatX
              scaleWidth:(CGFloat)floatY;

-(void)transferHourlyData:(NSDictionary *)dict ForNumberKey:(NSString *)key ToArray:(NSMutableArray *)array;
-(void)transferHourlyData:(NSDictionary *)dict ForStringKey:(NSString *)key ToArray:(NSMutableArray *)array;
-(void) convertEpochTimeToHumanReadable:(NSTimeInterval)time;
-(NSString *) convertDecimalToRoundedString:(NSNumber *)number;
-(NSString *) convertToTemperature:(NSNumber *)number;
-(NSString *) convertEpochTimeToHumanHours:(NSNumber *)number;
-(NSString *) convertEpochTimeToHumanDay:(NSNumber *)number;
-(NSString *) convertEpochTimeToHumanDate:(NSNumber *)number;
-(NSString *) convertToHiTemperature:(NSNumber *)number;
-(NSString *) convertToLoTemperature:(NSNumber *)number;
-(NSString *) convertToHumidityLabel:(NSNumber *)number;
-(NSString *) convertToPrecipProbability:(NSString *)precipType Probability:(NSNumber *)number;
-(NSString *) convertToWindBearing:(NSNumber *)number1 AndSpeed:(NSNumber *)number2;
-(NSString *) convertToWindDirection:(NSNumber *)number;
-(NSString *) convertToVisibilityLabel:(NSNumber *)number;
//-(void) convertWeatherType:(NSString *)string ForView:(UIImageView *)view UsingIconStyle:(NSString *)style;
-(void) convertWeatherType:(NSString *)string ForView:(UIImageView *)view UsingIconStyle:(NSString *)style;








@end
