//
//  FacilitiesHotelView.h
//  FacilitiesHotelView
//
//  Created by xiaoyulong on 16/9/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const FacilitiesHotelViewHeight = 100.0;

@interface FacilitiesHotelView : UIView

@property (nonatomic, strong) NSArray *titleArray;

// 动态的，随titleArray元素个数而变化
@property (nonatomic, assign) CGFloat defaultHeight;


//@property (nonatomic, copy) void (^ itemClickBlock)();

@end
