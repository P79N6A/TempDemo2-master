//
//  AppDelegate.h
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#if kUseScreenShotGesture
#import "ScreenShotView.h"
#endif
#import "TabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
//    https://github.com/zhengwenming/ScreenShotBack
//    全屏返回，截图手势返回，景深效果，类似斗鱼、天天快报、腾讯新闻等APP的手势返回。
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TabBarViewController *tabBarViewController;
#if kUseScreenShotGesture
@property (strong, nonatomic) ScreenShotView *screenshotView;
#endif

/// func
+ (AppDelegate* )shareAppDelegate;

@end

