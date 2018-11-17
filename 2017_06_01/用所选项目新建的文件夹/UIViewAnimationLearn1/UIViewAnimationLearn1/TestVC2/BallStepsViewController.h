//
//  BallStepsViewController.h
//  BallSteps
//
//  Created by tony on 11-5-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>

@interface BallStepsViewController : UIViewController
//{
//	UIButton *drawButton;
//	UIImageView *imageView;
//}

@property (nonatomic, retain) IBOutlet UIButton *drawButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (IBAction)drawStar:(id)sender;

@end

