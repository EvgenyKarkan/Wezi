//
//  KEFonts.m
//  Wezi
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.

#import "KEFonts.h"


static NSString * const kKEPlutoSansMediumItalic = @"PlutoSansMedium-Italic";
static NSString * const kKEPlutoSansLight		 = @"PlutoSansLight";
static NSString * const kKEPlutoSansHeavy		 = @"PlutoSansHeavy";
static NSString * const kKEPlutoSansExtraLight	 = @"PlutoSansExtraLight";
static NSString * const kKEPlutoSansRegular		 = @"PlutoSansRegular";
static NSString * const kKEPlutoSansCondBold	 = @"PlutoSansCondBold";


@implementation KEFonts;

+ (UIFont *)plutoSansMediumWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kKEPlutoSansMediumItalic size:fontSize];
}

+ (UIFont *)plutoSansLightWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kKEPlutoSansLight size:fontSize];
}

+ (UIFont *)plutoSansHeavyWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kKEPlutoSansHeavy size:fontSize];
}

+ (UIFont *)plutoSansExtraLonghtWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kKEPlutoSansExtraLight size:fontSize];
}

+ (UIFont *)plutoSansRegularWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kKEPlutoSansRegular size:fontSize];
}

+ (UIFont *)plutoSansCondBoldWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kKEPlutoSansCondBold size:fontSize];
}

@end
