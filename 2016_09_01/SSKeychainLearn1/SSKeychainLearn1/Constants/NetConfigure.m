//
//  NetConfigure.m
//  PinMall
//
//  Created by YangXu on 14/12/29.
//  Copyright (c) 2014年 365sji. All rights reserved.
//

#import "NetConfigure.h"

static NSString *const keyNetwork = @"keyNetwork";

static NSString *const IMNetwork = @"NetworkService";

/// 真实环境
#define NetworkTrue @"api.dealontop.com"
//http://api.dealontop.com/

/// 测试环境
//#define NetworkTest   @"192.168.17.236:9090"
#define NetworkTest   @"192.168.18.83:9090"

#define NetworkTestEnviroments @[NetworkTest,NetworkTrue]
#define NetworkTestIMStatus @[@0,@1]

@implementation NetConfigure

+(void)initNetConfigure
{
    if (isTrueEnvironment) {
        [self setNetCfgType:NetCfgType_True];
    }else{
        [self getNetCfgType];
    }
}

/// 设置网络环境
+ (void)setNetCfgType:(NetCfgType)type
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(type) forKey:keyNetwork];
    [userDefaults synchronize];
}

+ (void)setTestEnviro:(NSString *)enviro
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:enviro forKey:keyNetwork];
    
    [userDefaults synchronize];
}

/// 获取网络环境
+ (NetCfgType)getNetCfgType
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *netType = [userDefaults objectForKey:keyNetwork];
    if (netType == nil) {
        //设置默认网络环境
        NetCfgType defaultType = NetCfgType_Test;
        [self setNetCfgType:defaultType];
        return defaultType;
    }
    return [netType intValue];
}

+ (NSString *)getEnviro
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *netStr = [userDefaults objectForKey:keyNetwork];
    if (nil == netStr) {
        [self setNetCfgType:NetCfgType_Test];
        return NetworkTest;
    }
    
    return netStr;
}

/// 获取当前网络环境设置
+ (NSString *)getDefaultNetwork
{
    // 根据设置返回
    return NetworkTestEnviroments[[self getNetCfgType]];
}

/// 获取发布网络环境设置
+ (NSString *)getPublicNetwork
{
    return NetworkTrue;
}

///获取测试环境地址
+ (NSString *)getTestNetwork
{
    return NetworkTest;
}

+ (NSArray *)getTestNetworkEnviroments
{
    return NetworkTestEnviroments;
}

@end
