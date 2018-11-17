//
//  AppDelegate.m
//  DrawImageLearn1
//
//  Created by xiaoyulong on 2017/6/5.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "TestVC1.h"
#import "TestVC2.h"
#import "TestVC3.h"
#import "TestVC4.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    TestVC4 *root = [[TestVC4 alloc] init];
    self.window.rootViewController = root;
    
    
//    TestVC3 *root = [[TestVC3 alloc] init];
//    self.window.rootViewController = root;
    
    
//    TestVC2 *root = [[TestVC2 alloc] init];
//    self.window.rootViewController = root;
    
    
//    TestVC1 *root = [[TestVC1 alloc] init];
//    self.window.rootViewController = root;

    
//    RootViewController *root = [[RootViewController alloc] init];
//    self.window.rootViewController = root;
    
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
