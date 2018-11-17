//
//  MainViewController.m
//  PasswordGen
//
//  Created by amuck on 8/18/08.
//  Copyright AppsAmuck LLC 2008. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

@implementation MainViewController

@synthesize createPassword;
@synthesize emailPassword;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIImage *buttonBackground = [[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:12.0 ];
	[createPassword setBackgroundImage:buttonBackground forState:UIControlStateNormal];
	[emailPassword setBackgroundImage:buttonBackground forState:UIControlStateNormal];
	
	[createPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[emailPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	UIImage *buttonBackgroundSel = [[UIImage imageNamed:@"whiteButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:12.0 ];
	[createPassword setBackgroundImage:buttonBackgroundSel forState:UIControlStateHighlighted];
	[createPassword setBackgroundImage:buttonBackgroundSel forState:UIControlStateSelected];
	[emailPassword setBackgroundImage:buttonBackgroundSel forState:UIControlStateHighlighted];
	[emailPassword setBackgroundImage:buttonBackgroundSel forState:UIControlStateSelected];
	
	[createPassword setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
	[createPassword setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
	[emailPassword setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
	[emailPassword setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


@end
