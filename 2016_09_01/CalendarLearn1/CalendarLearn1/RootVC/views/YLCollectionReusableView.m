//
//  LYWCollectionReusableView.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 16/9/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "YLCollectionReusableView.h"

@implementation YLCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dateLabel];
    }
    return self;
}


- (UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 20, self.bounds.size.height)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont boldSystemFontOfSize:14];
        _dateLabel.textColor = UIColorHex(0x3e3e3e);
    }
    return _dateLabel;
}



//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self == [super initWithFrame:frame]) {
//    }
//    return self;
//}

@end
