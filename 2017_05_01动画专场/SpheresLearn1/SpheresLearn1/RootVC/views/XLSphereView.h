//
//  XLSphereView.h
//  SpheresLearn1
//
//  Created by xiaoyulong on 2017/6/2.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLSphereView : UIView

@property(nonatomic, assign) BOOL isTimerStart;

- (void)setItems:(NSArray *)items;

- (void)timerStart;

- (void)timerStop;

@end
