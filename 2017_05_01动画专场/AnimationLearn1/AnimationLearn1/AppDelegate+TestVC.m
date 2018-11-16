//
//  AppDelegate+TestVC.m
//  UserInfoLearn1
//
//  Created by xiaoyulong on 17/3/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate+TestVC.h"


@implementation AppDelegate (TestVC)

- (void)setupTestRootVC
{
    
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    // MARK: - 收藏（心脏）动画
    [array addObject:@"TestVC34"];

    
    // MARK: - iOS扇形动画菜单
    // MARK: http://download.csdn.net/download/u011918080/7632701
    [array addObject:@"TestVC33"];
    
    
    // MARK: - 展现弹出特价大广告的动画
    [array addObject:@"TestVC32"];
    
    
    // MARK: - CATransform3D y轴 360度旋转效果
    [array addObject:@"TestVC31"];
    
    
    // MARK: - CATransform3D  (动画)
    [array addObject:@"TestVC30"];

    
    // MARK: - 定时器的任务 dispatch_time_t
    [array addObject:@"TestVC29"];
    
    
    // MARK: - 定时器的任务 NStimer
    [array addObject:@"TestVC28"];
    
    
    // MARK: - 定时器的任务 CADisplayLink
    [array addObject:@"TestVC27"];
    
    
    // MARK: - 支付宝 咻一咻动画
    [array addObject:@"TestVC26"];
    

    // MARK: - 画动态线和点击出现波纹动画
    [array addObject:@"TestVC25"];
    
    
    // MARK: - 父视图和子视图之间的坐标转换
    [array addObject:@"TestVC24"];
    
    
    // MARK: - 简单的加入购物车的动画，包含坐标转换
    [array addObject:@"TestVC23"];

    
    // MARK: - 简单的加入购物车的动画，不用贝塞尔曲线，也还是简单的抛物线,CGPathCreateMutable
    [array addObject:@"TestVC22"];

    
    // MARK: - 简单的加入购物车的动画，贝塞尔曲线的初步使用;
    // MARK: 加入购物车动画，抛物线左边抛出，右边抛出，向右上抛出，向左上抛出；适合圆形的球抛出
    // https://github.com/ColorPenBoy/ShopCartBezier
    [array addObject:@"TestVC21"];

    
    // MARK: - 倾斜的动画啊
    [array addObject:@"TestVC20"];
    

    // MARK: - iOS中 喷枪打字动画
    [array addObject:@"TestVC19"];

    
    // MARK: - 创建咬牙动画
    [array addObject:@"TestVC18"];
    
    
    // MARK: - CABasicAnimation 组合动画
    [array addObject:@"TestVC17"];
    
    
    // MARK: - CABasicAnimation  (position)移动
    [array addObject:@"TestVC16"];
    
    
    // MARK: - CABasicAnimation  旋转 封装成category
    [array addObject:@"TestVC15"];
    
    
    // MARK: - CABasicAnimation  旋转 CAKeyframeAnimation
    [array addObject:@"TestVC14"];
    

    // MARK: - CABasicAnimation  旋转360度   天气通旋转启动页
    [array addObject:@"TestVC13"];
    

    // MARK: - CABasicAnimation  旋转动画，转圈，顺时针，逆时针
    [array addObject:@"TestVC12"];

    
    // MARK: - CABasicAnimation  (position); 输入密码不对的抖动效果
    [array addObject:@"TestVC11"];
    
    
    // MARK: - CABasicAnimation  (transform.scale) 缩放动画
    [array addObject:@"TestVC10"];
    

    // MARK: - CAAnimation是什么呢;
    // MARK: 分为4种 1.CABasicAnimation 2.CAKeyframeAnimation 3.CAAnimationGroup 4.CATransition
    [array addObject:@"TestVC9"];
    

    // MARK: - Gif 动画
    [array addObject:@"TestVC8"];
    
    
    // MARK: - UIView  (双击变大变小)
    [array addObject:@"TestVC7"];
    
    
    // MARK: - clipsToBounds 属性使用，拉开幕布一样
    [array addObject:@"TestVC6"];


    // MARK: - CATransition
    [array addObject:@"TestVC5"];
    

    // MARK: - UIView beginAnimations 例子2
    [array addObject:@"TestVC4"];
    
    
    // MARK: - UIView beginAnimations 例子1
    [array addObject:@"TestVC3"];
    
    
    // MARK: - CGAffineTransformMake [UIView animateWithDuration]
    [array addObject:@"TestVC2"];
    
    
    // MARK: - CGAffineTransformMakeRotation   [UIView animateWithDuration]
    [array addObject:@"TestVC1"];
    
    
    // MARK: - [UIView animateWithDuration]
    [array addObject:@"RootViewController"];
    
    
    [self makeControllerWith:array];
}

- (void)makeControllerWith:(NSArray *)array
{
//    NSString *clsName = array[0];
    
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSInteger i = array.count-1; i >= 0; --i)
    {
        [mArray addObject:array[i]];
    }
    NSString *clsName = mArray[12];
    
    
    
    
    Class class = NSClassFromString(clsName);
    
    UIViewController *rootVC = [[class alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootVC.navigationItem.title = NSStringFromClass(rootVC.classForCoder);
    rootVC.edgesForExtendedLayout = UIRectEdgeNone;
    rootVC.automaticallyAdjustsScrollViewInsets = NO;
    rootVC.extendedLayoutIncludesOpaqueBars = NO;
    self.window.rootViewController = nav;
    
}


@end



