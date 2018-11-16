//
//  MessageManager.m
//  DataHelper
//
//  Created by yulong on 16/1/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//  调用 短信服务

#import "MessageManager.h"

@interface MessageManager ()

@end

@implementation MessageManager

/**
 * 调用phone可以传递号码，调用SMS 只能设定号码，不能初始化SMS内容。
 */
+ (void)sendMessageToPhoneNumber:(NSString *)phoneNumber
{
    NSString *urlStr = [NSString stringWithFormat:@"sms://%@", phoneNumber];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"短信功能不可用" message:@"" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

/**
 * 调用 自带mail
 */
+ (void)sendMailTo:(NSString *)mailAddress
{
    NSString *urlStr = [NSString stringWithFormat:@"mailto://%@", mailAddress];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"邮件功能不可用" message:@"" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

/**
 * 网络链接跳转到safari浏览器上
 */
+ (void)safariOpenUrl:(NSString *)urlString
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络链接不可用" message:@"" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end

























