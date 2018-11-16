//
//  DetailVC.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC.h"
#import "MLTransition.h"

@interface DetailVC ()

@property (nonatomic, strong) UIButton *btn1;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"详情Detail";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 针对这个导航栏打开
    [self.navigationController enabledMLTransition:YES];
    
}


#pragma mark - 创建UI


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
