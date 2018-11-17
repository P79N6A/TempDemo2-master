//
//  eanimateViewController.m
//  eanimate
//
//  Created by Shannon Appelcline on 10/17/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "eanimateViewController.h"

@implementation eanimateViewController

-(IBAction)movePlane:(id)sender {
	
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.0];
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
    plane.layer.affineTransform=moveTransform;
    plane.layer.opacity = 1;
    [UIView commitAnimations];

    
    
    
//    CAKeyframeAnimation *opAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//    opAnim.duration = 6.0;
//    opAnim.values =[NSArray arrayWithObjects:
//                    [NSNumber numberWithFloat:0.25],
//                    [NSNumber numberWithFloat:0.75],
//                    [NSNumber numberWithFloat:1.0],
//                    nil];
//    opAnim.keyTimes = [NSArray arrayWithObjects:
//                       [NSNumber numberWithFloat:0.0],
//                       [NSNumber numberWithFloat:0.5],
//                       [NSNumber numberWithFloat:1.0], nil];
//    
//    [plane.layer addAnimation:opAnim forKey:@"animateOpacity"];
//    
//    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
//    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    moveAnim.duration = 6.0;
//    moveAnim.toValue= [NSValue valueWithCATransform3D:
//                       CATransform3DMakeAffineTransform(moveTransform)];
//    [plane.layer addAnimation:moveAnim forKey:@"animateTransform"];
    
    
    
    
    
//	CABasicAnimation *opAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//	opAnim.duration = 3.0;
//	opAnim.fromValue = [NSNumber numberWithFloat:.25];
//	opAnim.toValue= [NSNumber numberWithFloat:1.0];
//	opAnim.cumulative = YES;
//	opAnim.repeatCount = 2;
//	[plane.layer addAnimation:opAnim forKey:@"animateOpacity"];
//	
//	CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
//	CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//	moveAnim.duration = 6.0;
//	moveAnim.toValue= [NSValue valueWithCATransform3D:
//		CATransform3DMakeAffineTransform(moveTransform)];
//	[plane.layer addAnimation:moveAnim forKey:@"animateTransform"];

}

/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
//    [super dealloc];
}

@end
