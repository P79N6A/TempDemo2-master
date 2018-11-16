//
//  PlayerView.h
//  StreamingMedia
//
//  Created by xiaoyulong on 16/3/14.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


static CGFloat const PlayerViewHeight = 180.0;

@interface PlayerView : UIView

@property (nonatomic, strong) UIButton *playBtn;
- (void)playBtnClick:(UIButton *)sender;

@property (nonatomic, strong) AVPlayer *xyPlayer;
@property (nonatomic, copy) void (^ playBtnCLickBlock)(BOOL startPlay);
@property (nonatomic, copy) void (^ sliderValueBlock)(CGFloat value);

- (void)refreshPlayerViewWithCurrentTime:(long long)second TotalTime:(long long)totalSecond;

- (void)hideCtlView;
- (void)showCtlView;

@end
