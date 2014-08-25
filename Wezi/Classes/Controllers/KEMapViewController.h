//
//  KEMapViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 5/8/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@protocol KECoordinateFillProtocol <NSObject>

- (void)addPressedWithCoordinate:(CLLocation *)location;

@end


@interface KEMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView       *map;
@property (nonatomic, weak) IBOutlet UINavigationBar *mapNavBar;
@property (nonatomic, weak) id <KECoordinateFillProtocol> objectToDelegate;

@end
