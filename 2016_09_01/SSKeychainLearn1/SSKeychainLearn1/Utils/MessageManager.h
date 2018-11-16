//
//  MessageManager.h
//  DataHelper
//
//  Created by yulong on 16/1/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//  调用 短信服务

#import <Foundation/Foundation.h>

@interface MessageManager : NSObject

/**
 * 调用phone可以传递号码，调用SMS 只能设定号码，不能初始化SMS内容。
 */
+ (void)sendMessageToPhoneNumber:(NSString *)phoneNumber;

/**
 * 调用 自带mail
 */
+ (void)sendMailTo:(NSString *)mailAddress;

/**
 * 网络链接跳转到safari浏览器上
 */
+ (void)safariOpenUrl:(NSString *)urlString;

@end
