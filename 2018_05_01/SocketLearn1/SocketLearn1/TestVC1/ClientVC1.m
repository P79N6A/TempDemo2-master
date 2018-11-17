//
//  ClientVC.m
//  SocketDemo
//
//  Created by xiaoyulong on 2018/5/31.
//  Copyright © 2018年 dhf. All rights reserved.
//

#import "ClientVC1.h"
#import "AsyncSocket.h"

static const CGFloat btnHeight = 40.0;
static const CGFloat messageTextFieldHeight = 40.0;



@interface ClientVC1 () <UITableViewDelegate, UITableViewDataSource, AsyncSocketDelegate, UITextFieldDelegate>
{
    AsyncSocket *_serverSocket;
    AsyncSocket *_listenSocket;
    AsyncSocket *_clientSocket;
    
    NSMutableArray *_clientArray;
    UITextField *_messageTextField;
}

@property (nonatomic, strong) UITableView *clientTableView;


@end

@implementation ClientVC1

- (void)loadView {
    [super loadView];
    [self createUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 服务器socket
    _serverSocket = [[AsyncSocket alloc] init];
    _serverSocket.delegate = self;
   
    // 本身
    _listenSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_listenSocket acceptOnPort:0x1235 error:nil];
    
    // 点对点通讯时 对方的socket
    _clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.navigationItem.title = @"客户端";
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"连接",@"断开",@"在线用户", nil];

    for (NSInteger i = 0; i < [nameArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(10+70*i, 0, 80, btnHeight)];
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }

    _messageTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, btnHeight, kScreenWidth - 10 * 2, messageTextFieldHeight)];
    _messageTextField.placeholder = @"请输入消息";
    _messageTextField.delegate = self;
    _messageTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_messageTextField];

    
    [self.view addSubview:self.clientTableView];
}


#pragma mark - 按钮响应事件

- (void)buttonClicked:(UIButton*)button
{
    if (button.tag == 100) {
        // 连接服务器
        if (![_serverSocket isConnected]) {
            //[serverSocket disconnect];
            
            [_serverSocket connectToHost:@"192.168.105.113" onPort:0x1234 error:nil];
        } else{
            NSLog(@"已经和服务器连接");
        }
    } else if(button.tag == 101){
        // 断开与服务器连接
        [_serverSocket disconnect];
    } else if(button.tag == 102){
        // 获取在线用户
        NSString *message = @"GetClientList";
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        // 向服务器获取在线用户信息
        [_serverSocket writeData:data withTimeout:-1 tag:400];
    }
}


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - AsyncSocketDelegate

// 接收到了一个新的socket连接 自动回调
// 接收到了新的连接  那么释放老的连接
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    if (sock == _listenSocket) {
        NSLog(@"收到用户%@的连接请求",[newSocket connectedHost]);
        if (_clientSocket && [_clientSocket isConnected]) {
            [_clientSocket disconnect];
        }
        
        // 保存发起连接的客户端socket
        _clientSocket = newSocket;
    }
}

// 写数据成功 自动回调
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    // 获取用户列表
    if (sock == _serverSocket) {
        
        NSLog(@"向服务器%@发送消息成功",[sock connectedHost]);
    }
    // 客户端与客户端通讯
    else if(sock == _clientSocket){
        NSLog(@"向客户%@发送消息成功",[sock connectedHost]);
    }
    // 继续监听
    [sock readDataWithTimeout:-1 tag:500];
}

// 成功连接后自动回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [sock readDataWithTimeout:-1 tag:200];
    NSLog(@"已经连接到服务器:%@",host);
}

// 客户端接收到了数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    // 如果时服务器给的消息，必然是在线用户的消息
    if (sock == _serverSocket) {
        NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 将字符串以","分割 到数组中
        NSArray *array = [message componentsSeparatedByString:@","];
        
        [_clientArray removeAllObjects];
        [_clientArray addObjectsFromArray:array];
        
        [_clientTableView reloadData];
        
        NSLog(@"在线用户列表:%@", _clientArray);
    } else {
        // 点对点通讯
        NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"收到客户%@的消息:%@",[sock connectedHost], message);
    }
    
    // 继续监听
    [sock readDataWithTimeout:-1 tag:100];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// 发数据  结束编辑  就是键盘隐藏的时候  自动调用
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_clientSocket && [_clientSocket isConnected]) {
        
        NSData *data = [textField.text dataUsingEncoding:NSUTF8StringEncoding];
        
        // 向socket写数据
        [_clientSocket writeData:data withTimeout:-1 tag:100];
        //[serverSocket writeData:data withTimeout:-1 tag:200];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [_clientArray count];
    return 35;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"CellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    cell.textLabel.text = [_clientArray objectAtIndex:indexPath.row];
    
    return cell;
}

// 点击一行时   向该行对应的ip地址发起连接
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ip = [_clientArray objectAtIndex:indexPath.row];
    if (_clientSocket ) {
        
        if ([_clientSocket isConnected]) {
            [_clientSocket disconnect];
        }
        [_clientSocket connectToHost:ip onPort:0x1235 error:nil];
    }
}


#pragma mark - setter, getter

- (UITableView *)clientTableView
{
    if (_clientTableView == nil)
    {
        _clientTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, btnHeight + messageTextFieldHeight, kScreenWidth, kScreenHeight - kStatusBarAndNavBarHeight - btnHeight - messageTextFieldHeight) style:UITableViewStylePlain];
        _clientTableView.backgroundColor = [UIColor yellowColor];
        _clientTableView.delegate = self;
        _clientTableView.dataSource = self;
        _clientTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        if (@available(iOS 11.0, *)) {
            _clientTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _clientTableView;
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
