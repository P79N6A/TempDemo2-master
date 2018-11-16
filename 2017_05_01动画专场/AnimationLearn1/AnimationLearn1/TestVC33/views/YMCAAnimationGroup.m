//
//  YMCAAnimationGroup.m
//  CoreAnimationDemo
//
//  Created by yumiao on 14-6-19.
//  Copyright (c) 2014年 clover. All rights reserved.
//

#import "YMCAAnimationGroup.h"

@implementation YMCAAnimationGroup
//打开菜单
+ (CAAnimationGroup *)fromPoint:(CGPoint)from toPoint:(CGPoint)to duration:(CFTimeInterval)duration button:(UIButton *)button
{
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:from];
    //[movePath addLineToPoint:to];
    [movePath addQuadCurveToPoint:to
                     controlPoint:CGPointMake( to.x - 10, to.y - 10)];
    [movePath addQuadCurveToPoint:to
                     controlPoint:CGPointMake( to.x + 10, to.y + 10)];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //沿Z轴旋转
    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    TransformAnim.cumulative = YES;
    TransformAnim.duration = duration / 4;
    //旋转1遍，360度
    TransformAnim.repeatCount = 4;
    TransformAnim.removedOnCompletion = YES;

    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects: TransformAnim, moveAnim,nil];
    animGroup.duration = duration;
    button.center = to;
    return animGroup;
}



//收回菜单
+ (CAAnimationGroup *)fromEndPoint:(CGPoint)from toStartPoint:(CGPoint)to duration:(CFTimeInterval)duration button:(UIButton *)button
{

    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:from];
    [movePath addLineToPoint:to];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //沿Z轴旋转
    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    TransformAnim.cumulative = YES;
    TransformAnim.duration = duration / 3;
    //旋转1遍，360度
    TransformAnim.repeatCount = 3;
    TransformAnim.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, TransformAnim,nil];
    animGroup.duration = duration;
    button.center = to;
    return animGroup;
}




@end
