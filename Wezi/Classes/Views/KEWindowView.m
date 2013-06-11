//
//  KEWindowView.m
//  Wezi
//
//  Created by Evgeniy Karkan on 5/10/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#define GRADIENT_COLOR_1    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1] CGColor]
#define GRADIENT_COLOR_2    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1] CGColor]
#define GRADIENT_COLOR_3    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1] CGColor]

#import "KEWindowView.h"
#import "KEFonts.h"

@interface KEWindowView()

+ (UIView *)loadViewFromNibWithName:(NSString *)nibName;

@end

@implementation KEWindowView

+ (UIView *)loadViewFromNibWithName:(NSString *)nibName
{
    NSArray *previews = [[NSBundle mainBundle] loadNibNamed:nibName
                                                      owner:self
                                                    options:nil];
    UIView *tempView = [previews objectAtIndex:0];
    tempView.layer.cornerRadius = 20.0f;
    tempView.layer.borderColor = [[UIColor whiteColor] CGColor];
    tempView.layer.borderWidth  = 3.0f;
    tempView.layer.shadowColor = [[UIColor blackColor] CGColor];
    tempView.layer.shadowOffset = CGSizeZero;
    tempView.layer.shadowOpacity = 2.99f;
    tempView.layer.shadowRadius = 10.0f;
   
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
    NSMutableArray *allLabelArray = [NSMutableArray arrayWithArray:@[aView.currentTemperature, aView.timeStamp, aView.wind,
                                                                     aView.humidity, aView.place, aView.pressure]];
    
    for (UILabel *label in allLabelArray) {
        [label setFont:[KEFonts plutoSansRegularWithSize:17.0f]];
    }
}


@end

