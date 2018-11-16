//
//  IPhoneInfoHelper.h
//  DataHelper
//
//  Created by yulong on 16/1/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPhoneInfoHelper : NSObject

/// 获取手机名称
+ (NSString *)getDeviceName;

/// 获取系统名称
+ (NSString *)getDeviceSystemName;

/// 获取系统版本
+ (NSString *)getDeviceSystemVersion;

/// 获取UUID
+ (NSString *)getDeviceUUID;

/// 获取屏幕信息
+ (NSString *)getScreenInfo;

/// 获取运营商信息
+ (NSString *)getNetInfo;

/// 获取电池信息
+ (NSString *)getBetaryInfo;

/// 获取内存信息
+ (NSString *)getMemoryInfo;

@end



