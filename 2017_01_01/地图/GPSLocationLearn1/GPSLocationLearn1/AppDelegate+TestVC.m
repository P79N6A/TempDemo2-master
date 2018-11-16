//
//  AppDelegate+TestVC.m
//  UserInfoLearn1
//
//  Created by xiaoyulong on 17/3/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate+TestVC.h"


@implementation AppDelegate (TestVC)

- (void)setupTestRootVC
{
    NSMutableArray *array = [[NSMutableArray alloc] init];

    
    // MARK: - 自带高德地图；在深圳大学插上一根大头针
    [array addObject:@"RootViewController"];
    
    
    // MARK: - 自带高德地图；长按手势插大头针，自定义大头针图片
    [array addObject:@"TestVC1"];

    
    // MARK: - 自带高德地图；加分段控制器
    [array addObject:@"TestVC2"];
    
    
    // MARK: - 开启定位功能；iOS 8中CLLocationManager及MKMapView showUserLocation失败的解决办法
    [array addObject:@"TestVC3"];
    
    
    // MARK: - CLGeocoder 地理编码器; AppleMap
    [array addObject:@"TestVC4"];
    
    
    // MARK: -
    [array addObject:@"TestVC5"];
    
    
    
    
    
    [self makeControllerWith:array];
}

- (void)makeControllerWith:(NSArray *)array
{
    NSString *clsName = array[0];
    
    
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = array.count-1; i >= 0; --i)
//    {
//        [mArray addObject:array[i]];
//    }
//    NSString *clsName = mArray[5];
    
    
    
    
    Class class = NSClassFromString(clsName);
    
    UIViewController *rootVC = [[class alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootVC.navigationItem.title = NSStringFromClass(rootVC.classForCoder);
    self.window.rootViewController = nav;
    
}


@end



