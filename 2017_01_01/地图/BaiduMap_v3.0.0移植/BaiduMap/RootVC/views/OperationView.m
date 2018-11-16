//
//  OperationView.m
//  BaiduMap
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "OperationView.h"

#define btnWidth ([UIScreen mainScreen].bounds.size.width / 4)

@interface OperationView ()

/// 开始定位
@property (nonatomic, strong) UIButton *startBtn;

/// 使用跟随
@property (nonatomic, strong) UIButton *followBtn;

/// 使用罗盘
@property (nonatomic, strong) UIButton *followHeadBtn;

/// 停止定位
@property (nonatomic, strong) UIButton *stopBtn;

@end

@implementation OperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)createUI
{
    [self addSubview:self.startBtn];
    [self addSubview:self.followBtn];
    self.followBtn.enabled = NO;
    
    [self addSubview:self.followHeadBtn];
    self.followHeadBtn.enabled = NO;

    
    [self addSubview:self.stopBtn];
    self.stopBtn.enabled = NO;


}

#pragma mark - 按钮响应事件

- (void)startBtnClick:(UIButton *)sender
{
    if (_startBtnCLickBlock)
    {
        _startBtnCLickBlock();
    }
    
    self.startBtn.enabled = NO;
    self.followBtn.enabled = YES;
    self.followHeadBtn.enabled = YES;
    self.stopBtn.enabled = YES;
}

- (void)followBtnClick:(UIButton *)sender
{
    if (_followBtnCLickBlock)
    {
        _followBtnCLickBlock();
    }
    
    self.startBtn.enabled = NO;
    self.followBtn.enabled = YES;
    self.followHeadBtn.enabled = YES;
    self.stopBtn.enabled = YES;

}

- (void)followHeadBtnClick:(UIButton *)sender
{
    if (_followHeadBtnCLickBlock)
    {
        _followHeadBtnCLickBlock();
    }
    
    self.startBtn.enabled = NO;
    self.followBtn.enabled = YES;
    self.followHeadBtn.enabled = YES;
    self.stopBtn.enabled = YES;

}

- (void)stopBtnClick:(UIButton *)sender
{
    if (_stopBtnCLickBlock)
    {
        _stopBtnCLickBlock();
    }
    
    self.startBtn.enabled = YES;
    self.followBtn.enabled = NO;
    self.followHeadBtn.enabled = NO;
    self.stopBtn.enabled = NO;

}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)startBtn
{
    if (_startBtn == nil)
    {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.backgroundColor = [UIColor yellowColor];
        _startBtn.frame = CGRectMake(0, 0, btnWidth, 40);
        [_startBtn setTitle:@"开始定位" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}


- (UIButton *)followBtn
{
    if (_followBtn == nil)
    {
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _followBtn.backgroundColor = [UIColor yellowColor];
        _followBtn.frame = CGRectMake(_startBtn.frame.origin.x + _startBtn.frame.size.width, 0, btnWidth, 40);
        [_followBtn setTitle:@"使用跟随" forState:UIControlStateNormal];
        [_followBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_followBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_followBtn addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIButton *)followHeadBtn
{
    if (_followHeadBtn == nil)
    {
        _followHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _followHeadBtn.backgroundColor = [UIColor yellowColor];
        _followHeadBtn.frame = CGRectMake(_followBtn.frame.origin.x + _followBtn.frame.size.width, 0, btnWidth, 40);
        [_followHeadBtn setTitle:@"使用罗盘" forState:UIControlStateNormal];
        [_followHeadBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_followHeadBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_followHeadBtn addTarget:self action:@selector(followHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followHeadBtn;
}

- (UIButton *)stopBtn
{
    if (_stopBtn == nil)
    {
        _stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopBtn.backgroundColor = [UIColor yellowColor];
        _stopBtn.frame = CGRectMake(_followHeadBtn.frame.origin.x + _followHeadBtn.frame.size.width, 0, btnWidth, 40);
        [_stopBtn setTitle:@"停止定位" forState:UIControlStateNormal];
        [_stopBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_stopBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];

        [_stopBtn addTarget:self action:@selector(stopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
