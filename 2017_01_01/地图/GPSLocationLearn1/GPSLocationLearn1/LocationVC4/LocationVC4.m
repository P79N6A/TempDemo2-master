//
//  TestVC4.m
//  GPSLocation
//
//  Created by xiaoyulong on 16/6/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "LocationVC4.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface LocationVC4 ()
{
    // 需要 <CoreLocation/CoreLocation.h>
    CLGeocoder *_geocoder;
    
}
@end

@implementation LocationVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _geocoder = [[CLGeocoder alloc] init];
    
//    [self getCoordinateWithAddress:@"北京"];
    
//    [self enterLocationMapWithAddress:@"北京市"];
    
//    [self listPlacemark];
    
    [self turnByTurn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 MARK: - 根据地名确定地理坐标

 @param address 地名
 */
- (void)getCoordinateWithAddress:(NSString *)address
{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        // 取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        CLLocation *location = placemark.location; //位置
        NSLog(@"location==%@", location);
        
        CLRegion *region = placemark.region; //区域
        NSLog(@"region==%@", region);
        
        NSDictionary *addressDic = placemark.addressDictionary; //详细地址信息字典,包含以下部分信息
        NSLog(@"addressDic==%@", addressDic);
        
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        NSString *locality=placemark.locality; // 城市
        NSLog(@"locality==%@", locality);
        
        
        
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        //        NSLog(@"位置:%@,区域:%@,详细信息:%@",location, region, addressDic);
    }];
}

/**
 MARK: - 根据地名确定地理坐标，进入该地的高德地图

 @param address 地名
 */
- (void)enterLocationMapWithAddress:(NSString *)address
{
    //根据“北京市”进行地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark = [placemarks firstObject];//获取第一个地标
        MKPlacemark *mkplacemark = [[MKPlacemark alloc] initWithPlacemark:clPlacemark];//定位地标转化为地图的地标
        NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:mkplacemark];
        [mapItem openInMapsWithLaunchOptions:options];
    }];
}



/**
 在高德地图中开两个城市
 北京市
 郑州市
 */
- (void)listPlacemark
{
    // 根据“北京市”进行地理编码
    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark1 = [placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark1 = [[MKPlacemark alloc]initWithPlacemark:clPlacemark1];
       
        //注意地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        [_geocoder geocodeAddressString:@"郑州市" completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *clPlacemark2 = [placemarks firstObject];//获取第一个地标
            MKPlacemark *mkPlacemark2 = [[MKPlacemark alloc] initWithPlacemark:clPlacemark2];
            NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
            //MKMapItem *mapItem1 = [MKMapItem mapItemForCurrentLocation];//当前位置
            
            MKMapItem *mapItem1 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1, mapItem2] launchOptions:options];
            
        }];
        
    }];
}

- (void)turnByTurn
{
    //根据“北京市”进行地理编码
    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *clPlacemark1=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark1=[[MKPlacemark alloc]initWithPlacemark:clPlacemark1];
        
        //注意地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        [_geocoder geocodeAddressString:@"郑州市" completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *clPlacemark2 = [placemarks firstObject];//获取第一个地标
            MKPlacemark *mkPlacemark2 = [[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
            
            // 标准地图   驾车模式
            NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
            
            //MKMapItem *mapItem1=[MKMapItem mapItemForCurrentLocation];//当前位置
            MKMapItem *mapItem1=[[MKMapItem alloc]initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
            
        }];
        
    }];
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
