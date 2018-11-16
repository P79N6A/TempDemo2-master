//
//  RSAManager.h
//  RSA1
//
//  Created by xiaoyulong on 16/7/13.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>


// 测试
#define RSA_Public_key         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDB0zMFedOZ4961mXJCco+BrXFFEZagmcjKRiph2H4KKN2N14At+ZjfoPDQcov6FFX+FB5jjIsypfxM6RmZyl9U+shFG1DgH4jBSLK3COYuThuPB0o/GirWmcU+aaLWVHzQP/wrSd+JVoBiugo2MpWgoEi6Et6qyz4PprS9LyJSMQIDAQAB"
//私钥
#define RSA_Privite_key        @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMHTMwV505nj3rWZckJyj4GtcUURlqCZyMpGKmHYfgoo3Y3XgC35mN+g8NByi/oUVf4UHmOMizKl/EzpGZnKX1T6yEUbUOAfiMFIsrcI5i5OG48HSj8aKtaZxT5potZUfNA//CtJ34lWgGK6CjYylaCgSLoS3qrLPg+mtL0vIlIxAgMBAAECgYBarrtiRntPtqMOB7rDh+HIZCNokzAL96dPq8BMgwOFMVVm9XpNCEgT6LKCc/U1jaol87e8D5dYnPwL58tIfrxWrZvTzwSlNLjeDZM6rM/0sNszIGNS/k8JSLDLMtNCAaBLL5y5H8o1pp5OpJEawlfVDogfR/aqjL83qbQHltdbuQJBAP8T1c2JTu77tm3WIx6inAqqzDtf9I+GarpTpdHG+Jkt0GOnDsYDDTewgPcS5o3qELv2IcRVvSYhO1MLYgEklwMCQQDChqc4EXAmMoxlVDwmJ7TJ3KGjKvfsBqB5c1VnITTwX3lKbKZSLEpJOc4AFWPi1SVFWJMQFYXWUvpspQVCmwG7AkEAqArCNJj7xldPlMaY9mq8EA77YzZQ4Gj2UPAgcrX5OrjC65O4GN0TzRdbrunlt6J3Cc0Z68VsSf1kns4F76jSTwJAPveTXWTXpqWqKIqxxbAIp2cRs12PTwl+HJImzPFEz6I4As1UsTjA+x8I/aHu6VgRbncTc5tj7VKC2XQ5VawTTQJAWZ0Wk/0hp+4RktNcbuGejFTJZnJdTtyaiC3L34zuP7M5vcVCAWZeKXMTMJmW3EsZ8eF3v1VqHBFwgV/HPKpnuQ=="


@interface RSAManager : NSObject

//+ (id)shareInstance;

- (id)initWithKeyPath:(NSString *)publicKeyPath;

- (NSString *)encryptWithString:(NSString *)content;



// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end
