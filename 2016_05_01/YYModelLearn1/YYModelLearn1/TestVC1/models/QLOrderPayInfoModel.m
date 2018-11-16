//
//  QLOrderPayInfoModel.m
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "QLOrderPayInfoModel.h"

@implementation QLOrderPayInfoModel

// MARK: - 如果需要重新命名字段的话，用这个
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"GeneralPay_way" : @"pay_way"
             };
}


- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
