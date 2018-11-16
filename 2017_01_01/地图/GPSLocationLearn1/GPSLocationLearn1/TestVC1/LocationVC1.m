//
//  TestVC1.m
//  GPSLocation
//
//  Created by xiaoyulong on 16/6/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "LocationVC1.h"
#import <MapKit/MapKit.h>
#import "YLAnnotation.h"

@interface LocationVC1 () <MKMapViewDelegate>

/// 地图专用类, 系统自带的地图是高德地图
@property (nonatomic, strong) MKMapView *mapView;


@end

@implementation LocationVC1

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
     深圳大学西门
     113.939238,22.538672
     */
    
    //113.935261,22.53761
    CLLocationCoordinate2D coordinate2D = {22.53761, 113.935261};
    // 所需的缩放级别, 越小越高
    MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate2D, span);
    [self.mapView setRegion:region animated:YES];

    
    //添加长按手势
    UILongPressGestureRecognizer *lGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onLongGR:)];
    [self.mapView addGestureRecognizer:lGR];

}


#pragma mark - 按钮响应事件

- (void)onLongGR:(UILongPressGestureRecognizer *)longGestureRecognizer
{
    NSLog(@"longGestureRecognizer==%@",longGestureRecognizer);
    //判断手势状态，是开始才做些事情
    if (longGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        //首先，获得点击点在mapview上的坐标
        CGPoint point = [longGestureRecognizer locationInView:self.mapView];
        //将物理坐标转换成经纬度，使用地图自带的方法w
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        //实例化一个标注对象并赋值
        YLAnnotation *annotation = [[YLAnnotation alloc] initWithCoordinate2D:coordinate title:@"自定义" subTitle:@"其他一些附加内容"];
        
//        [placeArray addObject:place];
        
        //添加到地图上
        [self.mapView addAnnotation:annotation];
    }
}

- (void)onBtnClicked:(UIButton *)btn
{
    NSLog(@"详细按键被点击");
}

#pragma mark - 网络请求


#pragma mark - 代理方法
#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"MKAnnotation==%@",annotation);
    // 判断是否是用户点（小蓝点），是的话返回空即可
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *reuseID = @"AnnotationReuseID";
    
    
#define CustomPinView
    
#ifdef CustomPinView

    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if (pinView == nil)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
    }

    // 设置大头针颜色
    pinView.pinColor = MKPinAnnotationColorPurple;
    // 设置落下时是否有动画
    pinView.animatesDrop = YES;
    // 设置是否可以点击
    pinView.canShowCallout=YES;
    return pinView;
    
#else

    // 自定义显示图片
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if (aView == nil)
    {
        aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
    }
    // 设置标注的图片
    aView.image = [UIImage imageNamed:@"map"];
    // 设置是否可以点击
    aView.canShowCallout = YES;
    aView.draggable = YES;
    
    // 左侧
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    // 设置图片
    aView.leftCalloutAccessoryView = imgView;

    
    
    // 在右侧添加一个按键
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    aView.rightCalloutAccessoryView = btn;
    
    return aView;

    
#endif


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
