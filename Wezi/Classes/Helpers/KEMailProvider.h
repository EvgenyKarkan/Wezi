//
//  KEMailProvider.h
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface KEMailProvider : NSObject 

@property (nonatomic, strong) MFMailComposeViewController *mailForm;

- (instancetype)initWithDelegate:(id)delegate NS_DESIGNATED_INITIALIZER;

- (void)showMailComposerWithSubject:(NSString *)subject
					  withRecepient:(NSArray *)recepient
					withMessageBody:(NSString *)message;

@end
