//
//  AppDelegate.m
//  UINavigationLearn2
//
//  Created by xiaoyulong on 2017/6/27.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+TestVC.h"

#define COMMON_BLUE_COLOR [UIColor colorWithRed:51./255. green:153./255. blue:204./255. alpha:1.]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setupTestRootVC];
    
    
    // 全局修改导航栏字体
    NSString *fontName = @"AvenirNext-Medium";
    NSDictionary *titleTextAttributes;
    titleTextAttributes = @{
                            NSFontAttributeName: [UIFont fontWithName:fontName size:20.],
                            };
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
    [[UINavigationBar appearance] setTintColor:COMMON_BLUE_COLOR];
    
    
    // 全局修改导航栏 UIBarButtonItem 字体
    titleTextAttributes = @{
                            NSFontAttributeName: [UIFont fontWithName:fontName size:16.],
                            };
    [[UIBarButtonItem appearance] setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTintColor:COMMON_BLUE_COLOR];

    
    
    
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
