//
//  TestVC4.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/6/1.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"
#import "AsyncUdpSocket.h"
#import "BuddleCell.h"
#import "ChatInputView.h"

@interface TestVC4 () <UITextViewDelegate,AsyncUdpSocketDelegate,UITableViewDelegate,UITableViewDataSource>
{
    ChatInputView * _inputView;
    // 输入框的左下角 固定
    CGFloat inputView_y;
    
    AsyncUdpSocket * _recvAsyncUdpSocket;
    AsyncUdpSocket * _sendAsyncUdpSocket;
    UITextField * _ipField;
    
    UITableView * _tableView;
    NSMutableArray * _chatArr;
}
@end

@implementation TestVC4

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [self.view addGestureRecognizer:tap];
    
    
    _chatArr = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 320, 480-30-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 监听键盘高度
    // 当系统键盘即将显示时 调用当前对象的keyboardWillShow：方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    _inputView = [[ChatInputView alloc] initWithFrame:CGRectMake(0, 480-44, 320, 44)];
    _inputView.inputView.delegate = self;
    [_inputView.sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_inputView];
    
    _ipField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, 320, 30)];
    _ipField.text = @"192.168.105.113";
    _ipField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_ipField];
    
    // 套接字对象创建
    [self creatSocket];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 创建UI

- (void)createUI
{
    
}

- (void)creatSocket
{
    // MARK: Socket 接受端口
    _recvAsyncUdpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    // 绑定端口 5000+
    [_recvAsyncUdpSocket bindToPort:0x1234 error:nil];
    
    // 开始监听 -1死等
    [_recvAsyncUdpSocket receiveWithTimeout:-1 tag:100];
    
    
    // MARK: Socket 发送端口
    _sendAsyncUdpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [_sendAsyncUdpSocket bindToPort:0x4321 error:nil];
}

#pragma mark - 按钮响应事件

- (void)send
{
    // 取聊天内容 添加到数组 刷新表格
    if (_inputView.inputView.text.length == 0) {
        return;
    }
    
    // MARK: 向接受端口发送消息
    // 发送 端口写接受方端口
    [_sendAsyncUdpSocket sendData:[_inputView.inputView.text dataUsingEncoding:NSUTF8StringEncoding] toHost:_ipField.text port:0x1234 withTimeout:-1 tag:200];
    
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    NSValue * value = [[note userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect = value.CGRectValue;
    CGRect oldRect = _inputView.frame;
    oldRect.origin.y = rect.origin.y-oldRect.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    _inputView.frame = oldRect;
    [UIView commitAnimations];
    
    inputView_y = rect.origin.y;
}

- (void)keyboardWillHidden:(NSNotification *)note
{
    CGRect rect = [[[note userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect oldRect = _inputView.frame;
    oldRect.origin.y = rect.origin.y-oldRect.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    _inputView.frame = oldRect;
    [UIView commitAnimations];
}

- (void)myTap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}


#pragma mark - 网络请求


#pragma mark - 代理方法
#pragma mark - AsyncUdpSocketDelegate
// 套接字对象接受到了数据 调用
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"IP：%@ 端口:%d 说:%@",host,port,str);
    
    // 继续监听
    [_recvAsyncUdpSocket receiveWithTimeout:-1 tag:100];
    // 别人说
    NSDictionary * dic = [NSDictionary dictionaryWithObject:str forKey:@"HE"];
    [_chatArr addObject:dic];
    [self scrollToEnd];
    
    return YES;
}

- (void)scrollToEnd
{
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

// 数据发送成功 调用
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"tag %ld send success!",tag);
    NSDictionary * dic = [NSDictionary dictionaryWithObject:_inputView.inputView.text forKey:@"ME"];
    [_chatArr addObject:dic];
    [self scrollToEnd];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    BuddleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BuddleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor colorWithRed:211/255.0 green:219/255.0 blue:232/255.0 alpha:1.0];
    }
    //    cell.textLabel.numberOfLines = 0;
    //    cell.textLabel.text = _chatArr[indexPath.row];
    NSDictionary * dic = _chatArr[indexPath.row];
    if ([dic.allKeys[0] isEqualToString:@"ME"]) {
        cell.qfWho = YES;
        cell.qfChatStr = dic.allValues[0];
    }else{
        cell.qfWho = NO;
        cell.qfChatStr = dic.allValues[0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = _chatArr[indexPath.row];
    CGSize size = [dic.allValues[0] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(280, 2000)];
    // cell的高度略高于label的高度
    return size.height+20;
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 判断回车
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    // 计算完全显示字符的尺寸 设置控件的frame
    CGSize size = [textView.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(240, 100)];
    CGRect rect;
    rect.origin.x = 0;
    CGFloat tempHeight = size.height;
    // 保证用户体验度 高度不能少于36
    if (tempHeight < 36) {
        tempHeight = 36;
    }
    rect.origin.y = inputView_y-tempHeight-8;
    rect.size.width = 320;
    rect.size.height = tempHeight+8;
    // 子视图中开启停靠模式
    _inputView.frame = rect;
}

#pragma mark - setter, getter


@end
