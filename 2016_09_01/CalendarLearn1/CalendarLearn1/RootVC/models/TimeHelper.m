//
//  TimeHelper.m
//  AboutTime
//
//  Created by xiaoyulong on 16/8/12.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

/// 将NSDate类型的时间转换为NSInteger类型, 使用linux标准时间生成date,从1970/1/1开始
+ (NSString *)getTimeStampStr
{
    // 换算成时间戳, 从 1970年到现在是多少秒
    NSDate *nowDate = [NSDate date];
    NSTimeInterval interval = [nowDate timeIntervalSince1970];
    NSLog(@"interval==%f",interval);
    
    long long totalMilliseconds = interval * 1000 ;
    NSLog(@"totalMilliseconds==%llu",totalMilliseconds);
    
    NSString *str = [NSString stringWithFormat:@"%llu", totalMilliseconds];
    return str;
}

+ (NSString *)getTimeStampWithDateStr:(NSString *)dateStr
{
    // 从 1970年到 2016-06-08 22:38:39 是多少秒
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *dateA = [dateFormatter dateFromString:dateStr];
    
    NSTimeInterval timeInterval = [dateA timeIntervalSince1970];
    NSLog(@"timeInterval1==%f", timeInterval);

    long long totalMilliseconds = timeInterval * 1000 ;
    NSLog(@"totalMilliseconds==%llu",totalMilliseconds);
    NSString *str = [NSString stringWithFormat:@"%llu", totalMilliseconds];

    return str;
}


/// 获取（周一、周二、周三、周四、周五、周六、周日），包括年月日的整型值都可以获取到的
+ (NSString *)getWeekDayStringWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSLog(@"calendar==%@", calendar);

    NSCalendarUnit unitFlags =
    NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay|
    NSCalendarUnitHour|
    NSCalendarUnitMinute|
    NSCalendarUnitSecond|
    NSCalendarUnitWeekday |
    NSCalendarUnitWeekdayOrdinal |
    NSCalendarUnitQuarter |
    NSCalendarUnitWeekOfMonth |
    NSCalendarUnitWeekOfYear |
    NSCalendarUnitYearForWeekOfYear |
    NSCalendarUnitNanosecond |
    NSCalendarUnitCalendar |
    NSCalendarUnitTimeZone;

    

    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    NSLog(@"dateComponents==%@", dateComponents);
    
    NSInteger Era = [dateComponents era];
    
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
    
    NSInteger Weekday = [dateComponents weekday];
    NSInteger weekdayOrdinal = [dateComponents weekdayOrdinal];
    NSInteger quarter = [dateComponents quarter];
    NSInteger weekOfMonth = [dateComponents weekOfMonth];
    NSInteger weekOfYear = [dateComponents weekOfYear];
    NSInteger yearForWeekOfYear = [dateComponents yearForWeekOfYear];
    NSInteger nanosecond = [dateComponents nanosecond];
//    NSCalendar *calendar = [dateComponents calendar];
    NSTimeZone *timeZone = [dateComponents timeZone];


    NSLog(@"Era==%@", @(Era));
    
    // 这些都可以获取到的
    NSLog(@"year==%@", @(year));
    NSLog(@"month==%@",@(month));
    NSLog(@"day==%@",@(day));
    NSLog(@"hour==%@",@(hour));
    NSLog(@"minute==%@",@(minute));
    NSLog(@"second==%@",@(second));
    
    NSLog(@"Weekday==%@",@(Weekday));
    
    // 表示WeekDay在下一个更大的日历单元中的位置。例如WeekDay=3，WeekDayOrdinal=2  就表示这个月的第2个周二。
    NSLog(@"weekdayOrdinal==%@",@(weekdayOrdinal));
    
    NSLog(@"quarter==%@",@(quarter));
    
    // 表示当月里面的第几周
    NSLog(@"weekOfMonth==%@",@(weekOfMonth));
    // 当年的第几周
    NSLog(@"weekOfYear==%@",@(weekOfYear));
    NSLog(@"yearForWeekOfYear==%@",@(yearForWeekOfYear));
    NSLog(@"nanosecond==%@",@(nanosecond));
    NSLog(@"timeZone==%@",timeZone);




    
    // 表示周里面的天 1代表周日 2代表周一 7代表周六
    NSInteger weekDay = [dateComponents weekday];
    
    NSString *weekStr = nil;
    switch (weekDay) {
        case 1:
            weekStr = @"周日";
            break;
        case 2:
            weekStr = @"周一";
            break;
        case 3:
            weekStr = @"周二";
            break;
        case 4:
            weekStr = @"周三";
            break;
        case 5:
            weekStr = @"周四";
            break;
        case 6:
            weekStr = @"周五";
            break;
        case 7:
            weekStr = @"周六";
            break;
            
        default:
            break;
    }
    
    return weekStr;
}


//返回周几的问题
+ (NSString *)getWeekStrWith:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    // 自带的类型
    NSLog(@"weekdaySymbols==%@", dateFormat.weekdaySymbols);
    NSLog(@"%@", dateFormat.shortWeekdaySymbols);
    NSLog(@"%@", dateFormat.standaloneWeekdaySymbols);
    NSLog(@"%@", dateFormat.veryShortWeekdaySymbols);
    NSLog(@"%@", dateFormat.shortStandaloneWeekdaySymbols);
    NSLog(@"%@", dateFormat.veryShortStandaloneWeekdaySymbols);

    // 自定义类型赋给
    NSArray *weekdayAry = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    [dateFormat setShortWeekdaySymbols:weekdayAry];
//    [dateFormat setDateFormat:@"yyyy年eee"];
    [dateFormat setDateFormat:@"eee"];
    
    //    NSDate *date = [NSDate date];
    NSString *srting = [dateFormat stringFromDate:date];
    return srting;
}


/// 获取现在时间
+ (NSString *)getCurrentTimeStr
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    return [dateFormatter stringFromDate:nowDate];
}

/// 获取当前时间, 设定时间格式
+ (NSString *)getCurrentTimeStrWithDateFormatter:(NSString *)dateFormatterStr
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormatterStr;
    
    NSString *dateStr = [dateFormatter stringFromDate:nowDate];
    
    //    NSString *language = [[HKLanguageTools shareInstance] currentLanguage];
    //    if ([language isEqualToString:@"zh-Hans"])
    //    {
    //        // 中文
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    //    else if ([language isEqualToString:@"en"])
    //    {
    //        // 英文
    //        [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    //    else
    //    {
    //        // 泰文
    //        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    
    return dateStr;
}

+ (NSString *)getDateStrWithDate:(NSDate *)date DateFormatter:(NSString *)dateFormatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = @"";
    [dateFormatter setDateFormat:dateFormatterStr];
    dateString = [dateFormatter stringFromDate:date];
    
    //    NSString *language = [[HKLanguageTools shareInstance] currentLanguage];
    //    if ([language isEqualToString:@"zh-Hans"])
    //    {
    //        // 中文
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    //    else if ([language isEqualToString:@"en"])
    //    {
    //        // 英文
    //        [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    //    else
    //    {
    //        // 泰文
    //        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    
    return dateString;
}

/// dateStr＝2016-05-31 16:23:08； 得出明天
+ (NSString *)getNextDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    dateFormatter.dateFormat = dateFormatterStr;
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    // 将dateStr转换为时间戳,加上 24小时，然后再将时间戳转换为时间格式的yyyy-MM-dd HH:mm:ss字符串
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    
    
    // 加上24小时
    timeInterval = timeInterval + (24 * 60 * 60);
    
    // 新的时间
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *newDateStr = [dateFormatter stringFromDate:newDate];
    
    return newDateStr;
}

/// 在dateStr 基础上加上指定的时间间隔 secsToBeAdded, 默认格式yyyy-MM-dd HH:mm:ss
+ (NSString *)getDateStrWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *dateA = [dateFormatter dateFromString:dateStr];
    
    NSDate *dateB = [NSDate dateWithTimeInterval:secsToBeAdded sinceDate:dateA];
    NSString *newDateStr = [dateFormatter stringFromDate:dateB];

    return newDateStr;
}

/**
 两个日期相比较，
 1  oneDayStr is in the future
 -1 oneDayStr is in the past
 0 Both dates are the same
 */+ (NSInteger)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr withFormatterStr:(NSString *)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatterStr;
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending)
    {
//        NSLog(@"oneDayStr  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending)
    {
//        NSLog(@"oneDayStr is in the past");
        return -1;
    }
    else
    {
//        NSLog(@"Both dates are the same");
        return 0;
    }
}

@end
