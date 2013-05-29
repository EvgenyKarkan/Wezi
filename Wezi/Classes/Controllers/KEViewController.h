//
//  SUViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KEWeatherManager.h"

@class GradientView;
@class KEMapViewController;

@interface KEViewController : UIViewController <UpdateUIWithForecast, UIScrollViewDelegate>

@property (nonatomic, weak)         IBOutlet UIView *shadowContainerView;
@property (nonatomic, weak)         IBOutlet GradientView *observationContainerView;

@property (nonatomic, weak)         IBOutlet UILabel *locationLabel;
@property (nonatomic, weak)         IBOutlet UILabel *currentTemperatureLabel;
@property (nonatomic, weak)         IBOutlet UILabel *feelsLikeTemperatureLabel;
@property (nonatomic, weak)         IBOutlet UILabel *weatherDescriptionLabel;
@property (nonatomic, weak)         IBOutlet UILabel *windDescriptionLabel;
@property (nonatomic, weak)         IBOutlet UILabel *humidityLabel;
@property (nonatomic, weak)         IBOutlet UILabel *devointLabel;
@property (nonatomic, weak)         IBOutlet UILabel *lastUpdateLAbel;

@property (nonatomic, weak)         IBOutlet UIImageView *currentConditionImageView;
@property (nonatomic, weak)         IBOutlet UIImageView *weatherUndegroundImageView;

@property (nonatomic, weak)         IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak)         IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong)       UIStoryboardPopoverSegue *currentPopoverSegue;

@end





