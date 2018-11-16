//
//  TestVC3.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/1.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC3.h"
#import "ScorePlateView.h"

@interface TestVC3 ()

@property (nonatomic, strong) ScorePlateView *scorePlateView;

@end

@implementation TestVC3

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
    [self.view addSubview:self.scorePlateView];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (ScorePlateView *)scorePlateView
{
    if (_scorePlateView == nil)
    {
        _scorePlateView = [[ScorePlateView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 300)];
        _scorePlateView.backgroundColor = [UIColor redColor];
    }
    return _scorePlateView;
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
