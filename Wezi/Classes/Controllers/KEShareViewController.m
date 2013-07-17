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
