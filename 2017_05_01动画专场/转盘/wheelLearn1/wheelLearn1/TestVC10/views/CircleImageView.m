//
//  CircleImageView.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/19.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "CircleImageView.h"

@interface CircleImageView ()

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CircleImageView

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
    [self addSubview:self.titleImageView];
    [self addSubview:self.titleLabel];
}


#pragma mark - 按钮响应事件

- (void)refreshCircleImageViewWithImage:(UIImage *)image text:(NSString *)text
{
    self.titleImageView.image = image;
    
    self.titleLabel.text = text;
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIImageView *)titleImageView
{
    if (_titleImageView == nil)
    {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, CircleImageViewHeight - 20)];
        _titleImageView.backgroundColor = [UIColor whiteColor];
    }
    return _titleImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleImageView.frame.origin.y + _titleImageView.frame.size.height, self.bounds.size.width, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
