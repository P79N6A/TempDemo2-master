//
//  QLStatusModel.m
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "QLStatusModel.h"

@implementation QLStatusModel


// MARK: - 如果需要重新命名字段的话，用这个
// MARK: 返回的字典data 赋给属性 orderDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"orderDetailModel" : @"Data"
             };
}



- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
