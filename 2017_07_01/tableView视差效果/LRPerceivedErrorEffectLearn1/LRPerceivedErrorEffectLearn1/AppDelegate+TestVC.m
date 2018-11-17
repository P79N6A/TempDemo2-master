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

    
    /**
     //    UIMotionEffect和Home页背景视差效果
     //    http://www.cocoachina.com/ios/20150121/10967.html
     
     
     //    http://blog.csdn.net/mr_smile2014/article/details/51761695
     //    移动端HTML5页面端去掉input输入框的白色背景和边框（兼容Android和ios）
     
     
     //    https://github.com/chbo297/CCZoomTransition
     //    ViewController present的转场特效，只需要一行代码，就可以的到一个类似于系统打开APP的present特效啦。
     */
    
    
    
    
    
    // MARK: - 渐变色
    [array addObject:@"TestVC1"];

    
    // MARK: - iOS TableView滚动时的视觉差效果
    // MARK: 1> http://www.cocoachina.com/ios/20160712/17011.html
    // MARK: 2> https://github.com/luran2358/LRPerceivedErrorEffect
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
    NSString *clsName = mArray[0];
    
    
    
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



