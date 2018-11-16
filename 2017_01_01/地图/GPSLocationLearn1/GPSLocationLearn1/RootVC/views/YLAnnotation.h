//
//  YLAnnotation.h
//  GPSLocation
//
//  Created by yulong on 15/10/12.
//  Copyright © 2015年 HuiXin. All rights reserved.
//  自定义大头针

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

// 自定义大头针必须遵守的协议 MKAnnotation
@interface YLAnnotation : NSObject <MKAnnotation>
{
    // 协议规定
    CLLocationCoordinate2D _coordinate2D;
    NSString * _title;
    NSString * _subTitle;
    
}
- (instancetype)initWithCoordinate2D:(CLLocationCoordinate2D)tempCoordinate2D title:(NSString *)tempTitle subTitle:(NSString *)tempSubTitle;

@end
