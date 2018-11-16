//
//  DES3Util.m
//  DES
//
//  Created by Toni on 12-12-27.
//  Copyright (c) 2012年 sinofreely. All rights reserved.
//

#import "DES3Util.h"
#define gkey            @"app_key_ioved1cm!@#$5678"
//#define gkey            @"liuyunqiang@lx100$#365#$"
#define gIv             @"01234567"


@implementation DES3Util


 const Byte iv[] = {1,2,3,4,5,6,7,8};

//Des加密
 +(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
 {
    
     NSString *ciphertext = nil;
     NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
     NSUInteger dataLength = [textData length];
     unsigned char buffer[1024];
     memset(buffer, 0, sizeof(char));
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                           kCCAlgorithmDES,
                                           kCCOptionPKCS7Padding,
                                           [key UTF8String],
                                           kCCKeySizeDES,
                                           iv,
                                           [textData bytes],
                                           dataLength,
                                           buffer,
                                           1024,
                                           &numBytesEncrypted);
         if (cryptStatus == kCCSuccess) {
                 NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
                 ciphertext = [GTMBase64 stringByEncodingData:data];
             }
         return ciphertext;
     }



//Des解密
 +(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
 {
         NSString *plaintext = nil;
         NSData *cipherdata = [GTMBase64 decodeString:cipherText];
         unsigned char buffer[1024];
         memset(buffer, 0, sizeof(char));
         size_t numBytesDecrypted = 0;
         CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                                           kCCOptionPKCS7Padding,
                                                           [key UTF8String], kCCKeySizeDES,
                                                           iv,
                                                           [cipherdata bytes], [cipherdata length],
                                                           buffer, 1024,
                                                           &numBytesDecrypted);
         if(cryptStatus == kCCSuccess)
         {
                NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
                 plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
         }
     return plaintext;
}


+ (NSString *)encrypt:(NSString*)plainText key:(NSString *)key
{
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
//    NSString *key = @"eimseimseim@wm100$#365#$";
    const void *vkey = (const void *)[key UTF8String];
    
    NSString *initVec = @"20100901";
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    
    //    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //    const void *vkey = (const void *) [delegate.keyDES3 UTF8String];
    //    const void *vinitVec = (const void *) [delegate.ivDES3 UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    
    return result;
}

// 解密方法
+ (NSString *)decrypt:(NSString*)encryptText key:(NSString *)key
{
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
//    NSString *key = @"eimseimseim@wm100$#365#$";
    const void *vkey = (const void *)[key UTF8String];
    
    NSString *initVec = @"20100901";
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}



@end
