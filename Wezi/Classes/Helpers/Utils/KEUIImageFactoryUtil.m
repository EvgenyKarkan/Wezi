//
//  KEUIImageFactoryUtil.m
//  Wezi
//
//  Created by Каркан Евгений on 31.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEUIImageFactoryUtil.h"

@implementation KEUIImageFactoryUtil


+ (UIImage *)imageDependsOnURL:(NSString *)URLString
{
    UIImage *icon = nil;
    if ([URLString rangeOfString:@"clear"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"weezle_night_rain.png"];
    }
    return icon;
}

@end
