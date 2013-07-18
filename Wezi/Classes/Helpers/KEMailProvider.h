//
//  KEMailProvider.h
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEMailProvider : NSObject 

- (id)initWithDelegate:(id)delegate;
- (void)showMailComposerWithSubject:(NSString *)subject
					  withRecepient:(NSArray *)recepient
					withMessageBody:(NSString *)message;

@end
