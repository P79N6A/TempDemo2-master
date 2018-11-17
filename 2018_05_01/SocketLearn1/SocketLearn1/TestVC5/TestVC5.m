//
//  TestVC5.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC5.h"
#import "AsyncUdpSocket.h"
#import "YLUDPServerEngine.h"
#import "YLUDPClientEngine.h"

@interface TestVC5 ()

@property (nonatomic, strong) UIButton *startServerBtn;
@property (nonatomic, strong) UIButton *startClientBtn;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *disConnectBtn;

// 声明服务端
@property (nonatomic, strong) AsyncUdpSocket *serverSocket;

// 声明客户端
@property (nonatomic, strong) AsyncUdpSocket *clientSocket;

// 声明服务端代理
@property (nonatomic, strong) YLUDPServerEngine *udpServerEngine;

// 声明客户端代理
@property (nonatomic, strong) YLUDPClientEngine *udpClientEngine;


@end

@implementation TestVC5

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
    _udpServerEngine = [[YLUDPServerEngine alloc]init];
    
    // 实例化udpstocket
    _serverSocket = [[AsyncUdpSocket alloc] initWithDelegate:_udpServerEngine];

    // 绑定端口
    [_serverSocket bindToPort:0x1234 error:nil];
   
    // 开始监听数据
    [_serverSocket receiveWithTimeout:-1 tag:10];
}

- (void)startClientBtnClick:(UIButton *)sender
{
    // 实例化客户端代理
    _udpClientEngine = [[YLUDPClientEngine alloc] init];
    
    // 实例化客户端
    _clientSocket = [[AsyncUdpSocket alloc] initWithDelegate:_udpServerEngine];
}

- (void)sendBtnClick:(UIButton *)sender
{
    //建立要发送的数据data
    NSString *string = @"我是客户端 来自自己电脑";
    NSData *sendData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [_clientSocket sendData:sendData toHost:@"192.168.105.28" port:0x1234 withTimeout:5 tag:11];
}


//断开服务端
- (void)disConnectBtnClick:(UIButton *)sender
{
// if (serverSocket.isConnected) {//判断是否正在连接中
    [_serverSocket close];
// }
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
