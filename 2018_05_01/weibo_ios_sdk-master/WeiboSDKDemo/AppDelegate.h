//
//  AppDelegate.h
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 3/29/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendMessageToWeiboViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>
{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SendMessageToWeiboViewController *viewController;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end


// MARK: - 新浪微博SDK地址
// https://github.com/sinaweibosdk/weibo_ios_sdk

//#常见问题 FAQ https://github.com/sinaweibosdk/weibo_ios_sdk/blob/master/FAQ.md
/*
 Q:21338 sso package or sign error
 
 A:平台设置和项目设置的Bundle id不一致导致的，必须保证字符完全匹配。
 
 Q:弹出授权窗口后瞬间消失
 
 A:两个可能 1、bundle id不一致导致 2、https://github.com/sinaweibosdk/weibo_ios_sdk/issues/6
 
 Q:WeiboSDKResponseStatusCodeUnknown = -100,
 
 A:检查一下 bundle id设置
 */
