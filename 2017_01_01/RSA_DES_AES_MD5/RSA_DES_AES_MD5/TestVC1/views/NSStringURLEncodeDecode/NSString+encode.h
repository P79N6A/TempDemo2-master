//
//  NSString+encode.h
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 2017/9/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encode)

// 空格变成了%20
// 等号变成了%3d


+ (NSString *)URLEncodedString:(NSString *)str;

+ (NSString *)URLDecodedString:(NSString *)str;


@end
