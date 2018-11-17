//
//  UIViewAnimationViewController.m
//  UIViewAnimation
//
//  Created by tony on 11-5-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewAnimationViewController.h"

@implementation UIViewAnimationViewController


- (IBAction)doUIViewAnimation:(id)sender{
	[UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:1.5f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationRepeatAutoreverses:NO];
	UIButton *theButton = (UIButton *)sender;
	switch (theButton.tag) {
		case 1:
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];//oglFlip, fromLeft 
			break;
		case 2:
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];//oglFlip, fromRight 	 
			break;
		case 3:
			[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
			break;
		case 4:
			[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
			break;
		default:
			break;
	}
	//[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
	[UIView commitAnimations];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
//    [super dealloc];
}

@end
