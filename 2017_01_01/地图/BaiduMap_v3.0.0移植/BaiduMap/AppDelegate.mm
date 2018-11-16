//
//  AppDelegate.m
//  BaiduMap
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+TestVC.h"
#import "AppDelegateBaiduMapHelper.h"


#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "RootViewController.h"
#import "TestVC1.h"
#import "TestVC2.h"


@interface AppDelegate ()
//{
//    BMKMapManager* _mapManager;
//
//}

@property (nonatomic, strong) AppDelegateBaiduMapHelper *baiduMapHelper;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _baiduMapHelper = [[AppDelegateBaiduMapHelper alloc] init];
    

    [self setupTestRootVC];
    
   
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

//- (void)onGetNetworkState:(int)iError
//{
//    if (0 == iError) {
//        NSLog(@"联网成功");
//    }
//    else{
//        NSLog(@"onGetNetworkState %d",iError);
//    }
//
//}
//
//- (void)onGetPermissionState:(int)iError
//{
//    if (0 == iError) {
//        NSLog(@"授权成功");
//    }
//    else {
//        NSLog(@"onGetPermissionState %d",iError);
//        /**
//         http://lbsyun.baidu.com/index.php?title=lbscloud/api/appendix
//         最下面有控制服务返回码状态码含义
//
//         204 APP 服务被禁用    用户在API控制台中创建或设置某APP的时候禁用了某项服务
//         */
//    }
//}

@end
