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
    
    
    
    // MARK: - LocationDemo  定位功能(需要真机测试定位功能)
    /**
     
     申请密钥 http://lbsyun.baidu.com/apiconsole/key

     
     
     iOS地图SDK 下载地址
     http://lbsyun.baidu.com/index.php?title=iossdk/sdkiosdev-download
     自2.9.0版本起，iOS 地图SDK不再提供 .a形式的开发包
     
     
     
     
     
     配置开发环境
     http://lbsyun.baidu.com/index.php?title=iossdk/guide/buildproject
     
     
     
     
     
     在使用SDK的类 按需 引入下边的头文件：
     #import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
     
     #import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
     
     #import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
     
     #import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
     
     #import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
     
     #import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
     
     #import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
     
     #import < BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
     
     注: 静态库中采用Objective-C++实现，因此需要您保证您工程中至少有一个.mm后缀的源文件(您可以将任意一个.m后缀的文件改名为.mm)，
     或者在工程属性中指定编译方式，即在Xcode的Project -> Edit Active Target -> Build Setting 中找到 Compile Sources As，
     并将其设置为"Objective-C++"
     
     */
    
    [array addObject:@"RootViewController"];
    
    
    
    // MARK: - SearchDemo PoiSearchDemoViewController
    // MARK: 在北京市内搜索餐厅
    [array addObject:@"TestVC1"];

    
    // MARK: - SearchDemo  BusLineSearchViewController
    // MARK: 在北京市内搜索公交
    [array addObject:@"TestVC2"];

    
    

    [self makeControllerWith:array];
}

- (void)makeControllerWith:(NSArray *)array
{
    NSString *clsName = array[2];
    
    
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = array.count-1; i >= 0; --i)
//    {
//        [mArray addObject:array[i]];
//    }
//    NSString *clsName = mArray[61];
    
    
    
    Class class = NSClassFromString(clsName);
    
    UIViewController *rootVC = [[class alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootVC.navigationItem.title = NSStringFromClass(rootVC.classForCoder);
    rootVC.edgesForExtendedLayout = UIRectEdgeNone;
    rootVC.automaticallyAdjustsScrollViewInsets = NO;
    rootVC.extendedLayoutIncludesOpaqueBars = NO;
    self.window.rootViewController = nav;
    
}


@end



