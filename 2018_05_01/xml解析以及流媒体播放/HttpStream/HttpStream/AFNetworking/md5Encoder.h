//
//  md5Encoder.h
//  NPCGOPocket
//
//  Created by Hanguang on 14-8-28.
//  Copyright (c) 2014年 HANGUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface md5Encoder : NSObject

+ (NSString *)encryptWithText:(NSString *)sText;
+ (NSString *)decryptWithText:(NSString *)sText;
+ (NSString *)md5HexDigest:(NSString*)input;

@end
