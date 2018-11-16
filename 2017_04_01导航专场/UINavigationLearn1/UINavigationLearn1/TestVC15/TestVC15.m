//
//  TestVC15.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC15.h"
#import "UINavigationItem+correct_offset.h"

@interface TestVC15 ()

@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation TestVC15

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
    [self.navigationItem addLeftBarButtonItem:left];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    
}


#pragma mark - 按钮响应事件

- (void)btnClick:(UIButton *)sender
{
    
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)editBtn
{
    if (_editBtn == nil)
    {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.backgroundColor = [UIColor yellowColor];
        _editBtn.frame = CGRectMake(0, 0, 40, 40);
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
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
