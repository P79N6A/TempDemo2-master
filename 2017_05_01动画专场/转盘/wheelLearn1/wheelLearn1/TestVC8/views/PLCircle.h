//
//  PLCircle.h
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 常说的“内径”,是指管型材料的内圆的直径。 “外径”,是指圆形材料最外边圆的直径。

// 黑色的圆环的外径
#define PL_SLIDER_BG_LINE_WIDTH (30)


#define PL_SLIDER_LINE_WIDTH (20)

#define PL_SLIDER_WIDTH (250)


@interface PLCircle : UIControl

@property (nonatomic, assign) CGFloat angle;

@end
