//
//  KEEntryViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 7/16/13.
//  Copyright (c) 2012 SU23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KEEntryViewController : UIViewController

- (id)initWithSplashImage:(UIImage *)image
		  withFadingImage:(UIImage *)fadingImage
				  withRect:(CGRect)rect;
- (void)presentSelfFotTime:(int)time;
- (void)setNextAction:(SEL)newAction forObject:(NSObject *)object;

@end
