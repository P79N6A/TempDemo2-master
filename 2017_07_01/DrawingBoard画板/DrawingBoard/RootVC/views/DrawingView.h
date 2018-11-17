//
//  DrawingView.h
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 从手指触摸屏幕到手指离开屏幕  就是当前线条
 
 重新触摸就是另外一根线条；
 
 */

@interface DrawingView : UIView

/// 当前线条的颜色
@property (nonatomic, strong) UIColor *curLineColor;

/// 当前线条的宽度
@property (nonatomic, assign) CGFloat curLineWidth;

/// 橡皮擦
- (void)rubberLine;

/// 撤销
- (void)revoke;

/// 清楚屏幕上所有的线条
- (void)clearScreen;

@end
