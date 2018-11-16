//
//  RippleView.h
//  Animation
//
//  Created by yulong on 15/1/12.
//  Copyright (c) 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const RippleViewHeight = 35.0;

@interface RippleView : UIView

@property (nonatomic, copy) void (^ rippleBlock)();

@end
