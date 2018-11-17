//
//  ColorView.m
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "ColorView.h"

#define kTag_13000 (13000)

@interface ColorView ()

@property (nonatomic, strong) NSMutableArray *colorArray;

@end

@implementation ColorView

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
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width / self.colorArray.count;
    for (NSInteger i = 0; i < self.colorArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = kTag_13000+i;
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, ColorViewHeight);
        btn.backgroundColor = self.colorArray[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark - setter, getter

- (NSMutableArray *)colorArray
{
    if (_colorArray == nil)
    {
        _colorArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 10; i++)
        {
            UIColor *color = [[UIColor alloc] initWithRed:arc4random_uniform(10) * .1 green:arc4random_uniform(10) * .1 blue:arc4random_uniform(10) * .1 alpha:1];
            [_colorArray addObject:color];
        }
    }
    return _colorArray;
}

#pragma mark - 按钮响应事件

- (void)btnClick:(UIButton *)sender
{
    NSInteger index = sender.tag-kTag_13000;
    NSLog(@"color\n%@", self.colorArray[index]);
    UIColor *color = self.colorArray[index];
    if (_selectColorBlock)
    {
        _selectColorBlock(color);
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
