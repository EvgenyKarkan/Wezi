//
//  KEScreenShotUtil.m
//  Wezi
//
//  Created by Evgeniy Karkan on 26.07.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEScreenShotUtil.h"

static CGRect const kKECropRect = {101.0f, 49.0f, 585.0f, 925.0f};


@implementation KEScreenShotUtil

+ (UIImage *)makeScreenShot
{
	UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
	UIGraphicsBeginImageContext(screenWindow.frame.size);
	[screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
	
	CGImageRef imageRef = [screenshot CGImage];
	UIImage *rotatedImage = [UIImage imageWithCGImage:imageRef
												scale:5.0f
										  orientation:UIImageOrientationRight];
	
	UIGraphicsEndImageContext();
	
	return rotatedImage;
}

+ (UIImage *)cropImage
{
	CGRect croprect = kKECropRect;
	CGImageRef imageRef = CGImageCreateWithImageInRect([[self makeScreenShot] CGImage], croprect);
	UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
	CGImageRef foo = [croppedImage CGImage];
	UIImage *rotatedImage = [UIImage imageWithCGImage:foo
	                                            scale:5.0f
	                                      orientation:UIImageOrientationRight];
	
	CGImageRelease(imageRef);
	
	return rotatedImage;
}


@end
