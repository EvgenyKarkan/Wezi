//
//  KEShareViewController.m
//  Wezi
//
//  Created by Каркан Евгений on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEShareViewController.h"
#import "KEMailProvider.h"

@interface KEShareViewController ()

@property (nonatomic, strong)       UIStoryboardPopoverSegue *currentPopoverSegue;

@end

@implementation KEShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)emailPressed:(id)sender
{
	[self.objectToDelegate hideSharePopover];
	NSArray *arr = @[@"wezi@gmail.com"];
	KEMailProvider *mail = [[KEMailProvider alloc] initWithDelegate:self];
	
	[mail showMailComposerWithSubject:@"E-mail"
	                    withRecepient:arr
	                  withMessageBody:@"Hello world"];
}

- (IBAction)twitterPessed:(id)sender
{
	[self.objectToDelegate hideSharePopover];
	if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
		SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [controller setInitialText:@"First post from my iPhone app"];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)facebookPressed:(id)sender
{
	[self.objectToDelegate hideSharePopover];
	if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
		SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"First post from my iPhone app"];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)bugReportPressed:(id)sender
{
	NSArray *arr = @[@"wezi@gmail.com"];
	KEMailProvider *mail = [[KEMailProvider alloc] initWithDelegate:self];
	
	[mail showMailComposerWithSubject:@"E-mail"
	                    withRecepient:arr
	                  withMessageBody:@"Hello world"];
}

#pragma mark - Mail composer delegate method

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	switch (result) {
		case MFMailComposeResultCancelled:
			
			break;
			
		case MFMailComposeResultSaved:
			
			break;
			
		case MFMailComposeResultSent:
			
			break;
			
		case MFMailComposeResultFailed:
			
			break;
			
		default:
			
			break;
	}
	
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
