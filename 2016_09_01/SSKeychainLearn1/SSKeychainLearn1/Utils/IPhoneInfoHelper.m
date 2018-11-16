//
//  IPhoneInfoHelper.m
//  DataHelper
//
//  Created by yulong on 16/1/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "IPhoneInfoHelper.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

// 获取内存中用到
#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation IPhoneInfoHelper

/// 获取手机名称
+ (NSString *)getDeviceName
{
    return [[UIDevice currentDevice] name];
}

/// 获取系统名称
+ (NSString *)getDeviceSystemName
{
    return [[UIDevice currentDevice] systemName];
}

/// 获取系统版本
+ (NSString *)getDeviceSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/// 获取UUID
+ (NSString *)getDeviceUUID
{
    NSString *uuidInfo = [NSString stringWithFormat:@"%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    return uuidInfo;
}

/// 获取屏幕信息
+ (NSString *)getScreenInfo
{
    NSInteger kHeight = (NSInteger)[UIScreen mainScreen].bounds.size.height;
    NSString *screenSize = @"";
    NSInteger abs = 1;
    
    switch (kHeight) {
        case 480:
            screenSize = @"3.5寸";
            break;
        case 568:
            screenSize = @"4.0寸";
            abs = 2;
            break;
        case 667:
            screenSize = @"4.7寸";
            abs = 2;
            break;
        case 736:
            screenSize = @"5.5寸";
            abs = 2;
            break;
        default:
            break;
    }
    
    NSString *screenInfo = [NSString stringWithFormat:@"%@(%.0f*%.0f)", screenSize, kScreenWidth * abs, kScreenHeight * abs];
    return screenInfo;
}

/// 获取运营商信息
+ (NSString *)getNetInfo
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    // 运营商
    CTCarrier *carriver = info.subscriberCellularProvider;
    NSString *carriverName = [carriver carrierName];
    
    NSString *netInfo = [NSString stringWithFormat:@"%@", carriverName];
    return netInfo;
}

/// 获取电池信息
+ (NSString *)getBetaryInfo
{
    UIDevice *curDevice = [UIDevice currentDevice];
//    CGFloat batteryLevel = curDevice.batteryLevel * 100;
    NSString *batteryState = @"";
    if (curDevice.batteryState == UIDeviceBatteryStateCharging)
    {
        batteryState = [NSString stringWithFormat:@"正在充电--%.0f%%", fabs(curDevice.batteryLevel * 100)];
    }
    else if (curDevice.batteryState == UIDeviceBatteryStateFull)
    {
        batteryState = [NSString stringWithFormat:@"满电量"];
    }
    else
    {
        batteryState = [NSString stringWithFormat:@"剩余电量 %.0f%%", fabs(curDevice.batteryLevel * 100)];
    }
    return batteryState;
}

/// 获取内存信息
+ (NSString *)getMemoryInfo
{
    vm_statistics_data_t    vmStats;
    mach_msg_type_number_t  infoCount = HOST_VM_INFO_COUNT;
    kern_return_t           kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    
    double total = 0.0;
    double avalible = 0.0;
    
    if (kernReturn == KERN_SUCCESS)
    {
        total = vm_page_size * (vmStats.free_count + vmStats.active_count + vmStats.inactive_count + vmStats.wire_count) / 1024 / 1024.0;
        avalible = (vm_page_size * vmStats.free_count) / 1024 / 1024.0;
    }
    NSString *memInfo = [NSString stringWithFormat:@"%.2fM", avalible];

    return memInfo;
}


@end
