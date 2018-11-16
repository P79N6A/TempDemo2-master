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
    
    
    // MARK: - navigationBar 两种隐藏方式
    // MARK: navigationBar.isHidden 支持右滑返回； isNavigationBarHidden不支持右侧滑动返回
    [array addObject:@"RootViewController"];
    
    // MARK: - 获取当前 controller 在导航中的第几层
    // MARK: [self.navigationController.viewControllers indexOfObject:]
    [array addObject:@"TestVC1"];
    
    // MARK: - self.navigationItem 左侧和右侧按钮
    // MARK: navigationBar.tintColor 和  navigationBar.barTintColor
    [array addObject:@"TestVC2"];
    
    
    // MARK: - navigationItem.titleView
    [array addObject:@"TestVC3"];
    
    
    // MARK: - self.navigationItem.title 与 self.title
    [array addObject:@"TestVC4"];
    
    
    // MARK: - navigationBar.translucent 与 self.edgesForExtendedLayout
    [array addObject:@"TestVC5"];
    
    
    // MARK: - push 后出现第0层
    [array addObject:@"TestVC6"];
    
 
    // MARK: - push 后出现第0层，修改正常
    [array addObject:@"TestVC7"];
    
    
    // MARK: - (present  dismiss)
    [array addObject:@"TestVC8"];
    
    
    // MARK: - 导航栏  工具栏  分栏 的高度，添加背景图
    [array addObject:@"TestVC9"];
    
    
    // MARK: - 导航栏和状态栏的隐藏
    [array addObject:@"TestVC10"];
    
    
    // MARK: - 导航控制器的 toolbar
    [array addObject:@"TestVC11"];
    
    
    // MARK: - UIActionSheet 返回上一层 跳到第几层
    [array addObject:@"TestVC12"];
    
    // MARK: - UIAlertView 返回上一层 跳到第几层
    [array addObject:@"TestVC13"];
    
    
    // MARK: - 导航控制器小结
    [array addObject:@"TestVC14"];
    
    
    
    // MARK: - iOS7 导航栏自带按钮偏移解决
    [array addObject:@"TestVC15"];
    
    
    
    // MARK: - 修改导航栏返回按钮字体位置
    [array addObject:@"TestVC16"];
    
    
    
    // MARK: - 修改导航栏背景颜色
    [array addObject:@"TestVC17"];
    
    

    // MARK: - A PUSH 到 B，B PUSH到 D，同时将B换成C。在D中Pop返回到C。
    [array addObject:@"TestVC18"];

    
    
    [self makeControllerWith:array];
}

- (void)makeControllerWith:(NSArray *)array
{
    NSString *clsName = array[18];
    
    
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = array.count-1; i >= 0; --i)
//    {
//        [mArray addObject:array[i]];
//    }
//    NSString *clsName = mArray[1];
    
    
    
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



