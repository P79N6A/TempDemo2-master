//
//  LKLotteryView.h
//  lottery
//
//  Created by upin on 13-3-6.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKLotteryView : UIView <CAAnimationDelegate>

- (instancetype)initWithDialPanel:(UIImage*)panel pointer:(UIImage*)pointer;
- (void)setDialPanel:(UIImage*)panel pointer:(UIImage*)pointer;

@property (nonatomic, strong) UIImageView *dialView;
@property (nonatomic, strong) UIImageView *pointerView;
@property (nonatomic, copy) void (^endEvent) (float angle);

- (void)start;
- (void)startDuration:(float)duration endAngle:(float)angle;


@end
