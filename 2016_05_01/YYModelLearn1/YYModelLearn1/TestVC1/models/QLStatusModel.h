//
//  QLStatusModel.h
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QLOrderDetailModel;

@interface QLStatusModel : NSObject

// OK 表示返回成功
@property (nonatomic, copy) NSString *Status;

// 失败原因
@property (nonatomic, copy) NSString *ErrorMessage;


// 不修改字段名称Data
//@property (nonatomic, strong) QLOrderDetailModel *Data;

// 修改字段名称Data 为 orderDetailModel
@property (nonatomic, strong) QLOrderDetailModel *orderDetailModel;


@end
