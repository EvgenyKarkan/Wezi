//
//  SUViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 4/26/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface KEViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak  ) IBOutlet UIPageControl   *pageControl;
@property (nonatomic, weak  ) IBOutlet UIScrollView    *scrollView;
@property (nonatomic, weak  ) IBOutlet UINavigationBar *navBar;
@property (nonatomic, weak  ) IBOutlet UIImageView     *weziImage;
@property (nonatomic, weak  ) IBOutlet UIToolbar       *downBar;
@property (nonatomic, strong) UIStoryboardPopoverSegue *currentPopoverSegue;

@end





