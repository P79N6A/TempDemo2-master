//
//  AppDelegateBaiduMapHelper.m
//  BaiduMap
//
//  Created by xiaoyulong on 2018/6/3.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "AppDelegateBaiduMapHelper.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegateBaiduMapHelper () <BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegateBaiduMapHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureBaiduMap];
    }
    return self;
}

- (void)configureBaiduMap
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"7lgeyzLtTeiNYIWGGhrcRWyg" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

#pragma mark - BMKGeneralDelegate

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
        /**
         http://lbsyun.baidu.com/index.php?title=lbscloud/api/appendix
         最下面有控制服务返回码状态码含义
         
         204 APP 服务被禁用    用户在API控制台中创建或设置某APP的时候禁用了某项服务
         */
    }
}

@end
