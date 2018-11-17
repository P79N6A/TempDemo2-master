//
//  TopView.h
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const TopViewHeight = 80.0;
static CGFloat const btnHeight = 35.0;

@interface TopView : UIView

@property (nonatomic, strong) void (^ topCLickBlock)(NSInteger index);

@end
