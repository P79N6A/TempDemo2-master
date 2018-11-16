//
//  CircleImageView.h
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/19.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const CircleImageViewWidth = 120.0;
static CGFloat const CircleImageViewHeight = 140.0;

@interface CircleImageView : UIControl

- (void)refreshCircleImageViewWithImage:(UIImage *)image text:(NSString *)text;

@end
