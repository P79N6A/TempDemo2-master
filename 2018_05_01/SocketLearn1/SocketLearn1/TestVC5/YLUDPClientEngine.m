//
//  YLUDPClientEngine.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "YLUDPClientEngine.h"
#import "AsyncUdpSocket.h"

@interface YLUDPClientEngine () <AsyncUdpSocketDelegate>

@end


@implementation YLUDPClientEngine

#pragma mark - AsyncUdpSocketDelegate

/**
 * 当数据被发送完毕调用
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"客户端 --  数据发送完毕");
}

/**
 * 数据发送失败时调用
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"客户端 --  数据发送失败");
}

/**
 * 收到数据时调用
 **/
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    NSLog(@"客户端 --  收到数据");
    return YES;
}

/**
 * 接收数据失败时调用
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error{
    NSLog(@"客户端 --  接收数据失败");
}

/**
 * 当socket关闭时调用
 **/
- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock{
    NSLog(@"客户端 --  socket被关闭");
}


@end
