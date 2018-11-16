//
//  DES3_2.h
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 2017/9/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

@interface DES3_2 : NSObject

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

@end
