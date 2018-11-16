//
//  RootViewController.m
//  BaiduMap
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "OperationView.h"

@interface RootViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
}

@property (nonatomic, strong) OperationView *operationView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;

}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;

}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

#pragma mark - 创建UI

- (void)createUI
{
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.navigationItem.title = @"定位功能";
    
    
    /**
     加 NSLocationWhenInUseUsageDescription
     NSLocationAlwaysUsageDescription 和  两个String字段，value可以为空，也可以设置YES，
     不过我得问题还是不能解决，最终还是找到得了问题所在，
     就是info.plist中还需要包含Supported interface orientations 这个Array字段。然后运行就解决了

     */
    _locService = [[BMKLocationService alloc] init];

    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    //设置地图缩放级别
    _mapView.zoomLevel = 18;
    [self.view addSubview:_mapView];

    
    
    [self.view addSubview:self.operationView];

}


#pragma mark - 按钮响应事件

- (void)handlestartBtnCLickAction
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

- (void)handlefollowBtnCLickAction
{
    NSLog(@"进入跟随态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

- (void)handlefollowHeadBtnCLickAction
{
    NSLog(@"进入罗盘态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;

}

- (void)handlestopBtnCLickAction
{
    NSLog(@"停止定位");
    [_locService stopUserLocationService];
    
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = NO;

}

#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - BMKLocationServiceDelegate

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


#pragma mark - setter, getter

- (OperationView *)operationView
{
    if (_operationView == nil)
    {
        _operationView = [[OperationView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, OperationViewHeight)];
        _operationView.backgroundColor = [UIColor yellowColor];
        
        kSelfWeak;
        _operationView.startBtnCLickBlock = ^(){
            kSelfStrong;
            [strongSelf handlestartBtnCLickAction];
        };
        
        _operationView.followBtnCLickBlock = ^(){
            kSelfStrong;
            [strongSelf handlefollowBtnCLickAction];
        };
        
        _operationView.followHeadBtnCLickBlock = ^(){
            kSelfStrong;
            [strongSelf handlefollowHeadBtnCLickAction];
        };
        
        _operationView.stopBtnCLickBlock = ^(){
            kSelfStrong;
            [strongSelf handlestopBtnCLickAction];
        };
        
        
    }
    return _operationView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
