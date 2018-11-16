//
//  XiuView.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/6/2.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "XiuView.h"

#define MySize [UIScreen mainScreen].bounds.size


@implementation XiuView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path0 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(MySize.width/2-50, MySize.height/2-50, 100,100) cornerRadius:50];
    [[UIColor redColor]setStroke];
    [[UIColor redColor]setFill];
    [path0 stroke];
    [path0 fill];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //画 1/4  圆
    //center 圆心
    //radius 半径
    //startAngle 起始弧度
    //endAngle 结束弧度
    //clockwise 是否顺时针
    [path addArcWithCenter:CGPointMake(MySize.width/2, MySize.height/2) radius:26 startAngle:M_PI*2 endAngle:M_PI*3 clockwise:YES];
    path.lineWidth = 8;
    [[UIColor yellowColor] setStroke];
    [path stroke];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(MySize.width/2-7, MySize.height/2-10, 14,14) cornerRadius:7];
    [[UIColor yellowColor]setStroke];
    [[UIColor yellowColor]setFill];
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
