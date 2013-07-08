//
//  NSString+CommaSubString.h
//  Wezi
//
//  Created by Evgeniy Karkan on 31.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CommaSubString)

+ (NSString *)subStringBeforeFirstCommaInString:(NSString *)longString;

@end
