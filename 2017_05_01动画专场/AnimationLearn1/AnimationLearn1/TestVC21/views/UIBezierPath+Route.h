//
//  UIBezierPath+Route.h
//  ShopDemo
//
//  Created by yulong on 16/1/8.
//  Copyright © 2016年 wanglh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Route)

- (void)beginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;

@end
