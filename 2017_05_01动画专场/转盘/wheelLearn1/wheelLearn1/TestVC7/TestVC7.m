//
//  TestVC7.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC7.h"
#import "LKLotteryView.h"

@interface TestVC7 ()

@property (nonatomic, strong) LKLotteryView *lotteryView;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC7

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
    [self.view addSubview:self.lotteryView];
    [self.view addSubview:self.btn];
    
    
    [self.lotteryView setDialPanel:[UIImage imageNamed:@"dial_panel"] pointer:[UIImage imageNamed:@"dialplate"]];
    self.lotteryView.endEvent = ^(float angle){
//        self.lb_angle.text
        NSString *angleStr = [NSString stringWithFormat:@"停止的角度: %f",(angle/M_PI) *180];
        NSLog(@"angleStr==%@", angleStr);
        
    };
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (LKLotteryView *)lotteryView
{
    if (_lotteryView == nil)
    {
        _lotteryView = [[LKLotteryView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _lotteryView.backgroundColor = [UIColor yellowColor];
    }
    return _lotteryView;
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(40, _lotteryView.frame.origin.y + _lotteryView.frame.size.height + 30, 240, 40);
        [_btn setTitle:@"开始转动" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick:(UIButton *)sender
{
    [self.lotteryView start];
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
