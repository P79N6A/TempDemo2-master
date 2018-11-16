//
//  DrawModel.h
//  Animation
//
//  Created by yulong on 16/2/16.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawModel : NSObject

@property (nonatomic, strong) NSString *result_id;

@property (nonatomic, strong) NSString *result_one_id;
@property (nonatomic, strong) NSString *result_two_id;
@property (nonatomic, strong) NSString *result_thr_id;
@property (nonatomic, strong) NSString *result_one_name;
@property (nonatomic, strong) NSString *result_two_name;
@property (nonatomic, strong) NSString *result_thr_name;

@property (nonatomic, strong) NSString *score;

//创建时间(y-d-m)
@property (nonatomic, strong) NSString *time;
//创建时间(d-m)
@property (nonatomic, strong) NSString *timetwo;

@end
