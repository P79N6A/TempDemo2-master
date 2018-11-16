//
//  BSSecurity.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSSecurity : NSObject

/*
//公钥初始化
    NSData *module = [@"B5CE747C46781C81488F169C72828B72233E6E3B70525D2CE088665EC1B61F3F5FC7FE96CFB8BFFA699D61D0316ACC8C021A03ABF703C75510990F95008E4A3303ACF424B3E7EFEA001D0499CE00EB293A79B2054D11852E66D81EABF9B714A0013611059810C4CD670B50AC5D2E6B743049A5297AD38690C25BB3BBF95A331D" hexData];    
    NSData *exponent = [@"010001" hexData];
    
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    [testArray addObject:module];
    [testArray addObject:exponent];
    _publicKeyData = [testArray berData];
*/
+(NSData*)rsaEncrypt:(NSData*)publicKey  rawData:(NSData*)rawData;
+(NSData*)rsaDecrypt:(NSData*)privateKey ripeData:(NSData*)ripeData;

//DES
+(NSData*)genDesKey;
+(NSData*)desEncrypt:(NSData*)desKey rawData:(NSData*)rawData;
+(NSData*)desDecrypt:(NSData*)desKey ripeData:(NSData*)ripeData;


@end
