//
//  KEWindowView.h
//  Wezi
//
//  Created by Evgeniy Karkan on 5/10/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

static NSString * const kKEWindowViewNibName = @"WindowView";


@interface KEWindowView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *conditionIcon;

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
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *dateT;
@property (weak, nonatomic) IBOutlet UILabel *dateAT;
@property (weak, nonatomic) IBOutlet UILabel *dateAAT;

@property (weak, nonatomic) IBOutlet UILabel *today;

@property (nonatomic, strong) UIImageView *sadView;

+ (KEWindowView *)returnWindowView;

@end

