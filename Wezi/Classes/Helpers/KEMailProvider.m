//
//  KEMailProvider.m
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEMailProvider.h"

@interface KEMailProvider ()

@property (nonatomic, strong) MFMailComposeViewController *mailForm;
@property (nonatomic, assign) id delegateObject;

@end


@implementation KEMailProvider

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    
    if (self) {
        self.mailForm = [[MFMailComposeViewController alloc] init];
        self.mailForm.mailComposeDelegate = delegate;
        self.delegateObject = delegate;
    }
    
    return self;
}

- (void)showMailComposerWithSubject:(NSString *)subject withRecepient:(NSArray *)recepient withMessageBody:(NSString *)message
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
    if (mailClass != nil) {
        if ([mailClass canSendMail]) {
            if (self.mailForm) {
                [self.delegateObject presentModalViewController:self.mailForm animated:YES];
                [self.mailForm setModalPresentationStyle:UIModalPresentationFormSheet];
                [self.mailForm setSubject:subject];
                [self.mailForm setToRecipients:recepient];
                [self.mailForm setMessageBody:message isHTML:NO];
            }
        }
        else {
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:krish@krish.codeworth.com"]];
        }
    }
    else {
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:krish@krish.codeworth.com"]];
    }
}

@end
