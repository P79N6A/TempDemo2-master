//
//  QLOrderPayInfoModel.h
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLOrderPayInfoModel : NSObject

// 支付订单号, 彭俊让用这个做交易号
@property (nonatomic, copy) NSString *pay_order_number;

// 交易金额
@property (nonatomic, copy) NSString *Submit_money;

// 交易时间
@property (nonatomic, copy) NSString *TransactionTim;

// 交易订单号
@property (nonatomic, copy) NSString *TransactionNumber;

// 支付类型
@property (nonatomic, copy) NSString *PayType;


@property (nonatomic, copy) NSString *GeneralPay_way;

// YES代表是普通线路订单详情支付信息 ； NO代表是WiFi 签证 租车 航展门票订单详情支付信息
@property (nonatomic, assign) BOOL isQLOrderDetail;


@end
