//
//  KEMailProvider.h
//  Wezi
//
//  Created by Каркан Евгений on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KEMailProvider : NSObject 

@property (nonatomic, strong) MFMailComposeViewController *mailForm;
@property (nonatomic, assign) id delegateObject;

- (id)initWithDelegate:(id)delegate;
- (void)showMailComposerWithSubject:(NSString *)subject withRecepient:(NSArray *)recepient withMessageBody:(NSString *)message;

@end
