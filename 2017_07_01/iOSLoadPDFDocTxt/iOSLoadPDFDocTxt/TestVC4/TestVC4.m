//
//  TestVC4.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"
#import "QuickLookViewController.h"

@interface TestVC4 ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC4

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
    [self.view addSubview:self.btn];
}

#pragma mark - 按钮响应事件

- (void)click:(UIButton *)sender
{
    QuickLookViewController *controller = [[QuickLookViewController alloc] init];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"pdf"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1234" ofType:@"pdf"];

    controller.fileURL = [NSURL fileURLWithPath:filePath];
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
        _btn.frame = CGRectMake(100, 100, 100, 40);
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
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
