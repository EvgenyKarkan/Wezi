//
//  KEMailProvider.m
//  Wezi
//
//  Created by Evgeny Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEMailProvider.h"

static NSString * const kKEMailComposer = @"MFMailComposeViewController";
static NSString * const kKEMailTo       = @"mailto:wezi@gmail.com";


@interface KEMailProvider ()

@property (nonatomic, unsafe_unretained) id delegateObject;

@end


@implementation KEMailProvider;

- (instancetype)initWithDelegate:(id)delegate
{
    self = [super init];
    
    if (self) {
        _mailForm = [[MFMailComposeViewController alloc] init];
        _mailForm.mailComposeDelegate = delegate;
        _delegateObject = delegate;
    }
    
    return self;
}

- (void)showMailComposerWithSubject:(NSString *)subject withRecepient:(NSArray *)recepient withMessageBody:(NSString *)message
{
    Class mailClass = (NSClassFromString(kKEMailComposer));
	
    if (mailClass != nil) {
        if ([mailClass canSendMail]) {
            if (self.mailForm) {
                [self.delegateObject presentViewController:self.mailForm animated:YES completion: nil];
                [self.mailForm setModalPresentationStyle:UIModalPresentationFormSheet];
                [self.mailForm setSubject:subject];
                [self.mailForm setToRecipients:recepient];
                [self.mailForm setMessageBody:message isHTML:NO];
            }
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kKEMailTo]];
        }
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kKEMailTo]];
    }
}

@end
