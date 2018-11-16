//
//  UIBezierPath+Route.m
//  ShopDemo
//
//  Created by yulong on 16/1/8.
//  Copyright © 2016年 wanglh. All rights reserved.
//

#import "UIBezierPath+Route.h"

@implementation UIBezierPath (Route)

- (void)beginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
{
    [self moveToPoint:beginPoint];
    [self addQuadCurveToPoint:endPoint controlPoint:controlPoint];
}

@end
