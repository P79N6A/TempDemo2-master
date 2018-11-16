//
//  DES3Util.h
//  DES
//
//  Created by Toni on 12-12-27.
//  Copyright (c) 2012年 sinofreely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>

//#import "NSString+NSReplace.h"

@interface DES3Util : NSObject

//加密方法
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;



// 唯品会 使用的加密
// 加密方法
+ (NSString *)encrypt:(NSString*)plainText key:(NSString *)key;

// 解密方法
+ (NSString *)decrypt:(NSString*)encryptText key:(NSString *)key;



@end
