//
//  YLUDPServerEngine.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "YLUDPServerEngine.h"
#import "AsyncUdpSocket.h"

@interface YLUDPServerEngine () <AsyncUdpSocketDelegate>

@end

@implementation YLUDPServerEngine

#pragma mark - AsyncUdpSocketDelegate

/**
 * 当数据被发送完毕调用
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"服务端 --  数据发送完毕");
}

/**
 * 数据发送失败时调用
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"服务端 --  数据发送失败");
}

/**
 * 收到数据时调用
 **/
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
    
    NSLog(@"服务端--接收到数据--来自%@:%hu  tag:%ld",host,port,tag);

    // 将接收到的data转化成字符串
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"服务端 --  收到数据  %@",msg);
    

    
    
    //默认收到一次就断开，如果想让一直监听，就在下面让它继续监听
//    [sock receiveWithTimeout:-1 tag:0];

    
    [sock receiveWithTimeout:-1 tag:10];
    return YES;
}

/**
 * 接收数据失败时调用
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"服务端 --  接收数据失败");
}

/**
 * 当socket关闭时调用
 **/
- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock {
    NSLog(@"服务端 --  socket被关闭");
}


@end
