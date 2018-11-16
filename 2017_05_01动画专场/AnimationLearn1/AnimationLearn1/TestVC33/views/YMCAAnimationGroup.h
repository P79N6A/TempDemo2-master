//
//  YMCAAnimationGroup.h
//  CoreAnimationDemo
//
//  Created by yumiao on 14-6-19.
//  Copyright (c) 2014年 clover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMCAAnimationGroup : NSObject 

+ (CAAnimationGroup *)fromPoint:(CGPoint)from toPoint:(CGPoint)to duration:(CFTimeInterval)duration button:(UIButton *)button;
+ (CAAnimationGroup *)fromEndPoint:(CGPoint)from toStartPoint:(CGPoint)to duration:(CFTimeInterval)duration button:(UIButton *)button;



@end
