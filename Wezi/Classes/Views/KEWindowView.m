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

static CGFloat const kKEBorderWidth			   = 5.0f;
static CGFloat const kKEOpacity                = 0.6f;
static CGFloat const kKEBunchOfLabelFontSize   = 25.0f;
static CGFloat const kKEPlaceFontSize          = 35.0f;
static CGFloat const kKECurrentTempFontSize    = 72.0f;
static CGFloat const kKETimeStampFontSize	   = 15.0f;
static CGFloat const kKEForecastLabelsFontSize = 18.0f;
static CGRect const kKERectSad = {100, 100, 300, 300};

@interface KEWindowView ()

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
    tempView.layer.borderWidth  = kKEBorderWidth;
    [tempView addRoundShadowWithOpacity:kKEOpacity];
	
    return tempView;
}

+ (KEWindowView *)returnWindowView
{
    KEWindowView *dummyView = (KEWindowView *)[self loadViewFromNibWithName:kKEWindowViewNibName];
    dummyView.backImageView.image = [UIImage imageNamed:[KEBackingImageUtil randomObjectFromArray]];
    [KEWindowView settingUIElements:dummyView];

    return dummyView;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

+ (void)settingUIElements:(KEWindowView *)aView
{
    NSMutableArray *allLabelArray = [NSMutableArray arrayWithArray:@[aView.wind,
																	 aView.humidity,
																	 aView.pressure,
                                                                     aView.windAbbreviation,
																	 aView.currentCondition,
                                                                     aView.tommorowTemp,
																	 aView.afterTommorowTemp,
																	 aView.afrerAfterTommorowTemp]];
    
    for (UILabel *label in allLabelArray) {
        [label setFont:[KEFonts plutoSansRegularWithSize:kKEBunchOfLabelFontSize]];
    }
    
    [aView.place setFont:[KEFonts plutoSansRegularWithSize:kKEPlaceFontSize]];
    [aView.currentTemperature setFont:[KEFonts plutoSansRegularWithSize:kKECurrentTempFontSize]];
	[aView.timeStamp setFont:[KEFonts plutoSansRegularWithSize:kKETimeStampFontSize]];
	[aView.today setFont:[KEFonts plutoSansRegularWithSize:kKEBunchOfLabelFontSize]];
	[aView.today setText:@"Today"];
	
	NSMutableArray *forecastLabelsArray = [NSMutableArray arrayWithArray:@[aView.dateT,
																		   aView.dateAT,
																		   aView.dateAAT,]];
	
    for (UILabel *label in forecastLabelsArray) {
		[label setFont:[KEFonts plutoSansRegularWithSize:kKEForecastLabelsFontSize]];
	}
	
	aView.sadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sad"]];
	aView.sadView.frame = kKERectSad;
	[aView addSubview:aView.sadView];
	aView.sadView.hidden = YES;
}

@end

