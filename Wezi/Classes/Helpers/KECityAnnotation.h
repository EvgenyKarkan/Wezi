//
//  KECityAnnotation.h
//  Wezi
//
//  Created by Evgeniy Karkan on 5/15/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KECityAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign)       CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)         NSString *title;
@property (nonatomic, copy)         NSString *subtitle;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

@end
