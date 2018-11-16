//
//  TestVC1.m
//  BaiduMap
//
//  Created by xiaoyulong on 16/6/26.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 () <BMKMapViewDelegate, BMKPoiSearchDelegate>
{
    BMKMapView      * _mapView;
    BMKPoiSearch    * _poisearch;

    UITextField     * _cityTextField;
    UITextField     * _keyTextField;
    UIButton        * _nextPageButton;

    int             _curPage;

}
@end

@implementation TestVC1

- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
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
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil; // 不用时，置nil
}

#pragma mark - 创建UI

- (void)createUI
{
    
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
    
    
    _keyTextField = [[UITextField alloc] initWithFrame:CGRectMake(205, 20, 110, 30)];
    _keyTextField.borderStyle = UITextBorderStyleLine;
//    _keyTextField.delegate = self;
    _keyTextField.text = @"餐厅";
    [self.view addSubview:_keyTextField];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    searchBtn.layer.borderWidth = 3.0;
    searchBtn.frame = CGRectMake(10, 45, 100, 30);
    [searchBtn setTitle:@"开始搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    
    _nextPageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _nextPageButton.layer.borderColor = [UIColor blackColor].CGColor;
    _nextPageButton.layer.borderWidth = 3.0;
    _nextPageButton.frame = CGRectMake(210, 45, 100, 30);
    [_nextPageButton setTitle:@"下一组数据" forState:UIControlStateNormal];
    [_nextPageButton addTarget:self action:@selector(nextPageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextPageButton];
    
    
    

    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 85, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 85)];
    //设置地图缩放级别
    _mapView.zoomLevel = 18;
    _mapView.mapType = BMKMapTypeStandard;
//    _mapView.mapType = BMKMapTypeSatellite;
    
//    _mapView.mapType = BMKMapTypeTrafficOn;
//    _mapView.mapType = BMKMapTypeTrafficAndSatellite;

    [self.view addSubview:_mapView];
    
    _poisearch = [[BMKPoiSearch alloc]init];

    _mapView.isSelectedAnnotationViewFront = YES;


}


#pragma mark - 按钮响应事件

- (void)searchBtnClick
{
    NSLog(@"开始搜索");
    _curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = _curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityTextField.text;
    citySearchOption.keyword = _keyTextField.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if (flag)
    {
        _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
    
}

- (void)nextPageBtnClick
{
    _curPage++;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = _curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityTextField.text;
    citySearchOption.keyword = _keyTextField.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - BMKMapViewDelegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}

// 点击大头针时调用
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}

// 大头针插上
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark - BMKPoiSearchDelegate

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
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
