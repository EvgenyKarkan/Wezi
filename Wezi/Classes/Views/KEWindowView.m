//
//  KEWindowView.m
//  Wezi
//
//  Created by Evgeniy Karkan on 5/10/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEWindowView.h"
#import "KEFonts.h"
#import "KEBackingImageUtil.h"
#import "UIView+Decorate.h"

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
    tempView.layer.borderColor = [[UIColor whiteColor] CGColor];
    tempView.layer.borderWidth  = 5.0f;
    [tempView addRoundShadowWithOpacity:0.6f];
    
    return tempView;
}

+ (KEWindowView *)returnWindowView
{
    KEWindowView *dummyView = (KEWindowView *)[self loadViewFromNibWithName:kKEWindowViewNibName];
    dummyView.backImageView.image = [UIImage imageNamed:[KEBackingImageUtil randomObjectFromArray]];
    [KEWindowView settingFontsToUIElements:dummyView];

    return dummyView;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

+ (void)settingFontsToUIElements:(KEWindowView *)aView
{
    NSMutableArray *allLabelArray = [NSMutableArray arrayWithArray:@[aView.timeStamp, aView.wind,
                                                                     aView.humidity, aView.pressure,
                                                                     aView.windAbbreviation, aView.currentCondition]];
    
    for (UILabel *label in allLabelArray) {
        [label setFont:[KEFonts plutoSansRegularWithSize:20.0f]];
    }
    
    [aView.place setFont:[KEFonts plutoSansRegularWithSize:32.0f]];
    [aView.currentTemperature setFont:[KEFonts plutoSansRegularWithSize:72.0f]];
    
}


@end

