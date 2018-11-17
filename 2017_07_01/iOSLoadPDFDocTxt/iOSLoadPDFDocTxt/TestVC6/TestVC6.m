//
//  TestVC6.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC6.h"
#import "OpenRemoteFileViewController.h"


@interface TestVC6 ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC6

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

- (void)click:(UIButton *)sender
{
    OpenRemoteFileViewController *openRemoteFileVC =[[OpenRemoteFileViewController alloc]init];
//    openRemoteFileVC.fileURLString = @"http://weixintest.ihk.cn/ihkwx_upload/1.pdf";//网络资源URL
    
    
    openRemoteFileVC.fileURLString = @"http://172.16.20.198:8073/erp-next/Qulv.ERP.Web.FileCategory/2017/9/7/13/13/tmpEA16.docx";//网络资源URL

    
    [self.navigationController pushViewController:openRemoteFileVC animated:YES];
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
