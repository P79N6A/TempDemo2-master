//
//  CalendarViewModel.h
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/4.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>



@class MonthModel;
@interface CalendarViewModel : NSObject


/**
 成功的天数
 */
@property (nonatomic, assign) NSInteger successDayCount;

/**
 当前日期所在的 那个单元
 */
@property (nonatomic, assign) NSIndexPath *todayIndexPath;

@property (nonatomic, strong) NSMutableArray <MonthModel *>*dataArray;

- (void)getCalendarDataWith:(void (^)(BOOL isSuccess))completion;

@end
