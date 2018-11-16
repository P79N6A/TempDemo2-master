//
//  QLOrderDetailModel.m
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "QLOrderDetailModel.h"
#import "QLOrderPayInfoModel.h"


@implementation QLOrderDetailModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    
    return @{@"PayList" : [QLOrderPayInfoModel class]
             };
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
