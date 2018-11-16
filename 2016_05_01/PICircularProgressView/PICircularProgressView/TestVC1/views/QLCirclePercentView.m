//
//  QLCirclePercentView.m
//  PICircularProgressView
//
//  Created by xiaoyulong on 2017/8/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "QLCirclePercentView.h"
#import "PICircularProgressView.h"

@interface QLCirclePercentView ()

@property (nonatomic, strong) PICircularProgressView *circularProgressView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *percentLabel;

@end

@implementation QLCirclePercentView

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
    [self addSubview:self.circularProgressView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.percentLabel];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (PICircularProgressView *)circularProgressView
{
    if (_circularProgressView == nil)
    {
        _circularProgressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _circularProgressView.backgroundColor = [UIColor clearColor];
        //        _circularProgressView.frame = CGRectMake(0, 0, 90, 90);
        //        _circularProgressView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 120);
        /*
         0~1
         */
        _circularProgressView.progress = 0.4;
        
        // 0~1
        _circularProgressView.thicknessRatio = 0.3;
        _circularProgressView.showText = NO;
        _circularProgressView.showShadow  = NO;
        
        
        
        _circularProgressView.outerBackgroundColor = [UIColor whiteColor];
        
        _circularProgressView.innerBackgroundColor = UIColorRGB(61, 157, 234);
        _circularProgressView.roundedHead = YES;
        
        
        // 圆环进度颜色
        _circularProgressView.progressFillColor = UIColorRGB(25, 135, 233);
        
        
        // 环 中心字体颜色
        _circularProgressView.textColor = UIColorRGB(27, 159, 175);
    }
    return _circularProgressView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, self.bounds.size.width, 13)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"已抢";
    }
    return _titleLabel;
}

- (UILabel *)percentLabel
{
    if (_percentLabel == nil)
    {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, self.bounds.size.width, 13)];
        _percentLabel.backgroundColor = [UIColor clearColor];
        _percentLabel.font = [UIFont systemFontOfSize:10];
        
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.textColor = [UIColor whiteColor];
        _percentLabel.text = @"96%";
    }
    return _percentLabel;
}


- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    self.circularProgressView.progress = percent;
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%@", _percent * 100.0, @"%"];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
