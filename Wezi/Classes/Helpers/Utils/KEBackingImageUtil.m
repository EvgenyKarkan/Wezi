//
//  KEBackingImageUtil.m
//  Wezi
//
//  Created by Каркан Евгений on 27.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEBackingImageUtil.h"

@implementation KEBackingImageUtil

+ (NSArray *)arrayWithRainbowImages
{
    NSString *red = @"red.jpeg";
    NSString *blue = @"blue.jpeg";
    NSString *lblue = @"lblue.jpeg";
    NSString *violet = @"violet.jpeg";
    NSString *green = @"green.jpeg";
    NSString *yellow = @"yellow.jpeg";
    
    NSArray *colours = @[red,blue,lblue,violet,green,yellow];
    
    return colours;
}

+ (id)randomObjectFromArray
{
    return [[self arrayWithRainbowImages] objectAtIndex: arc4random() % [[self arrayWithRainbowImages] count]];
}

@end
