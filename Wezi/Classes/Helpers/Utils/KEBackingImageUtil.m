//
//  KEBackingImageUtil.m
//  Wezi
//
//  Created by Evgeniy Karkan on 27.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEBackingImageUtil.h"

@implementation KEBackingImageUtil

+ (NSArray *)arrayWithRainbowImages
{
    NSString *blue = @"color_backg_blue.png";
    NSString *blue2 = @"color_backg_blue2.png";
    NSString *green = @"color_backg_green.png";
    NSString *red = @"color_backg_red.png";
    NSString *violet = @"color_backg_violet.png";
    NSString *yellow = @"color_backg_yellow.png";
    
    NSArray *colours = @[blue,blue2,green,red,violet,yellow];
    
    return colours;
}

+ (id)randomObjectFromArray
{
    return [[self arrayWithRainbowImages] objectAtIndex: arc4random() % [[self arrayWithRainbowImages] count]];
}

@end
