//
//  AppDelegate.m
//  TVSignLearn1
//
//  Created by xiaoyulong on 2017/6/30.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "TVSignFramework/TVSignFramework.h"
#import "RootViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
//    if(SIGN_SERVER_ENVIROMENT == 0) {
        // 正式环境
//#warning 正式环境请用自己的项目配置
//        [TVSignFramework setAppProjectId:eSignBaoProjectId projectSecret:eSignBaoProjectSecret serverEnviroment:0];
//    }
//    else if(SIGN_SERVER_ENVIROMENT == 1) {
//        // 测试环境
        [TVSignFramework setAppProjectId:@"1111563423" projectSecret:@"cc6a12aa9a1490c241089838ba3d64c2" serverEnviroment:1];
        [TVSignFramework setAppProjectId:@"1111563423" projectSecret:@"cc6a12aa9a1490c241089838ba3d64c2"];
//    }
//    else if(SIGN_SERVER_ENVIROMENT == 2) {
        // 模拟环境
//        [TVSignFramework setAppProjectId:@"1111563562" projectSecret:@"612c09869b978d3f642242c79439aaaa" serverEnviroment:2];
//        [TVSignFramework setAppProjectId:@"1111563562" projectSecret:@"612c09869b978d3f642242c79439aaaa"];
//    }
    
    
    
    
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
