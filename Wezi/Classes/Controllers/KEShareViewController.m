//
//  KEShareViewController.m
//  Wezi
//
//  Created by Evgeniy Karkan on 30.06.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEShareViewController.h"

@interface KEShareViewController ()

@property (nonatomic, strong) UIStoryboardPopoverSegue *currentPopoverSegue;

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

- (IBAction)buttonPressed:(id)sender
{
	[self.firstDelegate hideSharePopover];
	[self.secondDelegate provideSocialMediaWithSender:sender];
}



@end
