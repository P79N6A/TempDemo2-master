//
//  NSString+MyString.m
//  DataHelper
//
//  Created by yulong on 15/12/16.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

/// 去掉空格
+ (NSString *)stringBySpaceTrim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/// 替换@为#
- (NSString *)replacingAtWithOctothorpe
{
    return [self stringByReplacingOccurrencesOfString:@"@" withString:@"#"];
}

/// null或者@""都返回yes
+ (BOOL)isNull:(NSString *)string
{
    if (!string || [string isEqualToString:@""] ||[string isEqualToString:@" "]||[string isEqualToString:@"  "])
    {
        return YES;
    }
    return NO;
}


@end
