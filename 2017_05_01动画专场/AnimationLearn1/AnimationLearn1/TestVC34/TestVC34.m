//
//  TestVC34.m
//  AnimationLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC34.h"
#import "QLOperationView.h"

@interface TestVC34 ()

@property (nonatomic, strong) QLOperationView *operationView;

@end

@implementation TestVC34

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
    [self.view addSubview:self.operationView];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (QLOperationView *)operationView
{
    if (_operationView == nil)
    {
        _operationView = [[QLOperationView alloc] initWithFrame:CGRectMake(0, kAllHeight - QLOperationViewHeight - kNavigationHeight - kStatusBarHeight, kScreenWidth, QLOperationViewHeight)];
        _operationView.backgroundColor = [UIColor yellowColor];
    }
    return _operationView;
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
