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

@end
