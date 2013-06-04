//
//  KEMapViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 5/8/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KECoordinateFillProtocol 

@required

- (void)addPressedWithCoordinate:(CLLocation *)location;

@end

@interface KEMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic)                 IBOutlet MKMapView *map;
@property (nonatomic, unsafe_unretained)    id <KECoordinateFillProtocol> objectToDelegate;

@end
