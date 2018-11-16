//
//  PlayerView.m
//  StreamingMedia
//
//  Created by xiaoyulong on 16/3/14.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()

@property (nonatomic, strong) UIView *ctlView;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;

@property (nonatomic, strong) UISlider *progressSlider;

@end

@implementation PlayerView

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
    [self addSubview:self.ctlView];
    [self addSubview:self.playBtn];
    [self.ctlView addSubview:self.currentTimeLabel];
    [self.ctlView addSubview:self.totalTimeLabel];
    [self.ctlView addSubview:self.progressSlider];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _playBtn.frame = CGRectMake((self.bounds.size.width - 80) / 2, (self.bounds.size.height-40) / 2, 80, 30);
    _ctlView.frame = CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40);

    _currentTimeLabel.frame = CGRectMake(0, 0, 60, _ctlView.bounds.size.height);
    _totalTimeLabel.frame = CGRectMake(self.bounds.size.width - 60, 0, 60, _ctlView.bounds.size.height);
    _progressSlider.frame = CGRectMake(_currentTimeLabel.frame.origin.x + _currentTimeLabel.frame.size.width, (_ctlView.bounds.size.height - 20) /2, _ctlView.bounds.size.width - (_currentTimeLabel.frame.origin.x + _currentTimeLabel.frame.size.width) - _totalTimeLabel.frame.size.width, 20);

}

#pragma mark - 按钮响应事件

- (void)playBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    BOOL startPlay = NO;
    if (sender.selected)
    {
        startPlay = YES;
    }
    else
    {
        startPlay = NO;
    }
    
    if (_playBtnCLickBlock)
    {
        _playBtnCLickBlock(startPlay);
    }
}

- (void)valueChange:(UISlider *)sender
{
    if (_sliderValueBlock)
    {
        _sliderValueBlock(sender.value);
    }
}

- (void)refreshPlayerViewWithCurrentTime:(long long)second TotalTime:(long long)totalSecond
{
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",second/60,second%60];
    _progressSlider.value = second;

    _progressSlider.minimumValue = 0;
    _progressSlider.maximumValue = totalSecond;
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",totalSecond/60,totalSecond%60];
}

- (void)hideCtlView
{
    self.ctlView.alpha = 0;
    self.playBtn.alpha = 0;
}

- (void)showCtlView
{
    self.ctlView.alpha = 1;
    self.playBtn.alpha = 1;
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

// layer是UIView的底层 opengl 定制动画等等
+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (void)setXyPlayer:(AVPlayer *)xyPlayer
{
    //获取当前UIView 的layer，同时将播放器添加到layer上
    AVPlayerLayer *layer = (AVPlayerLayer *)[self layer]; //当前UIView 的layer
    layer.player = xyPlayer;
}

- (AVPlayer *)xyPlayer
{
    AVPlayerLayer *layer = (AVPlayerLayer *)[self layer]; //当前UIView 的layer
    return layer.player;
}

- (UIButton *)playBtn
{
    if (_playBtn == nil)
    {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.backgroundColor = [UIColor yellowColor];
        _playBtn.frame = CGRectMake((self.bounds.size.width - 80) / 2, (self.bounds.size.height-40) / 2, 80, 30);
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitle:@"暂停" forState:UIControlStateSelected];
        [_playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIView *)ctlView
{
    if (_ctlView == nil)
    {
        _ctlView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
        _ctlView.backgroundColor = [UIColor whiteColor];
    }
    return _ctlView;
}

- (UILabel *)currentTimeLabel
{
    if (_currentTimeLabel == nil)
    {
        _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _ctlView.bounds.size.height)];
        _currentTimeLabel.backgroundColor = [UIColor yellowColor];
        _currentTimeLabel.textColor = [UIColor blackColor];
        _currentTimeLabel.textAlignment = NSTextAlignmentLeft;
        _currentTimeLabel.text = @"00:00";
    }
    return _currentTimeLabel;
}

- (UILabel *)totalTimeLabel
{
    if (_totalTimeLabel == nil)
    {
        _totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60, 0, 60, _ctlView.bounds.size.height)];
        _totalTimeLabel.backgroundColor = [UIColor yellowColor];
        _totalTimeLabel.textColor = [UIColor blackColor];
        _totalTimeLabel.textAlignment = NSTextAlignmentRight;
        _totalTimeLabel.text = @"00:00";
    }
    return _totalTimeLabel;
}

- (UISlider *)progressSlider
{
    if (_progressSlider == nil)
    {
        _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(_currentTimeLabel.frame.origin.x + _currentTimeLabel.frame.size.width, (_ctlView.bounds.size.height - 20) /2, _ctlView.bounds.size.width - (_currentTimeLabel.frame.origin.x + _currentTimeLabel.frame.size.width) - _totalTimeLabel.frame.size.width, 20)];
        _progressSlider.minimumTrackTintColor = [UIColor redColor];
        [_progressSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];

    }
    return _progressSlider;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
