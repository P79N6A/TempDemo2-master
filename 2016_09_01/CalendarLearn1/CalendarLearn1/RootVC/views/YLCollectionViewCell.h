//
//  YLCollectionViewCell.h
//  CalendarLearn1
//
//  Created by xiaoyulong on 16/9/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayModel;
@interface YLCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) void (^ tapActionBlock)();
@property (nonatomic, copy) void (^ fourTapActionBlock)();


- (void)refreshYLCollectionViewCellWith:(DayModel *)dayModel;

@end
