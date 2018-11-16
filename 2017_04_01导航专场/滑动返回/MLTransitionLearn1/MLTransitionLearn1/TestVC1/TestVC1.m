//
//  TestVC1.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "DetailVC1.h"

@interface TestVC1 ()

@property (nonatomic, strong) UIButton *btn1;

@end

@implementation TestVC1

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
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.btn1];
}


#pragma mark - 按钮响应事件

- (void)btn1Click:(UIButton *)sender
{
    DetailVC1 *detail = [[DetailVC1 alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)btn1
{
    if (_btn1 == nil)
    {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.backgroundColor = [UIColor yellowColor];
        _btn1.frame = CGRectMake(100, 100, 100, 40);
        [_btn1 setTitle:@"标题" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
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
