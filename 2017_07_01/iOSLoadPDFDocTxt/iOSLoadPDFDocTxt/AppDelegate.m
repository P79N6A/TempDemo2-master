//
//  AppDelegate.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "TestVC1.h"
#import "TestVC2.h"
#import "TestVC3.h"
#import "TestVC4.h"
#import "TestVC5.h"
#import "TestVC6.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    
    
    /**
     文章地址
     http://blog.csdn.net/wenmingzheng/article/details/50471189
     Demo：https://github.com/zhengwenming/OpenFile
     https://github.com/zhengwenming?tab=repositories
     
     
     上面讲的都是打开的本地的文件，那么我如果要预览一个网页上的资源呢？
     类似这样的URL http://weixintest.ihk.cn/ihkwx_upload/1.pdf ，怎么办？
     理论是这样的，第一次预览，我们要下载到本地，然后打开这个资源，
     那么第n（n>1）次打开就从本地找到下载的这个资源直接打开就可以了。
     那么我们要在我们的vc里面写一个UIWebView了。
     比如我们的vc就是OpenRemoteFileViewController，那么来看具体的代码实现
     */
//    TestVC6 *root = [[TestVC6 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
    
    
#pragma mark - 再看UIDocumentInteractionController怎么用。
//    TestVC5 *root = [[TestVC5 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
#pragma mark - QLPreviewController怎么用
//    TestVC4 *root = [[TestVC4 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
#pragma mark - QLPreviewController怎么用
    
    /**
     iOS打开本地和网络上的word、ppt、excel、text等文件#
      iOS开发过程中可能需要预览一些文件，这些文件的格式可能有word、ppt、excel等文件格式。那么系统提供两个类去预览这些文件，这两个类分别为QLPreviewController和UIDocumentInteractionController。
     */
//    TestVC3 *root = [[TestVC3 alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
//    self.window.rootViewController = nav;

    
#pragma mark - webView 加载PDF
    TestVC2 *root = [[TestVC2 alloc] init];
    self.window.rootViewController = root;


#pragma mark - webView 加载docx
//    TestVC1 *root = [[TestVC1 alloc] init];
//    self.window.rootViewController = root;

#pragma mark - webView 加载txt
//    RootViewController *root = [[RootViewController alloc] init];
//    self.window.rootViewController = root;
    
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
