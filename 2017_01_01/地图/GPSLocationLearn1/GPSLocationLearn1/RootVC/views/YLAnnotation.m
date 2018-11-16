//
//  YLAnnotation.m
//  GPSLocation
//
//  Created by yulong on 15/10/12.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "YLAnnotation.h"

@implementation YLAnnotation

- (instancetype)initWithCoordinate2D:(CLLocationCoordinate2D)tempCoordinate2D title:(NSString *)tempTitle subTitle:(NSString *)tempSubTitle;
{
    self = [super init];
    if (self) {
        _coordinate2D = tempCoordinate2D;
        _title = [tempTitle copy];
        _subTitle = [tempSubTitle copy];
    }
    return self;
}

- (NSString *)title
{
    return _title;
}

- (NSString *)subtitle
{
    return _subTitle;
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate2D;
}

@end


