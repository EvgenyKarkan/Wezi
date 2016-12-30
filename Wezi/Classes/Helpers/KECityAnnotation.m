//
//  KECityAnnotation.m
//  Wezi
//
//  Created by Evgeny Karkan on 5/15/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KECityAnnotation.h"

@implementation KECityAnnotation

- (instancetype)initWithTitle:(NSString *)newTitle subtitle:(NSString *)newSubtitle
{
	if (self = [super init]) {
		_title = newTitle;
		_subtitle = newSubtitle;
	}
	
	return self;
}

@end
