//
//  TestVC18.m
//  Animation
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC18.h"

#define DEGREES_TO_RADIANS(x) (3.14159265358979323846 * x / 180.0)
//计算角度转换

@interface TestVC18 ()
{
    UIBezierPath *pacmanOpenPath;
    
    UIBezierPath *pacmanClosedPath;
    
    CAShapeLayer *shapeLayer;
    
    
}
@end

@implementation TestVC18

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self animationInit];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationInit
{
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat radius = 30.0f;
    CGFloat diameter = radius * 2;
    CGPoint arcCenter = CGPointMake(radius, radius);
    // Create a UIBezierPath for Pacman's open state
    pacmanOpenPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                    radius:radius
                                                startAngle:DEGREES_TO_RADIANS(35)
                                                  endAngle:DEGREES_TO_RADIANS(315)
                                                 clockwise:YES];
    
    [pacmanOpenPath addLineToPoint:arcCenter];
    [pacmanOpenPath closePath];
    
    // Create a UIBezierPath for Pacman's close state
    pacmanClosedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                      radius:radius
                                                  startAngle:DEGREES_TO_RADIANS(1)
                                                    endAngle:DEGREES_TO_RADIANS(359)
                                                   clockwise:YES];
    [pacmanClosedPath addLineToPoint:arcCenter];
    [pacmanClosedPath closePath];
    
    // Create a CAShapeLayer for Pacman, fill with yellow
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    shapeLayer.path = pacmanClosedPath.CGPath;
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    shapeLayer.position = CGPointMake(-40, -100);
    [self.view.layer addSublayer:shapeLayer];
    
    SEL startSelector = @selector(startAnimation);
    UIGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:startSelector];
    [self.view addGestureRecognizer:recognizer];
}


- (void)startAnimation {
    // 创建咬牙动画
    CABasicAnimation *chompAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    chompAnimation.duration = 0.25;
    chompAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    chompAnimation.repeatCount = HUGE_VALF;
    chompAnimation.autoreverses = YES;
    // Animate between the two path values
    chompAnimation.fromValue = (id)pacmanClosedPath.CGPath;
    chompAnimation.toValue = (id)pacmanOpenPath.CGPath;
    [shapeLayer addAnimation:chompAnimation forKey:@"chompAnimation"];
    
    // Create digital '2'-shaped path
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 100)];
    [path addLineToPoint:CGPointMake(300, 100)];
    [path addLineToPoint:CGPointMake(300, 200)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path addLineToPoint:CGPointMake(0, 300)];
    [path addLineToPoint:CGPointMake(300, 300)];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 8.0f;
    // Setting the rotation mode ensures Pacman's mouth is always forward.  This is a very convenient CA feature.
    moveAnimation.rotationMode = kCAAnimationRotateAuto;
    [shapeLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
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
