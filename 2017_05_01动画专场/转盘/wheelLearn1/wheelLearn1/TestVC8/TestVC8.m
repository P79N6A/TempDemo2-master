//
//  TestVC8.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC8.h"
#import "PLCircle.h"

@interface TestVC8 ()

@property (nonatomic, strong) PLCircle *pLCircle;

@end

@implementation TestVC8

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
    [self.view addSubview:self.pLCircle];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (PLCircle *)pLCircle
{
    if (_pLCircle == nil)
    {
        _pLCircle = [[PLCircle alloc] initWithFrame:CGRectMake(10, 80, PL_SLIDER_WIDTH, PL_SLIDER_WIDTH)];
        _pLCircle.backgroundColor = [UIColor whiteColor];
    }
    return _pLCircle;
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
