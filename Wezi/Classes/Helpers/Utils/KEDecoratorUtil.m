//
//  KEDecoratorUtil.m
//  Wezi
//
//  Created by Каркан Евгений on 29.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEDecoratorUtil.h"

@implementation KEDecoratorUtil

+ (void)decorateWithShadow:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    view.layer.shadowOpacity = 0.6f;
}

@end
