//
//  DayModel.h
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/4.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DayStyleType) {
    DayStyleSuccess        = -1,
    DayStyleGoing,
    DayStyleFail
};

@interface DayModel : NSObject

// 几号
@property (nonatomic, copy) NSString *dayStr;

@property (nonatomic, assign) DayStyleType dayStyleType;

// 当前这一天过了的时间百分比 0 ~ 1
@property (nonatomic, assign) CGFloat progress;


@end
