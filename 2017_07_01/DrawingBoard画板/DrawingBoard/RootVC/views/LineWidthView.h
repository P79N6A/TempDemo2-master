//
//  LineWidthView.h
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const LineWidthViewHeight = 45.0;

@interface LineWidthView : UIView

@property (nonatomic, copy) void (^ selectLineWidthBlock)(CGFloat width);

@end
