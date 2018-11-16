//
//  TurntableView5.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/6.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TurntableView5.h"

@implementation TurntableView5

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 在旋转的过程中self的坐标系会转动，到superview里面去找坐标点
    CGPoint prePoint = [touch previousLocationInView:self.superview];
    CGPoint curPoint = [touch locationInView:self.superview];
    
    NSLog(@"prePoint==%@", NSStringFromCGPoint(prePoint));
    NSLog(@"curPoint==%@", NSStringFromCGPoint(curPoint));
    
    float angle = [self getAngleWithOrginPoint:self.center PointX:prePoint PointY:curPoint];
    CATransform3D transform = self.layer.transform;
    NSLog(@"angle==%@", @(angle));

    
    if (prePoint.y < self.center.y)
    {
        transform = CATransform3DRotate(transform, angle, 0, 0, 1);
    }
    else
    {
        transform = CATransform3DRotate(transform, angle, 0, 0, -1);
    }
    
    self.layer.transform = transform;
}

//用反余弦函数求角
- (float)getAngleWithOrginPoint:(CGPoint)aOrginPoint PointX:(CGPoint)aPointX PointY:(CGPoint)aPointY
{
    //得到pointX到原点的距离
    float xToOrgin = [self getDistanceFromPointX:aPointX toPointY:aOrginPoint];
    //得到pointX到原点的水平距离
    float xDistanceOnX = aPointX.x - aOrginPoint.x;
    //用反余弦函数得到pointX与水平线的夹角
    float xAngle = acos(xDistanceOnX/xToOrgin);
    
    
    //用同样的方法得到pointY与水平线的夹角
    float yToOrgin = [self getDistanceFromPointX:aPointY toPointY:aOrginPoint];
    float yDistanceOnX = aPointY.x - aOrginPoint.x;
    float yAngle = acos(yDistanceOnX / yToOrgin);
    float angle= xAngle - yAngle;
    
    return angle;
}

// 求两个点之间的距离
- (float)getDistanceFromPointX:(CGPoint)PointX toPointY:(CGPoint)PointY
{
    float xDis = PointX.x - PointY.x;
    float yDis = PointX.y - PointY.y;
    float distance = sqrtf(xDis * xDis + yDis * yDis);
    return distance;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
