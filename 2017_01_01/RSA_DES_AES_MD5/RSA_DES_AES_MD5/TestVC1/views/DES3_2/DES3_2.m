//
//  DES3_2.m
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 2017/9/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DES3_2.h"
#import "GTMBase64.h"

#define DESKEY @"np!u5chin@adm!n1aaaaaaaa"


@implementation DES3_2

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[DESKEY UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
}
@end








/*
 http://blog.sina.com.cn/s/blog_6f62cda30101uovl.html
 
 
 搞了3DES加密，很是蛋疼，在此贴出代码以供分享，
 这个方式是java， oc， C#通用方法。  key 必须是24位
 
 objective -C代码和java代码，网上很多，给一链接给大家参考
 
 
 ios:
 首先进入头文件：
 
 #import   < CommonCrypto/CommonDigest.h>
 #import   < CommonCrypto/CommonCryptor.h>
 #import   < Security/Security.h>
 -(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
 {
 
 const void *vplainText;
 size_t plainTextBufferSize;
 
 if (encryptOrDecrypt == kCCDecrypt)//解密
 {
 NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
 plainTextBufferSize = [EncryptData length];
 vplainText = [EncryptData bytes];
 }
 else //加密
 {
 NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
 plainTextBufferSize = [data length];
 vplainText = (const void *)[data bytes];
 }
 
 CCCryptorStatus ccStatus;
 uint8_t *bufferPtr = NULL;
 size_t bufferPtrSize = 0;
 size_t movedBytes = 0;
 
 bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
 bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
 memset((void *)bufferPtr, 0x0, bufferPtrSize);
 // memset((void *) iv, 0x0, (size_t) sizeof(iv));
 
 const void *vkey = (const void *)[DESKEY UTF8String];
 // NSString *initVec = @"init Vec";
 //const void *vinitVec = (const void *) [initVec UTF8String];
 //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
 ccStatus = CCCrypt(encryptOrDecrypt,
 kCCAlgorithm3DES,
 kCCOptionPKCS7Padding | kCCOptionECBMode,
 vkey,
 kCCKeySize3DES,
 nil,
 vplainText,
 plainTextBufferSize,
 (void *)bufferPtr,
 bufferPtrSize,
 &movedBytes);
 //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
 
 
 NSString *result;
 
 if (encryptOrDecrypt == kCCDecrypt)
 {
 result = [[[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
 length:(NSUInteger)movedBytes]
 encoding:NSUTF8StringEncoding]
 autorelease];
 }
 else
 {
 NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
 result = [GTMBase64 stringByEncodingData:myData];
 }
 
 return result;
 }
 
 可以用一个category，具体实现随意
 
 
 java客户端 3DES 解密和加密算法
 加密算法：
 public static String encryptThreeDESECB(String src,String key) throws Exception
 {
 DESedeKeySpec dks = new DESedeKeySpec(key.getBytes("UTF-8"));
 SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
 SecretKey securekey = keyFactory.generateSecret(dks);
 
 Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
 cipher.init(Cipher.ENCRYPT_MODE, securekey);
 byte[] b=cipher.doFinal(src.getBytes());
 
 BASE64Encoder encoder = new BASE64Encoder();
 return encoder.encode(b).replaceAll("\r", "").replaceAll("\n", "");
 
 }
 
 //3DESECB解密,key必须是长度大于等于 3*8 = 24 位
 public static String decryptThreeDESECB(String src,String key) throws Exception
 {
 //--通过base64,将字符串转成byte数组
 BASE64Decoder decoder = new BASE64Decoder();
 byte[] bytesrc = decoder.decodeBuffer(src);
 //--解密的key
 DESedeKeySpec dks = new DESedeKeySpec(key.getBytes("UTF-8"));
 SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
 SecretKey securekey = keyFactory.generateSecret(dks);
 
 //--Chipher对象解密
 Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
 cipher.init(Cipher.DECRYPT_MODE, securekey);
 byte[] retByte = cipher.doFinal(bytesrc);
 
 return new String(retByte);
 }
 
 
 C#代码：
 public class Des3
 {
 public static string DES3Encrypt(string strString, string strKey)
 {
 TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
 DES.Key = UTF8Encoding.UTF8.GetBytes(strKey);
 DES.Mode = CipherMode.ECB;
 DES.Padding = PaddingMode.PKCS7;
 
 ICryptoTransform DESEncrypt = DES.CreateEncryptor();
 
 byte[] Buffer = UTF8Encoding.UTF8.GetBytes(strString);
 return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
 }
 public static string DES3Decrypt(string strString, string strKey)
 {
 TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
 DES.Key = UTF8Encoding.UTF8.GetBytes(strKey);
 DES.Mode = CipherMode.ECB;
 ICryptoTransform DESDecrypt = DES.CreateDecryptor();
 string result = "";
 try
 {
 byte[] Buffer = Convert.FromBase64String(strString);
 result = UTF8Encoding.UTF8.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
 }
 catch(System.Exception e)
 {
 throw (new System.Exception("The Key or Mode is wrong!", e));
 }
 return result ;
 }
 }
 
 key是：np!u5chin@adm!n1aaaaaaaa
 明文：aaaaaaaa
 加密结果:ctjX3uKhmEaiWsWzVbjbpA==
 
 C#的pkcs5貌似没有，pkcs7可用。
 亲测可行！！！
 */
