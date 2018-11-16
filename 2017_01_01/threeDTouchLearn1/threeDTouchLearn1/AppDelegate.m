//
//  AppDelegate.m
//  threeDTouchLearn1
//
//  Created by xiaoyulong on 2017/5/27.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
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
    
    RootViewController *root = [[RootViewController alloc] init];
    self.rootNav = [[UINavigationController alloc] initWithRootViewController:root];
    root.navigationItem.title = @"RootViewController";
    self.window.rootViewController = self.rootNav;
    
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


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"shortcutItem.type==%@", shortcutItem.type);
    NSLog(@"shortcutItem.userInfo==%@", shortcutItem.userInfo);
    
    
    if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn1.sousuo"])
    {
        NSLog(@"跳转main");
        UIViewController *controller = [[UIViewController alloc] init];
        controller.navigationItem.title = @"跳转sousuo";
        [self.rootNav pushViewController:controller animated:YES];
        
//        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        
        
    }
    else if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn1.saoyisao"])
    {
        NSLog(@"跳转second");
        UIViewController *controller = [[UIViewController alloc] init];
        controller.navigationItem.title = @"跳转saoyisao";
        [self.rootNav pushViewController:controller animated:YES];
        
    }
    else if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn1.mudidi"])
    {
        NSLog(@"跳转three");
        UIViewController *controller = [[UIViewController alloc] init];
        controller.navigationItem.title = @"跳转mudidi";
        [self.rootNav pushViewController:controller animated:YES];
    }
   
    
}





@end
