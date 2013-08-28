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

@property (nonatomic, strong) UIButton *twitter;
@property (nonatomic, strong) UIButton *facebook;
@property (nonatomic, strong) UIButton *email;
@property (nonatomic, strong) UIButton *bug;
@property (nonatomic, strong) NSArray *buttons;

@end


@implementation KEShareViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self createSubViews];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - Add buttons

- (void)createSubViews
{
#warning MAgic
	
	self.twitter = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.twitter setImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
	[self.twitter setImage:[UIImage imageNamed:@"twitter_pressed"] forState:UIControlStateHighlighted];
	
	self.facebook = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.facebook setImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
	[self.facebook setImage:[UIImage imageNamed:@"facebook_pressed"] forState:UIControlStateHighlighted];
	
	self.email = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.email setImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
	[self.email setImage:[UIImage imageNamed:@"email_pressed"] forState:UIControlStateHighlighted];
	
	self.bug = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.bug setImage:[UIImage imageNamed:@"Bug-report"] forState:UIControlStateNormal];
	[self.bug setImage:[UIImage imageNamed:@"Bug_report_pressed"] forState:UIControlStateHighlighted];
	
	self.buttons = @[self.twitter, self.facebook, self.email, self.bug];
	
	for (NSUInteger i = 0; i < [self.buttons count]; i++) {
		[self.buttons[i] setFrame:CGRectMake(20.0f, 20.0f + (i * 70.0f), 160.0f, 50.0f)];
		[self.buttons[i] setTag:100 + (i * 1)];
		[self.buttons[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.buttons[i]];
	}
}

#pragma mark - Actions

- (void)buttonPressed:(id)sender
{
	[self.firstDelegate hideSharePopover];
	[self.secondDelegate provideSocialMediaWithSender:sender];
}

@end
