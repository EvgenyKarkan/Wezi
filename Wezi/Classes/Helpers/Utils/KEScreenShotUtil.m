//
//  KEScreenShotUtil.m
//  Wezi
//
//  Created by Evgeniy Karkan on 26.07.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEScreenShotUtil.h"

static CGRect const kKECropRectRight = { 104.0f, 54.0f, 578.0f, 918.0f };
static CGRect const kKECropRectLeft = { 84.0f, 54.0f, 578.0f, 918.0f };
static CGRect const kKECropRectNil = { 0.0f, 0.0f, 0.0f, 0.0f };

@implementation KEScreenShotUtil

+ (UIImage *)makeScreenShot
{
	UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
	UIGraphicsBeginImageContext(screenWindow.frame.size);
	[screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
	
	UIImage *rotatedImage = nil;
	if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight) {
		CGImageRef imageRef = [screenshot CGImage];
		rotatedImage = [UIImage imageWithCGImage:imageRef
		                                   scale:0.0f
		                             orientation:UIImageOrientationRight];
	}
	
	UIGraphicsEndImageContext();
	
	return rotatedImage ? rotatedImage : screenshot;
}

+ (UIImage *)cropImage
{
	CGRect croprect = kKECropRectNil;
	if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft) {
		croprect = kKECropRectLeft;
	}
	else {
		croprect = kKECropRectRight;
	}
	
	CGImageRef imageRef = CGImageCreateWithImageInRect([[self makeScreenShot] CGImage], croprect);
	UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
	CGImageRef foo = [croppedImage CGImage];
	
	UIImage *rotatedImage = nil;
	if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft) {
		rotatedImage = [UIImage imageWithCGImage:foo
		                                   scale:0.0f
		                             orientation:UIImageOrientationLeft];
	}
	else {
		rotatedImage = [UIImage imageWithCGImage:foo
		                                   scale:0.0f
		                             orientation:UIImageOrientationRight];
	}
	
	CGImageRelease(imageRef);
	
	return rotatedImage;
}

@end
