//
//  CircleView.m
//  Animation
//
//  Created by yulong on 16/2/17.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path0 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kScreenWidth/2-50, kScreenHeight/2-50, 100, 100) cornerRadius:50];
    [[UIColor redColor] setStroke];
    [[UIColor redColor] setFill];
    [path0 stroke];
    [path0 fill];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 画 1/4  圆
    // center 圆心
    // radius 半径
    // startAngle 起始弧度
    // endAngle 结束弧度
    // clockwise 是否顺时针
    [path addArcWithCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2) radius:26 startAngle:M_PI*2 endAngle:M_PI*3 clockwise:YES];
    path.lineWidth = 8;
    [[UIColor yellowColor] setStroke];
    [path stroke];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kScreenWidth/2-7, kScreenHeight/2-10, 14,14) cornerRadius:7];
    [[UIColor yellowColor] setStroke];
    [[UIColor yellowColor] setFill];
    [path1 stroke];
    [path1 fill];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
