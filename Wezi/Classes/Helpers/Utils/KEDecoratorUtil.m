//
//  KEDecoratorUtil.m
//  Wezi
//
//  Created by Evgeniy Karkan on 29.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEDecoratorUtil.h"


@implementation KEDecoratorUtil;

+ (void)decorateWithShadow:(UIView *)view withOffsetValue:(float)offset
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0.0f, offset);
    view.layer.shadowOpacity = 0.6f;
}

@end
