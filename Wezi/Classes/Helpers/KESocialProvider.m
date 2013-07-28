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
#import "SVProgressHUD.h"
#import "KEScreenShotUtil.h"
#import "KEReachabilityUtil.h"

static NSUInteger const kKETwitterButtonTag     = 100;
static NSUInteger const kKEFacebookButtonTag    = 101;
static NSUInteger const kKEMailButtonTag        = 102;
static NSUInteger const kKEBugButtonTag         = 103;

@implementation KESocialProvider

+ (void)provideSocialMediaWithSender:(id)sender withObject:(id)object
{
	if ([[KEReachabilityUtil sharedUtil] checkInternetConnection]) {
		KEMailProvider *mail = [[KEMailProvider alloc] initWithDelegate:object];
		
		switch ([sender tag]) {
			case kKETwitterButtonTag:
				if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
					SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
					[controller setInitialText:@""];
					[controller addImage:[KEScreenShotUtil cropImage]];
					[object presentViewController:controller animated:YES completion:Nil];
				}
				else {
					[SVProgressHUD showErrorWithStatus:@"Please setup Twitter account"];
				}
				break;
				
			case kKEFacebookButtonTag:
				if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
					SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
					[controller setInitialText:@""];
					[controller addImage:[KEScreenShotUtil cropImage]];
					[object presentViewController:controller animated:YES completion:Nil];
				}
				else {
					[SVProgressHUD showErrorWithStatus:@"Please setup Facebook account"];
				}
				break;
				
			case kKEMailButtonTag: {
				NSArray *arr = @[@"wezi@gmail.com"];
				[mail showMailComposerWithSubject:@"E-mail"
				                    withRecepient:arr
				                  withMessageBody:@"Hello world"];
			}
				break;
				
			case kKEBugButtonTag: {
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
	else {
		[SVProgressHUD showErrorWithStatus:@"Internet connection is lost, try later."];
	}
}


@end
