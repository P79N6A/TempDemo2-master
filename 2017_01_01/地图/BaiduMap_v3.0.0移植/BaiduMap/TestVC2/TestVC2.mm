//
//  TestVC2.m
//  BaiduMap
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

#import "UIImage+MyRotate.h"


#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


@interface BusLineAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation BusLineAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end



@interface TestVC2 () <BMKMapViewDelegate, BMKPoiSearchDelegate, BMKBusLineSearchDelegate>
{
    BMKMapView      * _mapView;
    BMKPoiSearch    * _poisearch;
    
    UITextField     * _cityTextField;
    UITextField     * _busLineTextField;
    UIButton        * _nextPageButton;

    NSMutableArray* _busPoiArray;

    int currentIndex;
    BMKBusLineSearch* _buslinesearch;
    BMKPointAnnotation* _annotation;


}

@end

@implementation TestVC2

- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_buslinesearch != nil) {
        _buslinesearch = nil;
    }
    
    if (_mapView) {
        _mapView = nil;
    }
    if (_busPoiArray) {
        _busPoiArray = nil;
    }
}

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
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _buslinesearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil; // 不用时，置nil
    _buslinesearch.delegate = nil;
}

#pragma mark - 创建UI

- (void)createUI
{
    // 在 xx 市内 找 公交车
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
    label1.text = @"在";
    [self.view addSubview:label1];
    
    
    _cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 20, 60, 30)];
    _cityTextField.borderStyle = UITextBorderStyleLine;
    _cityTextField.text = @"北京";
//    _cityTextField.delegate = self;
    [self.view addSubview:_cityTextField];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 90, 30)];
    label2.text = @"市内查找";
    [self.view addSubview:label2];
    
    
    _busLineTextField = [[UITextField alloc] initWithFrame:CGRectMake(205, 20, 110, 30)];
    _busLineTextField.borderStyle = UITextBorderStyleLine;
//    _keyTextField.delegate = self;
    _busLineTextField.text  = @"12";
    [self.view addSubview:_busLineTextField];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn.layer.borderWidth = 3.0;
    searchBtn.frame = CGRectMake(10, 45, 100, 30);
    [searchBtn setTitle:@"上行" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    
    UIButton *nextPageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextPageBtn.layer.borderColor = [UIColor blackColor].CGColor;
    nextPageBtn.layer.borderWidth = 3.0;
    nextPageBtn.frame = CGRectMake(210, 45, 100, 30);
    [nextPageBtn setTitle:@"下行" forState:UIControlStateNormal];
    [nextPageBtn addTarget:self action:@selector(nextPageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageBtn];
    
    
    
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 85, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 85)];
    //设置地图缩放级别
    _mapView.zoomLevel = 18;
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.delegate = self;
    //    _mapView.mapType = BMKMapTypeSatellite;
    
    //    _mapView.mapType = BMKMapTypeTrafficOn;
    //    _mapView.mapType = BMKMapTypeTrafficAndSatellite;
    
    [self.view addSubview:_mapView];
    _mapView.isSelectedAnnotationViewFront = YES;

    _poisearch = [[BMKPoiSearch alloc]init];
    _buslinesearch = [[BMKBusLineSearch alloc]init];


    currentIndex = -1;
    _busPoiArray = [[NSMutableArray alloc]init];
    _cityTextField.text = @"北京";
    _busLineTextField.text  = @"12";

}


#pragma mark - 按钮响应事件

- (void)searchBtnClick
{
    [_busPoiArray removeAllObjects];
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityTextField.text;
    citySearchOption.keyword = _busLineTextField.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

- (void)nextPageBtnClick
{
    if (_busPoiArray.count > 0) {
        if (++currentIndex >= _busPoiArray.count) {
            currentIndex -= _busPoiArray.count;
        }
        NSString* strKey = ((BMKPoiInfo*) [_busPoiArray objectAtIndex:currentIndex]).uid;
        BMKBusLineSearchOption *buslineSearchOption = [[BMKBusLineSearchOption alloc]init];
        buslineSearchOption.city= _cityTextField.text;
        buslineSearchOption.busLineUid= strKey;
        BOOL flag = [_buslinesearch busLineSearch:buslineSearchOption];
        if(flag)
        {
            NSLog(@"busline检索发送成功");
        }
        else
        {
            NSLog(@"busline检索发送失败");
        }
    }
    else {
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
        citySearchOption.pageIndex = 0;
        citySearchOption.pageCapacity = 10;
        citySearchOption.city= _cityTextField.text;
        citySearchOption.keyword = _busLineTextField.text;
        BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
        if(flag)
        {
            NSLog(@"城市内检索发送成功");
        }
        else
        {
            NSLog(@"城市内检索发送失败");
        }
        
    }
}


- (NSString*)getMyBundlePath1:(NSString *)filename
{
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}


- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(BusLineAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        default:
            break;
    }
    
    return view;
}

#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark -
#pragma mark imeplement BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BusLineAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(BusLineAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKPoiInfo* poi = nil;
        BOOL findBusline = NO;
        for (NSInteger i = 0; i < result.poiInfoList.count; i++) {
            poi = [result.poiInfoList objectAtIndex:i];
            if (poi.epoitype == 2 || poi.epoitype == 4) {
                findBusline = YES;
                [_busPoiArray addObject:poi];
            }
        }
        //开始bueline详情搜索
        if(findBusline)
        {
            currentIndex = 0;
            NSString* strKey = ((BMKPoiInfo*) [_busPoiArray objectAtIndex:currentIndex]).uid;
            BMKBusLineSearchOption *buslineSearchOption = [[BMKBusLineSearchOption alloc]init];
            buslineSearchOption.city= _cityTextField.text;
            buslineSearchOption.busLineUid= strKey;
            BOOL flag = [_buslinesearch busLineSearch:buslineSearchOption];
            if(flag)
            {
                NSLog(@"busline检索发送成功");
            }
            else
            {
                NSLog(@"busline检索发送失败");
            }
            
        }
    }
}

- (void)onGetBusDetailResult:(BMKBusLineSearch*)searcher result:(BMKBusLineResult*)busLineResult errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        
        BusLineAnnotation* item = [[BusLineAnnotation alloc]init];
        
        //站点信息
        NSInteger size = 0;
        size = busLineResult.busStations.count;
        for (NSInteger j = 0; j < size; j++) {
            BMKBusStation* station = [busLineResult.busStations objectAtIndex:j];
            item = [[BusLineAnnotation alloc]init];
            item.coordinate = station.location;
            item.title = station.title;
            item.type = 2;
            [_mapView addAnnotation:item];
        }
        
        
        //路段信息
        NSInteger index = 0;
        //累加index为下面声明数组temppoints时用
        for (NSInteger j = 0; j < busLineResult.busSteps.count; j++) {
            BMKBusStep* step = [busLineResult.busSteps objectAtIndex:j];
            index += step.pointsCount;
        }
        //直角坐标划线
        BMKMapPoint * temppoints = new BMKMapPoint[index];
        NSInteger k=0;
        for (NSInteger i = 0; i < busLineResult.busSteps.count; i++) {
            BMKBusStep* step = [busLineResult.busSteps objectAtIndex:i];
            for (NSInteger j = 0; j < step.pointsCount; j++) {
                BMKMapPoint pointarray;
                pointarray.x = step.points[j].x;
                pointarray.y = step.points[j].y;
                temppoints[k] = pointarray;
                k++;
            }
        }
        
        
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:index];
        [_mapView addOverlay:polyLine];
        
//        delete temppoints;
        
        BMKBusStation* start = [busLineResult.busStations objectAtIndex:0];
        [_mapView setCenterCoordinate:start.location animated:YES];
        
    }
}


#pragma mark - setter, getter



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
