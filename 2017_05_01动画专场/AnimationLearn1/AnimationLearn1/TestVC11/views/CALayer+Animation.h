//
//  CALayer+Animation.h
//  ShopDemo
//
//  Created by yulong on 16/1/8.
//  Copyright © 2016年 wanglh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CALayer (Animation) <CAAnimationDelegate>

/// 设置代码块属性-成功
@property (nonatomic, copy) void (^succeedBack)(BOOL flag, CAAnimation *anim);

/**
 *  输入错误时左右摇动
 */
- (void)shake;

/**
 *  购物车图标上下震动
 */
- (void)shoppingCartShake;

/**
 *  购物车数字用0.25s的时间由hidden->show
 */
- (void)shoppingCartLabelTextShadeChange;


/**
 * 添加到购物车的被塞尔曲线动画
 */
- (void)addShoppingcartGroupAnimationWithBezierPath:(UIBezierPath *)path with:(void (^)(BOOL flag, CAAnimation *anim))succeed;



@end















