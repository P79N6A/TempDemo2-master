//
//  ClientEngine3.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "ClientEngine3.h"
#import "AsyncSocket.h"

@interface ClientEngine3 () <AsyncSocketDelegate>

@end

@implementation ClientEngine3


// 客户端成功连接至服务端后，调用此方法
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"客户端 -- 成功连接 %@:%hu", host, port);
    [sock readDataWithTimeout:-1 tag:10];
}

// 当接收到数据时调用该函数
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"客户端 -- 接收到数据 %@",msg);
    [sock readDataWithTimeout:-1 tag:10];
}

// 当写入数据完成后，调用该方法
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"客户端 -- 写入数据完成");
}


@end
