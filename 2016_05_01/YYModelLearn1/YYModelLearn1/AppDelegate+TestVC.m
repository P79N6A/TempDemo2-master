//
//  AppDelegate+TestVC.m
//  YYModleLearn1
//
//  Created by xiaoyulong on 17/3/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate+TestVC.h"

@implementation AppDelegate (TestVC)

- (void)setupTestRootVC
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // MARK: - 使用YYModel解析  和 自己手动解析区别
    // MARK: email = "<null>";  YYModel 解析后不崩溃
    [array addObject:@"RootViewController"];
    
    
    // MARK: - YYModel 使用
    [array addObject:@"TestVC1"];

    
    // MARK: - [userModel setValuesForKeysWithDictionary:jsonDict]; 给model属性赋值
    [array addObject:@"TestVC2"];

    
    

    [self makeControllerWith:array];

}

- (void)makeControllerWith:(NSArray *)array
{
    NSString *clsName = array[2];
    
    
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = array.count-1; i < array.count; --i)
//    {
//        [mArray addObject:array[i]];
//    }
//    NSString *clsName = mArray[0];
    
    
    Class class = NSClassFromString(clsName);
    
    UIViewController *rootVC = [[class alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootVC.navigationItem.title = NSStringFromClass(rootVC.classForCoder);
    self.window.rootViewController = nav;
    
}

@end
