//
//  TimeHelper.h
//  AboutTime
//
//  Created by xiaoyulong on 16/8/12.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//  时间助手，封装一些关于时间的东西

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject


/*
 获取标准时间，也就是通常说的  当前时间戳
 时间标志_t（必填，调用接口时当前时间的毫秒值）
 将 NSDate 类型的时间转换为NSInteger类型, 从1970/1/1开始
 13位
 */
+ (NSString *)getTimeStampStr;


/// 2016-06-08 22:38:39 换算成时间戳
+ (NSString *)getTimeStampWithDateStr:(NSString *)dateStr;

/// 获取（周一、周二、周三、周四、周五、周六、周日），包括年月日的整型值都可以获取到的
+ (NSString *)getWeekDayStringWithDate:(NSDate *)date;

//返回周几的问题
+ (NSString *)getWeekStrWith:(NSDate *)date;

/// 获取现在时间
+ (NSString *)getCurrentTimeStr;

/// 获取当前时间, 设定时间格式
+ (NSString *)getCurrentTimeStrWithDateFormatter:(NSString *)dateFormatterStr;

+ (NSString *)getDateStrWithDate:(NSDate *)date DateFormatter:(NSString *)dateFormatterStr;

/// dateStr＝2016-05-31 16:23:08； 得出明天
+ (NSString *)getNextDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr;

/// 在dateStr 基础上加上指定的时间间隔 secsToBeAdded, 默认格式yyyy-MM-dd HH:mm:ss
+ (NSString *)getDateStrWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDateStr:(NSString *)dateStr;

/**
 两个日期相比较，
 1  oneDayStr is in the future
 -1 oneDayStr is in the past
 0 Both dates are the same
 */
+ (NSInteger)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr withFormatterStr:(NSString *)formatterStr;


@end
