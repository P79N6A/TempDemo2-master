//
//  FreshlightManager.h
//  DataHelper
//
//  Created by yulong on 15/12/16.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//  功能描述：用于调用设备闪光灯（打开或关闭）

#import <Foundation/Foundation.h>

@interface FreshlightManager : NSObject

/// 打开或关闭闪光灯
+ (void)showFreshlight;

@end
