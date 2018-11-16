//
//  CalendarViewModel.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/4.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "CalendarViewModel.h"
#import "MonthModel.h"
#import "DayModel.h"
#import "NSDate+LYWCalendar.h"
#import "TimeHelper.h"

//想要展示的月数
#define Numbermonthes (8)
#define NowDateFormatter @"yyyy-MM-dd"

static NSString *beginDateString = @"2017-06-04";

@implementation CalendarViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _successDayCount = 0;
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getCalendarDataWith:(void (^)(BOOL isSuccess))completion
{
    _successDayCount = 0;
    if (_dataArray.count != 0)
    {
        [_dataArray removeAllObjects];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = NowDateFormatter;
    NSDate *beginDate = [dateFormatter dateFromString:beginDateString];
    NSLog(@"beginDate==%@", beginDate);
    
    NSInteger beginYear = [beginDate year:beginDate];
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    
    for (NSInteger i = 0; i < Numbermonthes; i++)
    {
        MonthModel *monthModel = [[MonthModel alloc] init];
        
        //获取月份
        NSInteger month = ([beginDate month:beginDate] + i) % 12;
        if (month == 0) {
            month = 12;
        }

        
        NSDateComponents *components = [[NSDateComponents alloc]init];
        //获取下个月的年月日信息,并将其转为date
        components.month = month;
        components.year = beginYear;
        if (month == 12) {
            beginYear ++;
        }
        components.day = 1; // 这个月的1号
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [calendar dateFromComponents:components];
        
//        NSLog(@"nextDate==%@", nextDate);
        
        //获取该月第一天星期几
        NSInteger firstDayInThismonth = [nextDate firstWeekdayInThisMonth:nextDate];
        //该月的有多少天daysInThismonth
        NSInteger daysInThismonth = [nextDate totaldaysInMonth:nextDate];
//        NSLog(@"daysInThismonth==%d", daysInThismonth);
        
        monthModel.titleStr = [NSString stringWithFormat:@"%@年%@月", @(components.year), @(components.month)];
        
        
        /**
         逻辑部分,这里有个比较长的三项表达式
         
         (daysInmonth > 29 && (firstDayInThismonth == 6 || firstDayInThismonth ==5) ? 42 : 35)
         
         就是日历到底是六行还是七行,这就要根据日历的特性来判断了,如果当月天数大于29天并且当月第一天星期六(以这个程序的准则)或者星期天是返回六行剩下的返回三行,也有可能返回四行的,但是就这个程序来说是不可能的也就不需要做判断了
         */
        
        for (NSInteger j = 0; j < (daysInThismonth > 29 && (firstDayInThismonth == 6 || firstDayInThismonth == 5) ? 42 : 35) ; j++)
        {
            DayModel *dayModel = [[DayModel alloc] init];
            NSString *string = @"";
            if (j < firstDayInThismonth || j > daysInThismonth + firstDayInThismonth - 1)
            {
                string = @"";
                dayModel.dayStyleType = DayStyleFail;
            }
            else
            {
                string = [NSString stringWithFormat:@"%ld", j - firstDayInThismonth + 1];
                
                NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", @(components.year), @(month), string];
                
                NSInteger compareResult = [TimeHelper compareOneDay:dateStr withAnotherDay:currentDateStr withFormatterStr:NowDateFormatter];
                if (compareResult == 0)
                {
                    dayModel.dayStyleType = DayStyleGoing;
                    _todayIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
                    
                    NSString *timeHours = [TimeHelper getCurrentTimeStrWithDateFormatter:@"HH"];
                    NSString *timeMinutes = [TimeHelper getCurrentTimeStrWithDateFormatter:@"mm"];
                    NSString *timeSeconds = [TimeHelper getCurrentTimeStrWithDateFormatter:@"ss"];
                    
                    NSInteger allSeconds = timeHours.integerValue * 60 * 60 + timeMinutes.integerValue * 60 + timeSeconds.integerValue;
                    
                    NSLog(@"%@", @(allSeconds));
                    
                    
                    CGFloat progress = allSeconds / (24.0 * 60 * 60);
                    NSLog(@"progress==%f", progress);

                    
                    dayModel.progress = progress;
                }
                else if (compareResult == -1)
                {
                    if ([TimeHelper compareOneDay:beginDateString withAnotherDay:dateStr withFormatterStr:NowDateFormatter] == 1)
                    {
                        dayModel.dayStyleType = DayStyleFail;
                        dayModel.progress = 1.0;
                    }
                    else
                    {
                        dayModel.dayStyleType = DayStyleSuccess;
                        dayModel.progress = 1.0;
                        _successDayCount ++;
                    }
                }
                else
                {
                    dayModel.dayStyleType = DayStyleFail;
                }
            }
            
           
            dayModel.dayStr = string;

            [monthModel.dayArray addObject:dayModel];
        }
        [self.dataArray addObject:monthModel];
    }
    
    completion(YES);
}

@end
