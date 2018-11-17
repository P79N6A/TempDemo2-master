//
//  TopView.m
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TopView.h"
#define kTag_12000 (12000)

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)setUI
{
    NSArray *titleArr = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏"];
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width / titleArr.count;
    for (NSInteger i = 0; i < titleArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = kTag_12000+i;
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, btnHeight);
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.layer.cornerRadius = 4.0;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
}

#pragma mark - setter, getter


#pragma mark - 按钮响应事件

- (void)btnCLick:(UIButton *)sender
{
    NSInteger index = sender.tag-kTag_12000;
    if (_topCLickBlock)
    {
        _topCLickBlock(index);
    }
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
