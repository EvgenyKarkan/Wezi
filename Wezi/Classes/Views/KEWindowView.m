//
//  KEWindowView.m
//  Wezi
//
//  Created by Evgeniy Karkan on 5/10/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEWindowView.h"

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
    NSArray *previews = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    UIView *tempView = [previews objectAtIndex:0];
    return tempView;
}

+ (KEWindowView *)returnWindowView
{
    KEWindowView *dummyView = (KEWindowView *)[self loadViewFromNibWithName:kKEWindowViewNibName];
    return dummyView;
}

@end
