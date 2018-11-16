//
//  RootViewController.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // iOS 7 以上自带右滑返回上一页面的功能。
    
#if 0
    // 这种隐藏方式，支持右滑动返回
    self.navigationController.navigationBar.hidden = YES;
#endif
    
    // 这种隐藏方式，不支持手势右滑动返回
    self.navigationController.navigationBarHidden = YES;
    
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.btn];
}


#pragma mark - 按钮响应事件

- (void)btnClick:(UIButton *)sender
{
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter


- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(40, 100, 240, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
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
