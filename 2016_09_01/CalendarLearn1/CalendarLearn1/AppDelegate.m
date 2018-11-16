//
//  AppDelegate.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 16/9/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    /**
     IOS自定义日历控件的简单实现(附思想及过程)
     http://www.cnblogs.com/sevenyears/p/5921158.html
     
     
     因为程序要求要插入一个日历控件,该控件的要求是
     从当天开始及以后的六个月内的日历,上网查资料基本上都说
     只要获取两个条件(当月第一天周几和本月一共有多少天)就可以实现一个简单的日历,
     剩下的靠自己的简单逻辑就OK了,下面开始自己从开始到完成的整个过程
     
     */
    
//    UIViewController *controller = [[UIViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//    self.window.rootViewController = nav;
//
//    RootViewController *root = [[RootViewController alloc] init];
//    [nav pushViewController:root animated:YES];
    
    
    RootViewController *root = [[RootViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
