//
//  YLCollectionViewCell.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 16/9/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "YLCollectionViewCell.h"
#import "PICircularProgressView.h"
#import "DayModel.h"

@interface YLCollectionViewCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) PICircularProgressView *circularProgressView;

@end

@implementation YLCollectionViewCell

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
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.circularProgressView];
}


#pragma mark - 按钮响应事件

- (void)threeTapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"CelltapAction");
    if (_tapActionBlock)
    {
        _tapActionBlock();
    }
}

- (void)fourTapAction:(UITapGestureRecognizer *)fourTap
{
    if (_fourTapActionBlock)
    {
        _fourTapActionBlock();
    }
}

//- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
//{
//    if (_longPressActionBlock) {
//        _longPressActionBlock();
//    }
//}

- (void)refreshYLCollectionViewCellWith:(DayModel *)dayModel
{
    self.dateLabel.text = [NSString stringWithFormat:@"%@", dayModel.dayStr];
    
    if (dayModel.dayStyleType == DayStyleSuccess)
    {
        // 已经成功
        self.bgImageView.hidden = NO;
        
        self.circularProgressView.hidden = YES;
        
    }
    else if (dayModel.dayStyleType == DayStyleGoing)
    {
        // 正在进行
        self.bgImageView.hidden = NO;
        
        self.circularProgressView.hidden = NO;
        self.circularProgressView.progress = 1.0 - dayModel.progress;
        NSLog(@"dayModel.progress==%f", dayModel.progress);
    }
    else if (dayModel.dayStyleType == DayStyleFail)
    {
        // 没有覆盖的地方
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.bgImageView.hidden = YES;
        
        self.circularProgressView.hidden = YES;
    }
}



#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIImageView *)bgImageView
{
    if (_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.image = [UIImage imageNamed:@"NationalEmblem"];
        _bgImageView.layer.cornerRadius = self.bounds.size.width / 2;
        _bgImageView.layer.masksToBounds = YES;

    }
    return _bgImageView;
}

- (UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.layer.cornerRadius = self.bounds.size.width / 2;
        _dateLabel.layer.masksToBounds = YES;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont boldSystemFontOfSize:14];
        _dateLabel.textColor = UIColorHex(0x3e3e3e);
        _dateLabel.userInteractionEnabled = YES;
        
    
    }
    return _dateLabel;
}

- (PICircularProgressView *)circularProgressView
{
    if (_circularProgressView == nil)
    {
        _circularProgressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _circularProgressView.userInteractionEnabled = YES;
        _circularProgressView.backgroundColor = [UIColor clearColor];
        
        // 进度 0~1
        _circularProgressView.progress = 0.85;
        
        /*
         0~1
         */
        _circularProgressView.thicknessRatio = 0.95;
        _circularProgressView.showText = NO;
        _circularProgressView.showShadow  = NO;
        
        
        _circularProgressView.outerBackgroundColor = [UIColor clearColor];
        _circularProgressView.innerBackgroundColor = [UIColor clearColor];
        
        _circularProgressView.roundedHead = NO;
        
        
        // 圆环进度颜色
        _circularProgressView.progressFillColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        // 环 中心字体颜色
        _circularProgressView.textColor = UIColorRGB(27, 159, 175);
        
        
        UITapGestureRecognizer *threeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(threeTapAction:)];
        threeTap.numberOfTapsRequired = 3;
        threeTap.numberOfTouchesRequired = 1;
        [_circularProgressView addGestureRecognizer:threeTap];
        
        
        UITapGestureRecognizer *fourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourTapAction:)];
        fourTap.numberOfTapsRequired = 4;
        fourTap.numberOfTouchesRequired = 1;
        [_circularProgressView addGestureRecognizer:fourTap];
        
        [threeTap requireGestureRecognizerToFail:fourTap];

        
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//        longPress.numberOfTapsRequired = 1;
//        longPress.numberOfTouchesRequired = 1;
//        longPress.minimumPressDuration = 1.5;
//        [_circularProgressView addGestureRecognizer:longPress];
        
        
//        [tap requireGestureRecognizerToFail:longPress];
    }
    return _circularProgressView;
}

@end
