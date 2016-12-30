//
//  KEShareViewController.h
//  Wezi
//
//  Created by Evgeny Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@protocol KEPopoverHideProtocol <NSObject>

- (void)hideSharePopover;

@end


@protocol KESocialProvideProtocol <NSObject>

- (void)provideSocialMediaWithSender:(id)sender;

@end


@interface KEShareViewController : UIViewController

@property (nonatomic, weak) id <KEPopoverHideProtocol>   firstDelegate;
@property (nonatomic, weak) id <KESocialProvideProtocol> secondDelegate;

@end
