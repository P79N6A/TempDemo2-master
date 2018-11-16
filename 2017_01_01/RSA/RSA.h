


#import <Foundation/Foundation.h>

@interface RSA : NSObject
//解析16进制的
+ (NSData *) decodeFromHexString:(NSString *)hexString ;
//验证签名
+ (BOOL)verifySHA512WithPlainData:(NSData *)plainData signatureData:(NSData *)signatureData publicKey:(NSString *)publicKey ;

@end
