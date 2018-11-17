//
//  ServerEngine2.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "ServerEngine2.h"
#import "AsyncSocket.h"

@interface ServerEngine2 () <AsyncSocketDelegate>

@property (nonatomic, strong) NSMutableArray *socketArray;

@end


@implementation ServerEngine2

#pragma mark - AsyncSocketDelegate

// 有新的socket向服务器链接自动回调
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket {
    NSLog(@"有新的socket向服务器链接自动回调");
    
    if (_socketArray == nil) {
        _socketArray = [NSMutableArray array];
    }
    [_socketArray addObject:newSocket];
    [sock readDataWithTimeout:-1 tag:0];
    [newSocket readDataWithTimeout:-1 tag:0];
}

// 接收到了数据 自动回调
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"服务端--接收到数据");
    
    NSString *msgString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到%@发来的消息:%@", [sock connectedHost], msgString);

    NSString *serverString = @"服务器返回的消息";
    [sock writeData:[serverString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:5 tag:0];
   
    
    // 继续读取socket数据
    [sock readDataWithTimeout:-1 tag:0];
    
}



@end
