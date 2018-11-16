//
//  TestVC1.m
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "QLStatusModel.h"
#import "QLOrderDetailModel.h"

#import "QLOrderPayInfoModel.h"

@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self demo1];
//    [self demo2];
    [self demo3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - 字典映射
// MARK: 如果需要重新命名字段的话，用这个
// MARK: 返回的字典data 赋给属性 orderDetailModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"orderDetailModel" : @"Data"
//             };
//}

// MARK: - 数组映射
// MARK: 数组PayList 中包含 QLOrderPayInfoModel
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    // value should be Class or Class name.
//
//    return @{@"PayList" : [QLOrderPayInfoModel class]
//             };
//}

- (void)demo1
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OrderDetailData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    QLStatusModel *statusModel = [QLStatusModel yy_modelWithJSON:json];
    NSLog(@"statusModel==%@", statusModel);

    NSLog(@"statusModel.orderDetailModel==%@", statusModel.orderDetailModel);
//    NSLog(@"Data==%@", statusModel.Data);
}


// MARK: - yy_modelWithDictionary
// MARK: yy_modelWithJSON
- (void)demo2
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OrderDetailData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    QLStatusModel *statusModel = [QLStatusModel yy_modelWithDictionary:json];
    
//    QLStatusModel *statusModel = [QLStatusModel yy_modelWithJSON:json];

    NSLog(@"statusModel==%@", statusModel);

   
    
}


// + (NSArray *)yy_modelArrayWithClass:(Class)cls json:(id)json
// + (NSArray *)yy_modelArrayWithClass:(Class)cls array:(NSArray *)arr

// + (NSDictionary *)yy_modelDictionaryWithClass:(Class)cls json:(id)json
// + (NSDictionary *)yy_modelDictionaryWithClass:(Class)cls dictionary:(NSDictionary *)dic

- (void)demo3
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OrderDetailData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary *dict = (NSDictionary *)json;

    NSDictionary *Data = dict[@"Data"];
    NSLog(@"Data==%@", Data);
    

    
    NSArray *payArray = [NSArray yy_modelArrayWithClass:[QLOrderPayInfoModel class] json:[Data objectForKey:@"PayList"]];

    NSLog(@"payArray==%@", payArray);
}


@end
