//
//  SUViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KEWeatherManager.h"

@interface KEViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak)         IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak)         IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)       IBOutlet UINavigationBar *navBar;
@property (nonatomic, weak)         IBOutlet UIImageView *weziImage;
@property (weak, nonatomic)         IBOutlet UIToolbar *downBar;
@property (nonatomic, strong)       UIStoryboardPopoverSegue *currentPopoverSegue;


@end





