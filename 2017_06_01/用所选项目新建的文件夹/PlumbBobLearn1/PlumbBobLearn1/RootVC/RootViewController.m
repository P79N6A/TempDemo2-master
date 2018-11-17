//
//  RootViewController.m
//  PlumbBobLearn1
//
//  Created by xiaoyulong on 2017/5/22.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>

// Constant for the number of times per second (Hertz) to sample acceleration.
#define kAccelerometerFrequency 40

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set the background color to black
    self.view.backgroundColor = [UIColor blackColor];
    
    // set up the plumb view
    UIImage* image = [UIImage imageNamed:@"PlumbBob.png"];
    plumbBobView = [[UIImageView alloc] initWithImage:image];
    
    // move the anchor point to the bottom middle of the metronomeArm bounds,
    // so rotations occur around that point
    plumbBobView.layer.anchorPoint = CGPointMake(0.5, 0.0);
    
    // set the frame AFTER setting the ancor point so the view will be in the
    // correct start position.
    plumbBobView.frame = CGRectMake(self.view.frame.size.width/2 - 20, 0, 40, 450);
    
    [self.view addSubview:plumbBobView];
//    [plumbBobView release];
    
    
    
//    UIAccelerometer has been replaced by the CoreMotion framework
    // 感受重力方向的加速计
    
    // Configure and start the accelerometer
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark === Accelerometer delegate ===
#pragma mark -
// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    [self rotatePlumbStringToDegree:-acceleration.x* 30];
}

#pragma mark -
#pragma mark === Swing the plumb and string ===
#pragma mark -

- (void)rotatePlumbStringToDegree:(CGFloat)positionInDegrees
{
    [plumbBobView.layer removeAllAnimations];
    
    CATransform3D rotationTransform = CATransform3DIdentity;
    rotationTransform = CATransform3DRotate(rotationTransform, DegreesToRadians(positionInDegrees), 0.0, 0.0, 1.0);
    plumbBobView.layer.transform = rotationTransform;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


