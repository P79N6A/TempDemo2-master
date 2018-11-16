//
//  ChineseInclude.h
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseInclude : NSObject

/// 判断字符串是否包含中文
+ (BOOL)isIncludeChineseInString:(NSString*)str;

@end
