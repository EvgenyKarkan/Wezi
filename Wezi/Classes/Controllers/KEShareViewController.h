//
//  KEShareViewController.h
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KEPopoverHideProtocol <NSObject>

- (void)hideSharePopover;

@end


@protocol KESocialProvideProtocol <NSObject>

- (void)provideSocialMediaWithSender:(id)sender;

@end


@interface KEShareViewController : UIViewController

@property (nonatomic, assign)    id <KEPopoverHideProtocol> firstDelegate;
@property (nonatomic, assign)	 id <KESocialProvideProtocol> secondDelegate;

@end
