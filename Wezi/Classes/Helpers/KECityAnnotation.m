//
//  KECityAnnotation.m
//  Wezi
//
//  Created by Evgeniy Karkan on 5/15/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KECityAnnotation.h"

@implementation KECityAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithTitle:(NSString *)newTitle subtitle:(NSString *)newSubtitle
{
	if (self = [super init]) {
		title = newTitle;
		subtitle = newSubtitle;
	}
	return self;
}

@end
