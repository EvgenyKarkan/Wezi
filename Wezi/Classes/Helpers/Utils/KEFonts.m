//
//  SUFonts.m
//  VeloLink
//
//  Created by Evgeniy Karkan on 4/29/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.

#import "KEFonts.h"

@implementation KEFonts

+ (UIFont *)plutoSansMediumWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PlutoSansMedium-Italic" size:fontSize];
}

+ (UIFont *)plutoSansLightWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PlutoSansLight" size:fontSize];
}

+ (UIFont *)plutoSansHeavyWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PlutoSansHeavy" size:fontSize];
}

+ (UIFont *)plutoSansExtraLonghtWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PlutoSansExtraLight" size:fontSize];
}

+ (UIFont *)plutoSansRegularWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PlutoSansRegular" size:fontSize];
}

+ (UIFont *)plutoSansCondBoldWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PlutoSansCondBold" size:fontSize];
}
@end
