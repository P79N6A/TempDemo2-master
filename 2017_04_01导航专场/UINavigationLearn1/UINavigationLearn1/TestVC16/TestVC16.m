//
//  TestVC16.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC16.h"

@interface TestVC16 ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC16

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.btn];

    // 修改导航栏返回按钮字体位置
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(10, 0) forBarMetrics:UIBarMetricsDefault];
    
    
    // 现实中我们自定义按钮就行了。
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(100, 100, 100, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)click:(UIButton *)sender
{
    UIViewController *detail = [[UIViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
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
