//
//  TestVC1.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/5/31.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "ServerVC1.h"
#import "ClientVC1.h"

@interface TestVC1 ()

@property (nonatomic, strong) UIButton *serverBtn;
@property (nonatomic, strong) UIButton *clientBtn;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.serverBtn];
    [self.view addSubview:self.clientBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)serverBtn
{
    if (_serverBtn == nil)
    {
        _serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _serverBtn.backgroundColor = [UIColor yellowColor];
        _serverBtn.frame = CGRectMake(40, 100, 240, 40);
        [_serverBtn setTitle:@"服务端" forState:UIControlStateNormal];
        [_serverBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_serverBtn addTarget:self action:@selector(serverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serverBtn;
}

- (UIButton *)clientBtn
{
    if (_clientBtn == nil)
    {
        _clientBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clientBtn.backgroundColor = [UIColor yellowColor];
        _clientBtn.frame = CGRectMake(40, 160, 240, 40);
        [_clientBtn setTitle:@"客户端" forState:UIControlStateNormal];
        [_clientBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clientBtn addTarget:self action:@selector(clientBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clientBtn;
}

- (void)serverBtnClick:(UIButton *)sender
{
    // 服务端
    ServerVC1 *controller = [[ServerVC1 alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clientBtnClick:(UIButton *)sender
{
    // 客户端
    ClientVC1 *controller = [[ClientVC1 alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}



@end
