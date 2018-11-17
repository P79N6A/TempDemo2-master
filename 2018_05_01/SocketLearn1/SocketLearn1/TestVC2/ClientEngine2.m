//
//  ClientEngine2.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "ClientEngine2.h"
#import "AsyncSocket.h"

@interface ClientEngine2 () <AsyncSocketDelegate>

@end


@implementation ClientEngine2


#pragma mark - AsyncSocketDelegate

// 成功连接后自动回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"客户端--已经连接到%@：%d", host, port);
}

// 写数据成功 自动回调
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
    NSLog(@"客户端--写入数据完成");
    // 继续监听
    [sock readDataWithTimeout:-1 tag:1];
}

// 客户端接收到了数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"客户端--收到数据");
    
    // 继续监听
    [sock readDataWithTimeout:-1 tag:1];
}


@end
