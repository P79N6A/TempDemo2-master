//
//  TestVC1.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/5/31.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "YLWheelView.h"

@interface TestVC1 ()

@property (nonatomic, strong) YLWheelView *wheelView;

@end

@implementation TestVC1

- (void)dealloc
{
    NSLog(@"%@ dealloc...", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.wheelView];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (YLWheelView *)wheelView
{
    if (_wheelView == nil)
    {
        _wheelView = [[YLWheelView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 300) / 2, 60, 300, 300)];
        _wheelView.backgroundColor = [UIColor yellowColor];
    }
    return _wheelView;
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
