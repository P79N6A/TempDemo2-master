//
//  MapGDHelper.m
//  GPSLocation
//
//  Created by yulong on 15/10/11.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "MapGDHelper.h"

#import <CoreLocation/CoreLocation.h>

/// 当前app名称
#define GetAppName ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"])


@interface MapGDHelper () 

@end

@implementation MapGDHelper

// 检测是否启用地图服务
+ (BOOL)MapServiceEnabled:(BOOL)showAlert
{
    BOOL serviceEnable = [self isLocationServiceOn];
    BOOL appServiceEnable = [self isCurrentAppLocatonServiceOn];
    if (!serviceEnable || !appServiceEnable)
    {
        NSString *messageStr = [NSString stringWithFormat:@"请在系统设置中开启定位服务\n(设置>隐私>定位服务>开启\"%@\")", GetAppName];
        if (showAlert)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:messageStr delegate:nil cancelButtonTitle:@"知道了"  otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        return NO;
    }
    
    return YES;
}

+ (BOOL)isLocationServiceOn
{
    return [CLLocationManager locationServicesEnabled];
}

+ (BOOL)isCurrentAppLocatonServiceOn
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


@end
