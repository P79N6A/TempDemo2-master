//
//  MonthModel.h
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/4.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DayModel;
@interface MonthModel : NSObject

@property (nonatomic, copy) NSString *titleStr;

/**
 每个月有多少天
 */
@property (nonatomic, strong) NSMutableArray <DayModel *>*dayArray;

@end
