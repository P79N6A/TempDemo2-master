//
//  NSString+Convertion.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Convertion)

//字符串表示的字节转化为字节数据 "ABCD12" --->ABCD12
@property(nonatomic,readonly) NSData* hexData;

@end
