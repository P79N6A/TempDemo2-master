//
//  YLWheelHelper.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/1.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "YLWheelHelper.h"

@implementation YLWheelHelper

/**
 计算两个点 之间的距离
 
 @param startPoint 起始点
 @param endPoint 终止点
 @return 亮点距离
 */
+ (CGFloat)getDistanceWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    //     一个非负实数的平方根函数,  比如 sqrt(9) == 3.0
    return sqrt((startPoint.x - endPoint.x) * (startPoint.x - endPoint.x) + (startPoint.y - endPoint.y) * (startPoint.y - endPoint.y));
}


/**
 根据起始点，终止点和固定的中心点，计算出当前转动是 顺时针/逆时针
 
 @param startPoint 起始点
 @param endPoint 终止点
 @param centerPoint 中心点
 @return 转动方向，顺时针/逆时针
 */
+ (RotateDirection)getRotateDirection:(CGPoint)startPoint endPoint:(CGPoint)endPoint centerPoint:(CGPoint)centerPoint
{
    CGFloat k1;
    CGFloat k2;
    
    if( (startPoint.x - centerPoint.x == 0) || (endPoint.x - centerPoint.x == 0) ) {
        // 顺时针
        return RotateDirectionClockwise;
    }
    
    k1 = (startPoint.y - centerPoint.y) / (startPoint.x - centerPoint.x);
    
    k2 = (endPoint.y - centerPoint.y) / (endPoint.x - centerPoint.x);
    
    CGFloat tan0 = (k2 - k1) * (1.0 + k1 * k2);
    
    if(tan0 > 0.0) {
        // 顺时针
        return RotateDirectionClockwise;
    } else {
        // 逆时针
        return RotateDirectionAnticlockwise;
    }
}



/**
 计算旋转角度

 @param startPoint 起始点
 @param endPoint 终止点
 @param centerPoint 固定中心点
 @return 旋转的
 */
+ (CGFloat)calculateAngle:(CGPoint)startPoint endPoint:(CGPoint)endPoint centerPoint:(CGPoint)centerPoint
{
    CGFloat k1;
    CGFloat k2;
    
    if( (startPoint.x - centerPoint.x == 0) || (endPoint.x - centerPoint.x == 0)) {
        return 0.0;
    }
    
    k1 = (startPoint.y - centerPoint.y) / (startPoint.x - centerPoint.x);
    k2 = (endPoint.y - centerPoint.y) / (endPoint.x - centerPoint.x);
    
    CGFloat tan0 = (k2 - k1) / (1.0 + k1 * k2);
    
    if(tan0 < 0)
    {
        tan0 = -tan0;
    }
    
//    NSLog(@"tan0==%f", tan0);
//    NSLog(@"%f", atan(tan0));
    
    
    return atan(tan0) ;
}


/**
 计算出旋转时的速度
 
 @param startPoint 起始点
 @param endPoint 终止点
 @param timeInterval 时间间隔
 @return 速度
 */
+ (CGFloat)calculateSpeed:(CGPoint)startPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval
{
    double seconds = timeInterval;
    
    if(seconds < 0)
    {
        seconds=-seconds;
    }
    
    CGFloat distance = [[self class] getDistanceWithStartPoint:startPoint endPoint:endPoint];
    
    CGFloat speed = distance / seconds;
    
        
    if(speed > 40.0)
    {
        speed = MAX_SPEED;
    }
    else
    {
        speed = MIN_SPEED;
    }
    return speed;
}


@end
