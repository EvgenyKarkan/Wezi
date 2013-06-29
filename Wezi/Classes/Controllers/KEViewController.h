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

@property (nonatomic, weak)         IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak)         IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)       IBOutlet UINavigationBar *navBar;
@property (nonatomic, weak)         IBOutlet UIImageView *weziImage;
@property (nonatomic, weak)         IBOutlet UIButton *addButton;



@property (nonatomic, strong)       UIStoryboardPopoverSegue *currentPopoverSegue;


@end





