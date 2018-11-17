//
//  ColorView.h
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const ColorViewHeight = 45.0;

@interface ColorView : UIView

@property (nonatomic, copy) void (^ selectColorBlock)(UIColor *color);

@end
