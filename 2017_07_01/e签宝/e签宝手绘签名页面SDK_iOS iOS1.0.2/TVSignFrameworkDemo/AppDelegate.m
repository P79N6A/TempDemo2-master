//
//  AppDelegate.m
//  TVSignFrameworkDemo
//
//  Created by wz on 16/5/11.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#import "AppDelegate.h"
#import "TVSignFramework/TVSignFramework.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if(SIGN_SERVER_ENVIROMENT == 0) {
        // 正式环境
#warning 正式环境请用自己的项目配置
        [TVSignFramework setAppProjectId:@"" projectSecret:@"" serverEnviroment:0];
    }
    else if(SIGN_SERVER_ENVIROMENT == 1) {
        // 测试环境
        [TVSignFramework setAppProjectId:@"1111563423" projectSecret:@"cc6a12aa9a1490c241089838ba3d64c2" serverEnviroment:1];
//        [TVSignFramework setAppProjectId:@"1111563423" projectSecret:@"cc6a12aa9a1490c241089838ba3d64c2"];
    }
    else if(SIGN_SERVER_ENVIROMENT == 2) {
        // 模拟环境
        [TVSignFramework setAppProjectId:@"1111563562" projectSecret:@"612c09869b978d3f642242c79439aaaa" serverEnviroment:2];
//        [TVSignFramework setAppProjectId:@"1111563562" projectSecret:@"612c09869b978d3f642242c79439aaaa"];
    }
    
    
    
    
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
