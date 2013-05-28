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

@property (weak, nonatomic) IBOutlet UIView *shadowContainerView;
@property (weak, nonatomic) IBOutlet GradientView *observationContainerView;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *devointLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateLAbel;

@property (weak, nonatomic) IBOutlet UIImageView *currentConditionImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weatherUndegroundImageView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;

@end





