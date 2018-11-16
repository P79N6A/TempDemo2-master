//
//  AppDelegate.m
//  threeDTouchLearn2
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
    
    
    /**
     3D Touch 只在 iOS 9 及以上版本得到支持，之前版本的 iOS 并不支持该功能；
     3D Touch 只在 iPhone 6s 及以后型号的 iPhone 或 iPad Pro 上可用，更早的设备并不支持该功能。
     具体可通过如下代码进行判断：
     */
    // 判断系统版本大于9.0再设置 (若不判断 在低版本系统中会崩溃)
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 && root.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self addThreeDTouchItems];
    }
    
    
  
    
    
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

// 不管 app 是否在后台存在，点击3Dtouch 后的item 进入的是这个方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"shortcutItem.type==%@", shortcutItem.type);
    NSLog(@"shortcutItem.userInfo==%@", shortcutItem.userInfo);
    
    
    if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn2.main"])
    {
        NSLog(@"跳转main");
        UIViewController *controller = [[UIViewController alloc] init];
        controller.navigationItem.title = @"跳转main";
        [self.rootNav pushViewController:controller animated:YES];
        
//        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        completionHandler(YES);
    }
    else if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn2.second"])
    {
        NSLog(@"跳转second");
        UIViewController *controller = [[UIViewController alloc] init];
        controller.navigationItem.title = @"跳转second";
        [self.rootNav pushViewController:controller animated:YES];
        completionHandler(YES);
    }
    else if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn2.three"])
    {
        NSLog(@"跳转three");
        UIViewController *controller = [[UIViewController alloc] init];
        controller.navigationItem.title = @"跳转three";
        [self.rootNav pushViewController:controller animated:YES];
    }
    else if ([shortcutItem.type isEqualToString:@"com.ztev.threeDTouchLearn2.fourth"])
    {
        
        NSArray *arr = @[@"hello 3D Touch"];
        
        
        // 注意在iOS 10以后，已经在AppStore上架的的App都会
        
        // 如果弹出的是英文的，在 plist文件的， Localization native development region修改为 China
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:arr applicationActivities:nil];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        
        }];
        completionHandler(YES);
    }
}


- (void)addThreeDTouchItems
{
    /**
     * UIApplicationShortcutItem 创建标签的类
     * UIApplicationShortcutIcon 创建可变标签的类
     */
    
    // 添加系统自带的icon-type
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"西瓜" forKey:@"key1"];
    [dict setValue:@"番茄" forKey:@"key2"];
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"com.ztev.threeDTouchLearn2.main" localizedTitle:@"首页" localizedSubtitle:@"HomeVC" icon:icon userInfo:dict];
    
    
    
    // 如果系统图标不满足需求，可以使用 +(instancetype)iconWithTemplateImageName:(NSString *)templateImageName;
    // 添加自定义图片作为标签，需要注意的是：图片必须预先添加进bundle中
    // 添加自己的图标
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"diqiu"];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.ztev.threeDTouchLearn2.second" localizedTitle:@"SecondVC" localizedSubtitle:@"Second-sub-title" icon:icon1 userInfo:nil];
    
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"saoyisao"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"com.ztev.threeDTouchLearn2.three" localizedTitle:@"ThreeVC" localizedSubtitle:@"Three-sub-title" icon:icon2 userInfo:nil];
    
    
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"com.ztev.threeDTouchLearn2.fourth" localizedTitle:@"分享“我的APP”" localizedSubtitle:nil icon:icon3 userInfo:nil];

    
    
    // shortcutItems是一个数组
    [UIApplication sharedApplication].shortcutItems = @[item, item1, item2, item3];
}

@end
