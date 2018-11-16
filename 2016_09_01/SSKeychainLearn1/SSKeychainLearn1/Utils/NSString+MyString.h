//
//  NSString+MyString.h
//  DataHelper
//
//  Created by yulong on 15/12/16.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyString)

/**
一段字符串 头和尾 两端如果有空格，就去掉
 中间如果有空格的话不管。
 */
+ (NSString *)stringBySpaceTrim:(NSString *)string;

/// 替换@为#
- (NSString *)replacingAtWithOctothorpe;

/// 是否为空  //null或者@"" 或者@" " 或者@"   " 都返回yes
+ (BOOL)isNull:(NSString *)string;

@end
