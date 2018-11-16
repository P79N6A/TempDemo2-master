//
//  RootViewController.m
//  GPSLocation
//
//  Created by xiaoyulong on 16/6/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

// 系统的库用尖括号
#import <MapKit/MapKit.h>
#import "YLAnnotation.h"

@interface RootViewController () <MKMapViewDelegate>

/// 地图专用类, 系统自带的地图是高德地图，需要 <MapKit/MapKit.h>
@property (nonatomic, strong) MKMapView *mapView;

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

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.mapView];

    
    /**
     百度地图如何查看经度和纬度呢
     首先进入【百度地图】，在右上角可以看到【地图API】，新版的叫［地图开放平台］
     进入后，拉到最下面，在【插件与工具】，选择【坐标拾取工具】
     
     深圳大学西门
     113.939238,22.538672
     
     Goole地图显示经度 和 纬度 右键，单机就能看到
     
     */
    
    // 纬度
    CLLocationDegrees latitude;
    
    // 经度
    CLLocationDegrees longitude;
    
    //113.935261,22.53761
    CLLocationCoordinate2D coordinate2D = {22.53761, 113.935261};
    // 所需的缩放级别, 越小越高
    MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate2D, span);
    [self.mapView setRegion:region animated:YES];
    
    
    //    114.064624,22.607963
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude];
    
    
    // 地理编码
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        MKPlacemark *placemark = [placemarks lastObject];
        NSLog(@"placemark==%@", placemark);
        NSLog(@"当前省份信息为：%@",placemark.administrativeArea);
        NSLog(@"当前城市信息为：%@",placemark.locality);
        
        NSLog(@"%@ %@ %@ %@ %@ %@",[placemark country],[placemark name],[placemark thoroughfare],[placemark locality],[placemark subAdministrativeArea],[placemark subLocality]);
        
        YLAnnotation *annotation = [[YLAnnotation alloc] initWithCoordinate2D:coordinate2D title:[placemark country] subTitle:[placemark administrativeArea]];
        
        [_mapView addAnnotation:annotation];
        
    }];
    
    
    
    // 大头针
    YLAnnotation *annotation = [[YLAnnotation alloc] initWithCoordinate2D:coordinate2D title:@"深圳大学" subTitle:@"小西门"];
    // 添加大头针
    [_mapView addAnnotation:annotation];

}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{

}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{

}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{

}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    
}



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
