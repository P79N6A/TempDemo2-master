//
//  QLPopView.h
//  趣旅网
//
//  Created by xiaoyulong on 16/5/27.
//  Copyright © 2016年 junjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLPopCell.h"

@interface QLPopView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPopViewFrame:(CGRect)popFrame;

@property (nonatomic, copy) void (^ selectPopItemAtIndexBlock)(NSInteger Index);
@property (nonatomic, copy) void (^ popViewDisappearBlock)();


/// 消失掉
- (void)makePopViewDisappear;

@end
