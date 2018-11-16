//
//  YLWeekView.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 2017/6/4.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "YLWeekView.h"

@interface YLWeekView ()

@end

@implementation YLWeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 定义星期视图,若为周末则字体颜色为绿色
        NSArray *weekTitleArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        for (NSInteger i = 0; i < weekTitleArray.count; i++) {
            
            UILabel *weekTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(i * ((kScreenWidth/(weekTitleArray.count))), 0, kScreenWidth / (weekTitleArray.count ), 30)];
            
            if (i == 0 || i == 6) {
                weekTitleLable.textColor = UIColorRGB(245, 78, 0);
            } else {
                weekTitleLable.textColor = UIColorHex(0x3e3e3e);
            }
            
            weekTitleLable.text = weekTitleArray[i];
            weekTitleLable.textAlignment = NSTextAlignmentCenter;
            weekTitleLable.font = [UIFont systemFontOfSize:14];
            [self addSubview:weekTitleLable];
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
