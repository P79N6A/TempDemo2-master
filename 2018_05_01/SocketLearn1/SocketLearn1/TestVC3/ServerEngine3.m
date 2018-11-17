//
//  ServerEngine3.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "ServerEngine3.h"
#import "AsyncSocket.h"

@interface ServerEngine3() <AsyncSocketDelegate>

@end

@implementation ServerEngine3 {
    NSMutableArray *_clientArray;
}


//当建立新的连接时，调用该方法
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket {
    NSLog(@"服务端 -- 有新的连接");
    
    if (_clientArray == nil) {
        //判断是否为空，为空的化初始化一个数组
        _clientArray = [NSMutableArray array];
    }
    [newSocket readDataWithTimeout:-1 tag:11];
    [_clientArray addObject:newSocket];
}

//当接收到数据时调用该函数
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //1&&发送给1个消息
    //先将原始信息解码，用自己定义的格式，得到一个数组
    NSArray *msgs = [msg componentsSeparatedByString:@"&&"];
    
    if ([msgs[0] isEqual:@"1"]) {
        // 判断发给谁
        // 在client的数组中找到对应的那个客户端
        AsyncSocket *client = _clientArray[0];
        
        // 将原来的消息，去除掉消息头，本例中消息头为“1&&”
        NSMutableData *replydata = [NSMutableData data];
        NSString *yldmsg = [msgs lastObject];
        [replydata appendData:[yldmsg  dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 服务器添加额外字段（qq等即时聊天工具不会添加）
        NSString *zjdmsg=@"我帮忙转发的，不客气";
        [replydata appendData:[zjdmsg dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 用上面找到的客户端socket发送消息
        [client writeData:replydata withTimeout:5 tag:11];
    }
    NSLog(@"服务端 -- 接收到数据 %@",msg);
    NSString *replyMsg = @"已收到，谢谢";
    NSData *replyData = [replyMsg dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:replyData withTimeout:5 tag:10];
    
    //让发送数据的socket继续等待接收数据
    [sock readDataWithTimeout:-1 tag:11];
}

// 当写入数据完成后，调用该方法
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"服务端 -- 写入数据完成");
}



@end
