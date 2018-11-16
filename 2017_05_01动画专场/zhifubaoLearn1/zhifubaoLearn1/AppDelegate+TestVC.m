//
//  AppDelegate+TestVC.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate+TestVC.h"

@implementation AppDelegate (TestVC)

- (void)setupTestRootVC
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    // MARK: - 咻一咻 (看起来还不错哦)
    // MARK: http://code.cocoachina.com/view/129482
    [array addObject:@"TestVC5"];

    
    // MARK: - 咻一咻 雷达效果 （不咋地呀）
    // MARK: https://github.com/ShuangqiShi/RadarAnimationView
    [array addObject:@"TestVC4"];

    
    // MARK: - iOS仿支付宝芝麻信用仪表盘效果
    // MARK: http://www.jianshu.com/p/9f80840175db
    [array addObject:@"TestVC3"];

    
    // MARK: - 咻一咻  （不咋地呀）
    // MARK: http://www.jianshu.com/p/5e11d20a576d
    // MARK: iOS仿支付宝点击按钮带波浪效果
    [array addObject:@"TestVC2"];

    
    
    // MARK: - 支付转账成功动画，圆圈动画
    [array addObject:@"TestVC1"];
    
    
    // MARK: - 支付转账成功动画
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
    NSString *clsName = mArray[5];
    
    
    
    Class class = NSClassFromString(clsName);
    
    UIViewController *rootVC = [[class alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootVC.navigationItem.title = NSStringFromClass(rootVC.classForCoder);
    self.window.rootViewController = nav;
    
}

@end
