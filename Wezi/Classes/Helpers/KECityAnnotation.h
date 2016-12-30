//
//  KECityAnnotation.h
//  Wezi
//
//  Created by Evgeny Karkan on 5/15/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface KECityAnnotation : NSObject <MKAnnotation>

#warning replace this class to model folder

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

@end
