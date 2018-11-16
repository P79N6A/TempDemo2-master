//
//  AppDelegate.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "MLTransition.h"

#import "RootViewController.h"
#import "TestVC1.h"
#import "TestVC2.h"
#import "TestVC3.h"
#import "TestVC4.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    
    // 点击随便位置滑动返回
    // MLTransitionGestureRecognizerTypePan
    // 点击边缘
    //or MLTransitionGestureRecognizerTypeScreenEdgePan
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
#pragma mark - 测试下搜索bar显示时候的效果
//    TestVC4 *root = [[TestVC4 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
    
#pragma mark - 测试切换nav的隐藏后效果
//    TestVC3 *root = [[TestVC3 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
#pragma mark - 测试在图片浏览器里能否正常执行
//    TestVC2 *root = [[TestVC2 alloc] init];
//    self.window.rootViewController = root;

    
#pragma mark - 针对ViewController  self.view.disableMLTransition = NO;
    TestVC1 *root = [[TestVC1 alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;


    
#pragma mark - 针对导航栏  [self.navigationController enabledMLTransition:YES]
    /**
     控制开启 
     setDisableMLTransition
     enabledMLTransition
     https://github.com/molon/MLTransition
     有丝滑效果，可以控制开启关闭
     可以控制点击位置是边缘还是任意
     
     个人觉得这个库 比较 FDFullscreenPopGesture-master 要好一些
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
