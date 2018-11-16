//
//  TransferView.h
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TransferView : CALayer

@property (nonatomic, assign) BOOL roundTwo;


@property (nonatomic, assign) CGFloat progress;

- (void)startCheck;
- (void)animateCircle;

@end
