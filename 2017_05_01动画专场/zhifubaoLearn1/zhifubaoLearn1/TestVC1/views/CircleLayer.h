//
//  CircleLayer.h
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CircleLayer : CALayer

@property (nonatomic, assign) CGFloat progress;

- (void)animateCircle;

@end
