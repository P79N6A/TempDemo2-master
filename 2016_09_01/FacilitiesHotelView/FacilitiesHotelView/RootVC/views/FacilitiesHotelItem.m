//
//  FacilitiesHotelItem.m
//  FacilitiesHotelView
//
//  Created by xiaoyulong on 16/9/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "FacilitiesHotelItem.h"

@interface FacilitiesHotelItem ()

@end

@implementation FacilitiesHotelItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.topLine];
        [self addSubview:self.bottomLine];
        [self addSubview:self.leftLine];
        [self addSubview:self.rightLine];
        
    }
    return self;
}

- (UIView *)topLine
{
    if (_topLine == nil)
    {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, WIDT05)];
        _topLine.backgroundColor = UIColorMake(153, 153, 153, 1);
    }
    return _topLine;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil)
    {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - WIDT05, self.bounds.size.width, WIDT05)];
        _bottomLine.backgroundColor = UIColorMake(153, 153, 153, 1);
    }
    return _bottomLine;
}


- (UIView *)leftLine
{
    if (_leftLine == nil)
    {
        _leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDT05, self.bounds.size.height)];
        _leftLine.backgroundColor = UIColorMake(153, 153, 153, 1);
    }
    return _leftLine;
}


- (UIView *)rightLine
{
    if (_rightLine == nil)
    {
        _rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - WIDT05, 0, WIDT05, self.bounds.size.height)];
        _rightLine.backgroundColor = UIColorMake(153, 153, 153, 1);
    }
    return _rightLine;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
