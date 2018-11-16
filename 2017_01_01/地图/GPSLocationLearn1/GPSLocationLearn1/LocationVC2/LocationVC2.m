//
//  TestVC2.m
//  GPSLocation
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "LocationVC2.h"
#import <MapKit/MapKit.h>
#import "YLAnnotation.h"

@interface LocationVC2 () <MKMapViewDelegate>


/// 地图专用类, 系统自带的地图是高德地图
@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation LocationVC2

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
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    [self.view addSubview:self.mapView];
    
    /**
     深圳大学西门
     113.939238,22.538672
     */
    
    //113.935261,22.53761
    CLLocationCoordinate2D coordinate2D = {22.53761, 113.935261};
    // 所需的缩放级别, 越小越高
    MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate2D, span);
    [self.mapView setRegion:region animated:YES];
    
    
    
    // 大头针
    YLAnnotation *annotation = [[YLAnnotation alloc] initWithCoordinate2D:coordinate2D title:@"深圳大学" subTitle:@"小西门"];
    // 添加大头针
    [_mapView addAnnotation:annotation];

    
    NSArray * arr = @[@"左移",@"放大",@"删除",@"常规",@"卫星",@"混合"];
    UISegmentedControl * segCtl = [[UISegmentedControl alloc] initWithItems:arr];
    segCtl.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    [segCtl addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segCtl];


}


#pragma mark - 按钮响应事件

- (void)segChange:(UISegmentedControl *)ctl
{
    switch (ctl.selectedSegmentIndex) {
        case 0:
        {
            // 左移
            MKCoordinateRegion region = _mapView.region;
            region.center.longitude -= 0.001;
            _mapView.region = region;
        }
            break;
        case 1:
        {
            // 放大
            MKCoordinateRegion region = _mapView.region;
            region.span.latitudeDelta *= 10;
            _mapView.region = region;
        }
            break;
        case 2:
        {
            // 移除大头针
            [_mapView removeAnnotations:_mapView.annotations];
        }
            break;
        case 3:
        {
            // 常规
            _mapView.mapType = MKMapTypeStandard;
        }
            break;
        case 4:
        {
            // 卫星
            _mapView.mapType = MKMapTypeSatellite;
        }
            break;
        case 5:
        {
            // 混合
            _mapView.mapType = MKMapTypeHybrid;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter


- (MKMapView *)mapView
{
    if (_mapView == nil)
    {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
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
