//
//  BallStepsViewController.m
//  BallSteps
//
//  Created by tony on 11-5-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BallStepsViewController.h"

@implementation BallStepsViewController

@synthesize drawButton;
@synthesize imageView;

- (IBAction)drawStar:(id)sender {
	[drawButton setEnabled:NO];
	CGMutablePathRef starPath = CGPathCreateMutable();
	CGPathMoveToPoint(starPath,NULL,160.0f, 100.0f);
	CGPathAddLineToPoint(starPath, NULL, 100.0f, 280.0f);
	CGPathAddLineToPoint(starPath, NULL, 260.0, 170.0);
	CGPathAddLineToPoint(starPath, NULL, 60.0, 170.0);
	CGPathAddLineToPoint(starPath, NULL, 220.0, 280.0);
	CGPathCloseSubpath(starPath);
	
	CAKeyframeAnimation *animation = nil;
	animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[animation setDuration:10.0f];
	[animation setDelegate:self];
	[animation setPath:starPath];
	CFRelease(starPath);
	starPath = nil;
	[[imageView layer] addAnimation:animation forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	[drawButton setEnabled:YES];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [imageView setCenter:CGPointMake(160.0f, 100.0f)];
}



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
//	[drawButton release];
//	[imageView release];
//    [super dealloc];
}

@end
