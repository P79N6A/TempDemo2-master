//
//  JoDes.h
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 2017/9/11.
//  Copyright © 2017年 xiaoyulong. All rights reserved.

// PHP、JAVA、C#、Object-C 通用的DES加密
//   http://www.cnblogs.com/pengxl/p/3967040.html

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface JoDes : NSObject

+ (NSString *) encode:(NSString *)str key:(NSString *)key;
+ (NSString *) decode:(NSString *)str key:(NSString *)key;

@end
