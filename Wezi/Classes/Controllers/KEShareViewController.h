//
//  KEShareViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KESocialProtocol

@required

- (void)hideSharePopover;

@end

@interface KEShareViewController : UIViewController

@property (nonatomic, assign)    id <KESocialProtocol> objectToDelegate;

@end
