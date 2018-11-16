//
//  YLWheelHelper.h
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/1.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RotateDirection) {
    RotateDirectionClockwise        = -1,  // 顺时针方向
    RotateDirectionAnticlockwise           // 逆时针方向
};


/*最大转动速度*/
static CGFloat const MAX_SPEED = 1.0;

/*最小转动速度*/
static CGFloat const MIN_SPEED = 0.05;


@interface YLWheelHelper : NSObject


/**
 计算两个点 之间的距离

 @param startPoint 起始点
 @param endPoint 终止点
 @return 亮点距离
 */
+ (CGFloat)getDistanceWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;



/**
 根据起始点，终止点和固定的中心点，计算出当前转动是 顺时针/逆时针

 @param startPoint 起始点
 @param endPoint 终止点
 @param centerPoint 中心点
 @return 转动方向，顺时针/逆时针
 */
+ (RotateDirection)getRotateDirection:(CGPoint)startPoint endPoint:(CGPoint)endPoint centerPoint:(CGPoint)centerPoint;



/**
 计算旋转角度
 
 @param startPoint 起始点
 @param endPoint 终止点
 @param centerPoint 固定中心点
 @return 旋转的
 */
+ (CGFloat)calculateAngle:(CGPoint)startPoint endPoint:(CGPoint)endPoint centerPoint:(CGPoint)centerPoint;



/**
 计算出旋转时的速度

 @param startPoint 起始点
 @param endPoint 终止点
 @param timeInterval 时间间隔
 @return 速度
 */
+ (CGFloat)calculateSpeed:(CGPoint)startPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval;



@end
