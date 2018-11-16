//
//  CALayer+Animation.m
//  ShopDemo
//
//  Created by yulong on 16/1/8.
//  Copyright © 2016年 wanglh. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (Animation)
@dynamic succeedBack;


/**
 *  输入错误时左右摇动
 */
- (void)shake
{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 16;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = .1f;
    
    //重复
    kfa.repeatCount =2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}

/**
 *  购物车图标上下震动
 */
- (void)shoppingCartShake
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [self addAnimation:shakeAnimation forKey:nil];
}

/**
 *  购物车数字用0.25s的时间由hidden->show
 */
- (void)shoppingCartLabelTextShadeChange
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25f;
//    _cntLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_cnt];
    [self addAnimation:animation forKey:nil];
}



/**
 * 添加到购物车的被塞尔曲线动画
 */
- (void)addShoppingcartGroupAnimationWithBezierPath:(UIBezierPath *)path with:(void (^)(BOOL flag, CAAnimation *anim))succeed
{
    self.succeedBack = [succeed copy];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
//    //放大
//    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    expandAnimation.duration = 0.5f;
//    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
//    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
//    expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //缩小
//    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    narrowAnimation.beginTime = 0.5;
//    narrowAnimation.duration = 1.5f;
//    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
//    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
//    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation];
//    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.7;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [self addAnimation:groups forKey:@"group"];

}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self animationForKey:@"group"])
    {
        NSLog(@"animationDidStop");
        if (self.succeedBack)
        {
            self.succeedBack(flag, anim);
        }
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

@end










