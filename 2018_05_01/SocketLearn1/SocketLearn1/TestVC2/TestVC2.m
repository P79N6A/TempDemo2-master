//
//  TestVC2.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"
#import "AsyncSocket.h"
#import "ServerEngine2.h"
#import "ClientEngine2.h"

@interface TestVC2 ()
{
    //声明服务端
    AsyncSocket *_serverSocket;
    
    //声明客户端
    AsyncSocket *_clientSocket;
    
    
}

@property (nonatomic, strong) UIButton *startServerBtn;
@property (nonatomic, strong) UIButton *startClientBtn;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *disConnectBtn;


@property (nonatomic, strong) ServerEngine2 *serverEngine;
@property (nonatomic, strong) ClientEngine2 *clientEngine;


@end

@implementation TestVC2

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
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.disConnectBtn];
    
}


#pragma mark - 按钮响应事件

- (void)startServerBtnClick:(UIButton *)sender
{
    if (_serverSocket == nil) {
        
        //初始化代理
        _serverEngine = [[ServerEngine2 alloc]init];
        
        //初始服务端socket
        _serverSocket = [[AsyncSocket alloc]initWithDelegate:_serverEngine];
        
        //开始监听端口
        [_serverSocket acceptOnPort:0x1234 error:nil];
    }
}

- (void)startClientBtnClick:(UIButton *)sender
{
    // 初始化代理
    if (_clientSocket == nil) {
        _clientEngine = [[ClientEngine2 alloc]init];
        _clientSocket = [[AsyncSocket alloc]initWithDelegate:_clientEngine];
       
        // 建立一个管道
        [_clientSocket connectToHost:@"192.168.101.182" onPort:0x1234 withTimeout:-1 error:nil];
    }
}

- (void)sendBtnClick:(UIButton *)sender
{
    NSString *msgString = @"发送的消息，哈哈哈";
    NSData *msgData = [msgString dataUsingEncoding:NSUTF8StringEncoding];
    [_clientSocket writeData:msgData withTimeout:5 tag:1];
}


- (void)disConnectBtnClick:(UIButton *)sender
{
    [_clientSocket disconnect];
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

- (UIButton *)sendBtn
{
    if (_sendBtn == nil)
    {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.backgroundColor = [UIColor yellowColor];
        _sendBtn.frame = CGRectMake(40, _startClientBtn.frame.origin.y + _startClientBtn.frame.size.height + 20, 240, 40);
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
        [_disConnectBtn setTitle:@"断开连接" forState:UIControlStateNormal];
        [_disConnectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_disConnectBtn addTarget:self action:@selector(disConnectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disConnectBtn;
}








@end
