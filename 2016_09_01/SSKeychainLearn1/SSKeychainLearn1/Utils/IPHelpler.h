//
//  IPHelpler.h
//  helper
//
//  Created by yulong on 15/4/27.
//  Copyright (c) 2015年 HuiXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPHelpler : NSObject

/// 获取设备IP地址，注意3G 4G 是没有ip地址的
+ (NSString *)getIPAddress;

@end
