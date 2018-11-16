//
//  NSDate+LYWCalendar.h
//  CalendarLearn1
//
//  Created by xiaoyulong on 16/9/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface NSDate (LYWCalendar)

#pragma mark - 获取日
- (NSInteger)day:(NSDate *)date;

#pragma mark - 获取月
- (NSInteger)month:(NSDate *)date;

#pragma mark - 获取年
- (NSInteger)year:(NSDate *)date;

#pragma mark - 获取当月第一天周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

#pragma mark - 获取当前月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;

@end

