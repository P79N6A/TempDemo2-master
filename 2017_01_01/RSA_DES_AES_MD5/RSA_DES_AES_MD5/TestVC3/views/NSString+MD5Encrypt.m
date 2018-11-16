//
//  NSString+MD5Encrypt.m
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "NSString+MD5Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Encrypt)

- (NSString *)md5Encrypt {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (NSInteger i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
        
        // 小写
//        [hash appendFormat:@"%02x", result[i]];
    }
    
//    return hash;
    
    // 大写
//    return [hash uppercaseString];
    
    // 小写
    return [hash lowercaseString];
}

@end
