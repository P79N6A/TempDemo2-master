//
//  TestVC3.m
//  GPSLocation
//
//  Created by xiaoyulong on 16/6/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "LocationVC3.h"
#import <MapKit/MapKit.h>
#import "YLAnnotation.h"
#import "MapGDHelper.h"

@interface LocationVC3 () <MKMapViewDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate>
{
    CLLocationManager *_locationManager;
    
}
/// 地图专用类, 系统自带的地图是高德地图
@property (nonatomic, strong) MKMapView *mapView;


@end

@implementation LocationVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.mapView];
    
    
    // 定位
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    // 设置精度过滤，只有位置变化距离大于50米，才通知我们
    _locationManager.distanceFilter = 20;
    //    _locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    // 精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        // 永久授权
        [_locationManager requestAlwaysAuthorization];
        // 使用中授权
        [_locationManager requestWhenInUseAuthorization];
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
    
    // 不需要时停止定位
    //    [_locationManager stopUpdatingLocation];
    
    
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"locations==%@", locations);
    CLLocation *location = [locations lastObject];
    
    // 高度，海拔高度;高位，高等;[天]地平纬度;
    // coordinate
    NSLog(@"location==%f %f",location.coordinate.latitude, location.coordinate.longitude);
    
    // longitude
    // 经度，经线;
    
    
    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔高度：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    
    MKCoordinateSpan span = {0.0000001, 0.000001};
    MKCoordinateRegion regin = MKCoordinateRegionMake(location.coordinate, span);
    [_mapView setRegion:regin animated:YES];
    
    CLLocationCoordinate2D coordinate2D = {location.coordinate.latitude, location.coordinate.longitude};
    
    
    // 根据坐标经纬度，得到地址
    // iOS 5.0 就弃用了
    //    Global Position System 全球定位系统
    //            MKReverseGeocoder *reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:coordinate2D];
    //        reverseGeocoder.delegate = self;
    //        [reverseGeocoder start];
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        MKPlacemark *placemark = [placemarks lastObject];
        NSLog(@"placemark==%@", placemark);
        NSLog(@"当前省份信息为：%@",placemark.administrativeArea);
        NSLog(@"当前城市信息为：%@",placemark.locality);
        NSLog(@"%@ %@ %@ %@ %@ %@",[placemark country],[placemark name],[placemark thoroughfare],[placemark locality],[placemark subAdministrativeArea],[placemark subLocality]);
        
        YLAnnotation * annotation = [[YLAnnotation alloc] initWithCoordinate2D:coordinate2D title:[placemark administrativeArea] subTitle:[placemark subLocality]];
        [_mapView addAnnotation:annotation];
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error is %@",error);
}

// 定位权限改变的时候
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"status==%d", status);
    
    if ([MapGDHelper MapServiceEnabled:YES])
    {
        NSLog(@"定位功能打开了，可以用");
    }
    else
    {
        [_locationManager startUpdatingLocation];
    }
    
    
    //    if (
    //        ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusAuthorizedWhenInUse) ||
    //        (![_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusAuthorized)
    //        )
    //    {
    //        NSString *message = @"您的手机目前并未开启定位服务，如欲开启定位服务，请至设定->隐私->定位服务，开放本程序的定位服务功能";
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //
    //    }
    //    else
    //    {
    //        [_locationManager startUpdatingLocation];
    //    }
}


#if 0
// 根据坐标经纬度，得到地址
// iOS 5.0 就弃用了
//    Global Position System 全球定位系统
//            MKReverseGeocoder *reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:coordinate2D];
//        reverseGeocoder.delegate = self;
//        [reverseGeocoder start];

#pragma mark - MKReverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    NSLog(@"当前地理信息为：%@",placemark);
    NSLog(@"当前省份信息为：%@",placemark.administrativeArea);
    NSLog(@"当前城市信息为：%@",placemark.locality);
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"MKReverseGeocoder has failed.");
}
#endif





#pragma mark - setter, getter

- (MKMapView *)mapView
{
    if (_mapView == nil)
    {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
        _mapView.delegate = self;
        // 设置显示用户当前位置
        _mapView.showsUserLocation = YES;
        
        /*
         MKMapTypeStandard = 0,  默认
         MKMapTypeSatellite,     卫星
         MKMapTypeHybrid         混合
         */
        _mapView.mapType = MKMapTypeStandard;
        
    }
    return _mapView;
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
