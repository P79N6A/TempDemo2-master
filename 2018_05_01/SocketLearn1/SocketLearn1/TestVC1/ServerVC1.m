//
//  ServerVC.m
//  SocketDemo
//
//  Created by xiaoyulong on 2018/5/31.
//  Copyright © 2018年 dhf. All rights reserved.
//

#import "ServerVC1.h"
#import "AsyncSocket.h"

@interface ServerVC1 () <UITableViewDelegate, UITableViewDataSource, AsyncSocketDelegate>
{
    AsyncSocket *_serverSocket;

}
@property (nonatomic, strong) UITableView *serverTableView;
@property (nonatomic, strong) NSMutableArray *socketArray;

@end

@implementation ServerVC1

- (void)loadView {
    [super loadView];
    [self createUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    self.navigationItem.title = @"服务端";
    [self.view addSubview:self.serverTableView];
    
    _socketArray = [[NSMutableArray alloc] init];
    
    
    // 服务器socket实例化  在0x1234端口监听数据
    _serverSocket = [[AsyncSocket alloc] init];
    _serverSocket.delegate = self;
    NSError *error = nil;
    [_serverSocket acceptOnPort:0x1234 error:&error];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - AsyncSocketDelegate
// 有新的socket向服务器链接自动回调
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    [_socketArray addObject:newSocket];
    [_serverTableView reloadData];
    
    // 如果下面的方法不写 只能接收一次socket链接
    [newSocket readDataWithTimeout:-1 tag:100];
}

// 网络连接成功后  自动回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"已连接到用户:ip:%@",host);
}

// 接收到了数据 自动回调
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到%@发来的消息:%@", [sock connectedHost], message);
    
    // 相当与向服务起索取  在线用户数据
    // 将连上服务器的所有ip地址 组成一个字符串 将字符串回写到客户端
    if ([message isEqualToString:@"GetClientList"]) {
        NSMutableString *clientList = [[NSMutableString alloc] initWithCapacity:0];
        int i = 0;
        for (AsyncSocket *newSocket in _socketArray) {
            // 以字符串形式分割ip地址  192..,192...,
            if (i!=0) {
                [clientList appendFormat:@",%@",[newSocket connectedHost]];
            }
            else{
                [clientList appendFormat:@"%@",[newSocket connectedHost]];
            }
            i++;
        }
        NSData *newData = [clientList dataUsingEncoding:NSUTF8StringEncoding];
        // 将在线的所有用户  以字符串的形式一次性发给客户端
        [sock writeData:newData withTimeout:-1 tag:300];
        
    } else{
        
        // 将数据回写给发送数据的用户
        NSLog(@"debug >>>> %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        [sock writeData:data withTimeout:-1 tag:300];
    }
    
    // 继续读取socket数据
    [sock readDataWithTimeout:-1 tag:200];
}


// 连接断开时  服务器自动回调
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    [_socketArray removeObject:sock];
    
    [_serverTableView reloadData];
}

// 向用户发出的消息  自动回调
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"向用户%@发出消息",[sock connectedHost]);
}



#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _socketArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row < _socketArray.count) {
        AsyncSocket *socket = [_socketArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"用户:%@",[socket connectedHost]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - setter, getter

- (UITableView *)serverTableView
{
    if (_serverTableView == nil)
    {
        _serverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarAndNavBarHeight) style:UITableViewStylePlain];
        _serverTableView.delegate = self;
        _serverTableView.dataSource = self;
        _serverTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _serverTableView;
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
