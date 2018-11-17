//
//  TestVC3.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC3.h"
#import "AsyncSocket.h"
#import "ServerEngine3.h"
#import "ClientEngine3.h"

@interface TestVC3 ()
{
    // 声明服务端
    AsyncSocket *_serverSocket;
    
    // 声明客户端
    AsyncSocket *_clientSocket1;
    
    // 声明客户端
    AsyncSocket *_clientSocket2;
}

@property (nonatomic, strong) UIButton *startServerBtn;
@property (nonatomic, strong) UIButton *startClientBtn;
@property (nonatomic, strong) UIButton *startClientBtn2;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *disConnectBtn;


@property (nonatomic, strong) ServerEngine3 *serverEngine;
@property (nonatomic, strong) ClientEngine3 *clientEngine1;
@property (nonatomic, strong) ClientEngine3 *clientEngine2;

@end

@implementation TestVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.startServerBtn];
    [self.view addSubview:self.startClientBtn];
    [self.view addSubview:self.startClientBtn2];
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.disConnectBtn];
}


#pragma mark - 按钮响应事件
- (void)startServerBtnClick:(UIButton *)sender
{
    if (_serverSocket == nil) {
        
        // 初始化代理
        _serverEngine = [[ServerEngine3 alloc] init];
        
        // 初始服务端socket
        _serverSocket = [[AsyncSocket alloc] initWithDelegate:_serverEngine];
        
        // 开始监听端口
        [_serverSocket acceptOnPort:0x1234 error:nil];
    }
}

- (void)startClientBtnClick:(UIButton *)sender
{
    // 初始化代理
    if (_clientSocket1 == nil) {
        _clientEngine1 = [[ClientEngine3 alloc]init];
        _clientSocket1 = [[AsyncSocket alloc] initWithDelegate:_clientEngine1];
        
        // 建立一个管道
        [_clientSocket1 connectToHost:@"192.168.105.28" onPort:0x1234 withTimeout:-1 error:nil];
    }
}

- (void)startClientBtn2Click:(UIButton *)sender
{
    // 初始化代理
    if (_clientSocket2 == nil) {
        _clientEngine2 = [[ClientEngine3 alloc]init];
        _clientSocket2 = [[AsyncSocket alloc] initWithDelegate:_clientEngine2];
        
        // 建立一个管道
        [_clientSocket2 connectToHost:@"192.168.105.28" onPort:0x1234 withTimeout:-1 error:nil];
    }
}


- (void)sendBtnClick:(UIButton *)sender
{
    NSString *msg = @"来自客户端的消息--自己";
    NSData *msgData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    // 开始发送数据
    // timeout一般都是系统中某次操作或内部请求长时间无应答而返回的信息
    [_clientSocket1 writeData:msgData withTimeout:5 tag:10];
}


- (void)sendToFirst:(UIButton *)sender
{
    // 这里的字符串已经包含了我们自己定义的协议
    NSString *msg = @"1&&发送给1个消息";
    
    
    NSData *msgData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    // 开始发送数据
    [_clientSocket1 writeData:msgData withTimeout:5 tag:10];
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)startServerBtn
{
    if (_startServerBtn == nil)
    {
        _startServerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startServerBtn.backgroundColor = [UIColor yellowColor];
        _startServerBtn.frame = CGRectMake(40, 100, 240, 40);
        [_startServerBtn setTitle:@"启动服务端" forState:UIControlStateNormal];
        [_startServerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startServerBtn addTarget:self action:@selector(startServerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startServerBtn;
}

- (UIButton *)startClientBtn
{
    if (_startClientBtn == nil)
    {
        _startClientBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startClientBtn.backgroundColor = [UIColor yellowColor];
        _startClientBtn.frame = CGRectMake(40, _startServerBtn.frame.origin.y + _startServerBtn.frame.size.height + 20, 240, 40);
        [_startClientBtn setTitle:@"启动客户端" forState:UIControlStateNormal];
        [_startClientBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startClientBtn addTarget:self action:@selector(startClientBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startClientBtn;
}

- (UIButton *)startClientBtn2
{
    if (_startClientBtn2 == nil)
    {
        _startClientBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _startClientBtn2.backgroundColor = [UIColor yellowColor];
        _startClientBtn2.frame = CGRectMake(40, _startClientBtn.frame.origin.y + _startClientBtn.frame.size.height + 20, 240, 40);
        [_startClientBtn2 setTitle:@"启动客户端2" forState:UIControlStateNormal];
        [_startClientBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startClientBtn2 addTarget:self action:@selector(startClientBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startClientBtn2;
}

- (UIButton *)sendBtn
{
    if (_sendBtn == nil)
    {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.backgroundColor = [UIColor yellowColor];
        _sendBtn.frame = CGRectMake(40, _startClientBtn2.frame.origin.y + _startClientBtn2.frame.size.height + 20, 240, 40);
        [_sendBtn setTitle:@"发送数据" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIButton *)disConnectBtn
{
    if (_disConnectBtn == nil)
    {
        _disConnectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _disConnectBtn.backgroundColor = [UIColor yellowColor];
        _disConnectBtn.frame = CGRectMake(40, _sendBtn.frame.origin.y + _sendBtn.frame.size.height + 20, 240, 40);
        [_disConnectBtn setTitle:@"2发给1" forState:UIControlStateNormal];
        [_disConnectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_disConnectBtn addTarget:self action:@selector(sendToFirst:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disConnectBtn;
}

@end
