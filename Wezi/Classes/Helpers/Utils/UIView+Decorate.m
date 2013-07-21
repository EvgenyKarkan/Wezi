//
//  UIView+Decorate.m
//  Wezi
//
//  Created by Evgeniy Karkan on 29.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "UIView+Decorate.h"

static NSUInteger const kKEHorizontalShadowOffset = 4;
static NSUInteger const kKEVerticalShadowOffsett = 13;

@implementation UIView (Decorate)

- (void)addRoundShadowWithOpacity:(double)opacity
{
	CALayer *layer = self.layer;
	layer.shadowRadius = 1;
	layer.shadowOpacity = opacity;
	
	CGRect newRect = layer.frame;
	NSInteger horizontalShadowOffset = kKEHorizontalShadowOffset;
	NSInteger verticalShadowOffset = kKEVerticalShadowOffsett;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, nil, horizontalShadowOffset, verticalShadowOffset);
	
	CGFloat radius = (pow(newRect.size.width / 2 - horizontalShadowOffset, 2) + pow(verticalShadowOffset, 2)) / (2 * verticalShadowOffset);
	CGFloat angle = acos((newRect.size.width / 2 - horizontalShadowOffset) / radius);
	
	CGPathAddArc(path, nil, newRect.size.width / 2, radius + verticalShadowOffset, radius, M_PI + angle, -angle, NO);
	CGPathAddLineToPoint(path, nil, newRect.size.width - horizontalShadowOffset, newRect.size.height + verticalShadowOffset);
	
	CGPathAddArc(path, nil, newRect.size.width / 2, newRect.size.height + radius, radius, -angle, M_PI + angle, YES);
	CGPathAddLineToPoint(path, nil, horizontalShadowOffset, verticalShadowOffset);
	
	[layer setShadowPath:path];
	
	CGPathRelease(path);
}

@end
