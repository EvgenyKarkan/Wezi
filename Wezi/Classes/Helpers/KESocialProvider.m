//
//  KESocialProvider.m
//  Wezi
//
//  Created by Evgeniy Karkan on 18.07.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KESocialProvider.h"
#import "KEShareViewController.h"
#import "KEMailProvider.h"

@implementation KESocialProvider

+ (void)provideSocialMediaWithSender:(id)sender withObject:(id)object
{
	KEMailProvider *mail = [[KEMailProvider alloc] initWithDelegate:object];
	
	switch ([sender tag]) {
		case 100:
			if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
				SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
				[controller setInitialText:@""];
				[object presentViewController:controller animated:YES completion:Nil];
			}
			break;
			
		case 101:
			if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
				SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
				[controller setInitialText:@""];
				[object presentViewController:controller animated:YES completion:Nil];
			}
			break;
			
		case 102: {
			NSArray *arr = @[@"wezi@gmail.com"];
			[mail showMailComposerWithSubject:@"E-mail"
			                    withRecepient:arr
			                  withMessageBody:@"Hello world"];
		}
			break;
			
		case 103: {
			NSArray *arr = @[@"wezi@gmail.com"];
			[mail showMailComposerWithSubject:@"E-mail"
			                    withRecepient:arr
			                  withMessageBody:@"Bug bug bug..."];
		}
			break;
			
		default:
			break;
	}
}


@end
