//
//  KESplashScreenUtil.m
//  Wezi
//
//  Created by Evgeniy Karkan on 16.07.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KESplashScreenUtil.h"

static NSString * const kKESplashImage = @"Default-Landscape~ipad.png";
static NSString * const kKESpalshEnd = @"SplashEnd";

@implementation KESplashScreenUtil

+ (void)showSplashScreenOnView:(UIView *)view
{
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
	    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kKESplashImage]];
			//TODO: add below constant as in VLK 
	    imageView.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 748.0f);
		
	    [view addSubview:imageView];
	    [view bringSubviewToFront:imageView];
		
		[UIView animateWithDuration:2.0f
		                      delay:2.0f
		                    options:UIViewAnimationOptionCurveEaseInOut
		                 animations: ^{
							 imageView.alpha = 0.0f;
						 }
						 completion: ^(BOOL finished) {
							 [imageView removeFromSuperview];
						 }];
	});
}

@end
