//
//  AppDelegate.m
//  iOS7SlidePop
//
//  Created by xiaoyulong on 16/7/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "TestVC1.h"
#import "TestVC2.h"
#import "TestVC3.h"

#import "TestVC4.h"
#import "ParentNavController.h"


#import "TestVC5.h"
#import "BaseNavController.h"

#import "TestVC6.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    
    
#pragma mark - 原理是进入页面时截取一张图片
    /**
     出处：   https://github.com/vinqon/MultiLayerNavigation
     
     使用时只要继承
     MLNavigationController 就行了
     
     原理是进入页面时截取一张图片，
     */
    TestVC6 *root = [[TestVC6 alloc] init];
    self.window.rootViewController = root;
    
    
    
#pragma mark - iOS 7以上，不再屏幕左侧边缘也能滑动返回，方案2 Runtime+KVC，有丝滑的感觉的
//    TestVC5 *root = [[TestVC5 alloc] init];
//    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:root];
//    // 导航栏隐藏也可以的
////    nav.navigationBarHidden = YES;
//    self.window.rootViewController = nav;

    
    
    
#pragma mark - iOS 7以上，不再屏幕左侧边缘也能滑动返回，方案1UIViewControllerInteractiveTransitioning，但是没有丝滑的效果哦
    
    /**
     文章出处：http://www.jianshu.com/p/d39f7d22db6c
     https://github.com/zys456465111/CustomPopAnimation
     苹果在IOS7以后给导航控制器增加了一个Pop的手势，只要手指在屏幕边缘滑动，当前的控制器的视图就会跟随你的手指移动，当用户松手后，系统会判断手指拖动出来的大小来决定是否要执行控制器的Pop操作。
     
     这个操作的想法非常好，但是系统给我们规定的范围必须是屏幕左侧边缘才可以触发，这样实际使用过程中对于有些产品会产生不便，于是有些app就采取整个屏幕都响应这个手势并且pop动画还是用系统原生的，这样操作起来确实方便好多。
     https://developer.apple.com/videos/wwdc2013/
     */
//    TestVC4 *root = [[TestVC4 alloc] init];
//    ParentNavController *nav = [[ParentNavController alloc] initWithRootViewController:root];
//    // 导航栏隐藏也可以的
////    nav.navigationBarHidden = YES;
//    self.window.rootViewController = nav;

    
    
#pragma mark - iOS7以上，系统自带导航栏，如何禁用滑动返回功能呢
//    TestVC3 *root = [[TestVC3 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;
    

#pragma mark - iOS7以上，如果由于隐藏了系统导航栏，或者自定义导航栏返回按钮导致iOS7自带的滑动返回功能停止使用，如何开启呢？
//    TestVC2 *root = [[TestVC2 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    nav.navigationBarHidden = YES;
//    self.window.rootViewController = nav;

    
    

#pragma mark - 如果隐藏系统自带的导航栏， iOS 7 自带的滑动返回功能就停止使用了
//    TestVC1 *root = [[TestVC1 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    nav.navigationBarHidden = YES;
//    self.window.rootViewController = nav;
    
#pragma mark - 如果自定义导航栏返回按钮， iOS 7 自带的滑动返回功能就停止使用了
    
    /**
     iOS 7 以上 都支持滑动pop手势返回功能。
     */
//    RootViewController *root = [[RootViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
