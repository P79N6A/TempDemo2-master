//
//  OperationView.h
//  BaiduMap
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const OperationViewHeight = 40.0;

@interface OperationView : UIView

@property (nonatomic, copy) void (^ startBtnCLickBlock)();

@property (nonatomic, copy) void (^ followBtnCLickBlock)();

@property (nonatomic, copy) void (^ followHeadBtnCLickBlock)();

@property (nonatomic, copy) void (^ stopBtnCLickBlock)();

@end
