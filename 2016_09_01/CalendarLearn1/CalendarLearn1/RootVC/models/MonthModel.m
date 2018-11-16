//
//  MonthModel.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/4.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "MonthModel.h"
#import "DayModel.h"

@implementation MonthModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dayArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
