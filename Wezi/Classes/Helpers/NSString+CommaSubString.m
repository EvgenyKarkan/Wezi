//
//  NSString+CommaSubString.m
//  Wezi
//
//  Created by Evgeny Karkan on 31.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSString+CommaSubString.h"

@implementation NSString (CommaSubString);

+ (NSString *)wzz_subStringBeforeFirstCommaInString:(NSString *)longString
{
    NSRange range = [longString rangeOfString:@","];
    NSString *newShortString = [longString substringToIndex:range.location];
	
    return newShortString;
}

@end
