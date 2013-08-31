//
//  KEShareViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KESocialProvideProtocol <NSObject>

- (void)provideSocialMediaWithSender:(id)sender;

@end


@interface KEShareViewController : UIViewController

@property (nonatomic, unsafe_unretained)	id <KESocialProvideProtocol> secondDelegate;

@end
