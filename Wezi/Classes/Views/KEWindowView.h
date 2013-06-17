//
//  KEWindowView.h
//  Wezi
//
//  Created by Evgeniy Karkan on 5/10/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//
#import <UIKit/UIKit.h>

static NSString* const kKEWindowViewNibName = @"WindowView";

@interface KEWindowView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *conditionIcon;
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;

@property (weak, nonatomic) IBOutlet UILabel *currentTemperature;
@property (weak, nonatomic) IBOutlet UILabel *currentCondition;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *pressure;

@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;

@property (weak, nonatomic) IBOutlet UIImageView *tomorrowView;
@property (weak, nonatomic) IBOutlet UILabel *tommorowTemp;

@property (weak, nonatomic) IBOutlet UIImageView *afterTommorowView;
@property (weak, nonatomic) IBOutlet UILabel *afterTommorowTemp;

@property (weak, nonatomic) IBOutlet UIImageView *afterAfterTommorowView;
@property (weak, nonatomic) IBOutlet UILabel *afrerAfterTommorowTemp;
@property (weak, nonatomic) IBOutlet UILabel *windAbbreviation;

+ (KEWindowView *)returnWindowView;

@end
