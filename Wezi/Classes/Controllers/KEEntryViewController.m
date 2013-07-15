//
//  KEEntryViewController.m
//  Wezi
//
//  Created by Evgeniy Karkan on 7/16/13.
//  Copyright (c) 2012 SU23. All rights reserved.
//

#define presentEntryViewControllerDuration 1.5f
#define dismissEntryViewControllerDuration 1.5f
#define durationEntryViewControllerDuration 0.3f
#define upBarHeight 0

#import "KEEntryViewController.h"


@implementation KEEntryViewController
{
    NSObject *actionObject;
    SEL nextAaction;
    UIImageView *splashImageView;
    UIImageView *rootSplashImageView;
}


- (id)initWithSplashImage:(UIImage *)image withFadingImage:(UIImage *)fadingImage withRect:(CGRect)rect
{
	self = [super init];
	if (self) {
		self.view = [[UIView alloc] init];
		[self.view setBackgroundColor:[UIColor clearColor]];
		
		CGRect newRect = CGRectMake(rect.origin.x, rect.origin.y + upBarHeight, rect.size.width, rect.size.height - upBarHeight);
		
		rootSplashImageView = [[UIImageView alloc]initWithImage:image];
		self.view.frame = newRect;
		rootSplashImageView.frame = newRect;
		
		splashImageView = [[UIImageView alloc]initWithImage:fadingImage];
		[splashImageView setFrame:newRect];
		[splashImageView setAlpha:0.0];
		
		[self.view addSubview:rootSplashImageView];
		[self.view addSubview:splashImageView];
	}
	return self;
}

- (void)presentSelfFotTime:(int)time
{
	CGRect endRect = self.view.frame;
	CGRect startRect = endRect;
		//    startRect.origin.y = self.view.window.frame.size.height;
	splashImageView.frame = startRect;
	
	[UIView animateWithDuration:presentEntryViewControllerDuration
	                      delay:0.0f
	                    options:UIViewAnimationOptionLayoutSubviews
	                 animations: ^{
						 [splashImageView setFrame:endRect];
						 [splashImageView setAlpha:1.0];
					 }
	                 completion: ^(BOOL finished) {
						 if (finished) {
							 [self performSelector:@selector(dismissSelf) withObject:self afterDelay:time];
						 }
	 }];
}

- (void)dismissSelf
{
	[rootSplashImageView removeFromSuperview];
	[UIView animateWithDuration:dismissEntryViewControllerDuration
	                      delay:0.0f
	                    options:UIViewAnimationOptionLayoutSubviews
	                 animations: ^{
						 self.view.alpha = 0.0f;
					 }
	                 completion: ^(BOOL finished) {
						 if (finished) {
							 [self.view removeFromSuperview];
						 }
	 }];
}

- (void)setNextAction:(SEL)newAction forObject:(NSObject *)object
{
	nextAaction = newAction;
	actionObject = object;
}

@end
