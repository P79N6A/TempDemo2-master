//
//  MapGDHelper.h
//  GPSLocation
//
//  Created by yulong on 15/10/11.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MapGDHelper : NSObject

/// 检测是否启用地图服务
+ (BOOL)MapServiceEnabled:(BOOL)showAlert;

/// 是否支持地图定位服务
+ (BOOL)isLocationServiceOn;

/// 是否开启地图服务
+ (BOOL)isCurrentAppLocatonServiceOn;

@end
