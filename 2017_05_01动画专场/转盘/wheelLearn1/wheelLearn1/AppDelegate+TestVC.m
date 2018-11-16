//
//  AppDelegate+TestVC.m
//  UserInfoLearn1
//
//  Created by xiaoyulong on 17/3/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate+TestVC.h"


/*

 仿建设银行 圆形转盘菜单源码 Android 下载
 http://www.haolizi.net/example/view_4061.html
 
 */


@implementation AppDelegate (TestVC)

- (void)setupTestRootVC
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    
    
    
        
    /**
     
     
     http://www.oschina.net/question/2409237_2137347
     
     http://www.code4app.com/ios/EFCircularSlider/52a6bdd9cb7e84af088b5fa8
     
     http://blog.csdn.net/dolacmeng/article/details/46617517
     
     http://www.jianshu.com/p/a073ca14aced
     
     http://blog.csdn.net/arceushs/article/details/51173206
     
     */
    
    
    
    
    // MARK: - iOS 建行客户端的转盘菜单效果，有缩放的大小效果
    // http://download.csdn.net/download/a283127993/4408186
    [array addObject:@"TestVC10"];

    
    // MARK: - iOS版大转盘，没有手动拖动旋转的。
    // http://blog.csdn.net/lxmy2012/article/details/46981593
    [array addObject:@"TestVC9"];

    
    
    // MARK: - [ios]自定义圆形滑动条-ios升级日记1
    // http://poolo.iteye.com/blog/2039680
    [array addObject:@"TestVC8"];

    
    
    // MARK: - 转动时有启动速度，由慢到快，到加速到最快，后慢慢停止
    // http://download.csdn.net/detail/li6185377/5116713
    [array addObject:@"TestVC7"];

    
    // MARK: - iOS 仿建行转盘菜单，有少许惯性的
    // http://download.csdn.net/download/u010177443/8902207
    [array addObject:@"TestVC6"];

    
    // MARK: - 星座手动转动，手动拖动旋转，松手后就不转动了。
    // MARK: 先算角度，再 CATransform3DRotate 旋转
    [array addObject:@"TestVC5"];

    
    // MARK: - 一键点击转盘  手动转动转盘，这个例子最好。
    // MARK: 一键点击转盘  会慢慢停下来
    // MARK: 手动转动转盘，手松开后会有惯性，继续转动一会儿后停止转动，转动过程中手指按住会立即停止转动。
    // MARK: https://github.com/dongjueai/YDXTurntable
    // MARK: http://www.jianshu.com/p/4056faba6019
    [array addObject:@"TestVC4"];

    
    // MARK: - 轮盘动态效果动画, 打分
    [array addObject:@"TestVC3"];
    
    
    // MARK: - 抽奖转盘，没有手动惯性
    // MARK: http://download.csdn.net/download/u010545480/9285505
    [array addObject:@"TestVC2"];
    
    
    
    // MARK: - 风车转动 稍微封装一下
    [array addObject:@"TestVC1"];
    

    
    // MARK: - 风车转动
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
    NSString *clsName = mArray[1];
    
    
    
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



