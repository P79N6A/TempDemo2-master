//
//  DetailVC.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    NSString *message = [[NSUserDefaults standardUserDefaults] objectForKey:kMessageStr];
    self.textView.text = message;
    
}


#pragma mark - 按钮响应事件

- (void)rightClick
{
    [[NSUserDefaults standardUserDefaults] setObject:self.textView.text forKey:kMessageStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter


- (UITextView *)textView
{
    if (_textView == nil)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 10 * 2, 200)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = UIColorHex(0x3e3e3e);
    }
    return _textView;
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
