//
//  KEWindowView.m
//  Wezi
//
//  Created by Evgeniy Karkan on 5/10/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEWindowView.h"
#import "KEFonts.h"

#define GRADIENT_COLOR_1    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1] CGColor]
#define GRADIENT_COLOR_2    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1] CGColor]
#define GRADIENT_COLOR_3    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1] CGColor]


@interface KEWindowView()

+ (UIView *)loadViewFromNibWithName:(NSString *)nibName;

@end

@implementation KEWindowView

@synthesize conditionIcon;
@synthesize currentCondition;
@synthesize currentTemperature;
@synthesize wind;
@synthesize humidity;
@synthesize pressure;
@synthesize tomorrowView;
@synthesize tommorowTemp;
@synthesize afterTommorowView;
@synthesize afterTommorowTemp;
@synthesize afterAfterTommorowView;
@synthesize afrerAfterTommorowTemp;

+ (UIView *)loadViewFromNibWithName:(NSString *)nibName
{
    NSArray *previews = [[NSBundle mainBundle] loadNibNamed:nibName
                                                      owner:self
                                                    options:nil];
    UIView *tempView = [previews objectAtIndex:0];
    tempView.layer.cornerRadius = 20.0f;
    tempView.layer.borderColor = [[UIColor whiteColor] CGColor];
    tempView.layer.borderWidth  = 6.0f;
    tempView.layer.shadowColor = [[UIColor blackColor] CGColor];
    tempView.layer.shadowOffset = CGSizeZero;
    tempView.layer.shadowOpacity = 2.99f;
    tempView.layer.shadowRadius = 15.0f;
   
    
    return tempView;
}

+ (KEWindowView *)returnWindowView
{
    KEWindowView *dummyView = (KEWindowView *)[self loadViewFromNibWithName:kKEWindowViewNibName];
    
    CAGradientLayer *gradientLayer = (CAGradientLayer *)dummyView.layer;
    gradientLayer.colors = @[(id)GRADIENT_COLOR_1,(id)GRADIENT_COLOR_2];
    [KEWindowView settingFontsToUIElements:dummyView];

    return dummyView;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

+ (void)settingFontsToUIElements:(KEWindowView *)aView
{
    [aView.currentTemperature setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
    [aView.timeStamp setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
    [aView.wind setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
    [aView.humidity setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
    [aView.timeStamp setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
    [aView.place setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
    [aView.pressure setFont:[KEFonts plutoSansHeavyWithSize:17.0f]];
}
@end

