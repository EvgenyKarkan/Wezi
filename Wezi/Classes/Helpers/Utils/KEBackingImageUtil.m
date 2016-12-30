//
//  KEBackingImageUtil.m
//  Wezi
//
//  Created by Evgeny Karkan on 27.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEBackingImageUtil.h"


static NSString * const kKEBlue   = @"color_backg_blue.png";
static NSString * const kKEBlue2  = @"color_backg_blue2.png";
static NSString * const kKEGreen  = @"color_backg_green.png";
static NSString * const kKERed    = @"color_backg_red.png";
static NSString * const kKEViolet = @"color_backg_violet.png";
static NSString * const kKEYellow = @"color_backg_yellow.png";


@implementation KEBackingImageUtil;

+ (NSArray *)arrayWithRainbowImages
{
	NSString *blue   = kKEBlue;
	NSString *blue2  = kKEBlue2;
	NSString *green  = kKEGreen;
	NSString *red    = kKERed;
	NSString *violet = kKEViolet;
	NSString *yellow = kKEYellow;
	
	NSArray *colours = @[blue, blue2, green, red, violet, yellow];
	
	return colours;
}

+ (id)randomObjectFromArray
{
	return [self arrayWithRainbowImages][arc4random() % [[self arrayWithRainbowImages] count]];
}

@end
