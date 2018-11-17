//
//  FlipsideViewController.m
//  Waterfall
//
//  Created by acs on 9/7/08.
//  Copyright ACS Technologies 2008. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController


- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];		
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}



@end
