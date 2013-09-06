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
					[controller setInitialText:@"Look at my weather tweet sent from @WeziApp"];
					[controller addImage:[KEScreenShotUtil cropImage]];
					[object presentViewController:controller animated:YES completion:Nil];
				}
				else {
					[SVProgressHUD showErrorWithStatus:@"Please setup Twitter account on settings"];
				}
				break;
				
			case kKEFacebookButtonTag:
				if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
					SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
					[controller setInitialText:@"Look at my weather post sent from @WeziApp"];
					[controller addImage:[KEScreenShotUtil cropImage]];
					[object presentViewController:controller animated:YES completion:Nil];
				}
				else {
					[SVProgressHUD showErrorWithStatus:@"Please setup Facebook account on settings"];
				}
				break;
				
			case kKEMailButtonTag : {
				[mail showMailComposerWithSubject:@"Wezi"
									withRecepient:nil
								  withMessageBody:@"Hi! Look at the weather in my picture."];
				
				UIImage *coolImage = [KEScreenShotUtil cropImage];
				NSData *myData = UIImageJPEGRepresentation(coolImage, 3.0f);
				[mail.mailForm addAttachmentData:myData mimeType:@"image/png" fileName:@"WeziApp.png"];
			}
				break;
				
			case kKEBugButtonTag: {
				NSArray *arr = @[@"WeziApp@gmail.com"];
				[mail showMailComposerWithSubject:@"Bug report to Wezi"
				                    withRecepient:arr
				                  withMessageBody:@"Hi Wezi Team!"];
			}
				break;
				
			default:
				break;
		}
	}
	else {
		[SVProgressHUD showErrorWithStatus:@"Internet connection is lost, try later"];
	}
}


@end
