//
//  Common_define.h
//  趣旅网
//
//  Created by xiaoyulong on 16/3/21.
//  Copyright © 2016年 junjun. All rights reserved.
//  功能描述：常用宏定义

#ifndef Common_define_h
#define Common_define_h


/***common**/
#import "AppDelegate.h"



#ifndef HKC_Common_define_h
#define HKC_Common_define_h


#define kDctype 7

#define kJoinHFPayAmount 9.90

// 这里配置是否需要为审核做配置:企业包不需要审核配置，非企业包需要审核配置
#define kIsForAppReview (!kIsEnterpriseBundle)
// 获取实际的一个状态[app是否处于审核状态]
#define GetIsAppReviewing ([[[NSUserDefaults standardUserDefaults] objectForKey:kIsAppReviewingKey] boolValue])

/********************** 常用宏 ****************************/
#pragma mark - 常用宏

/// 判断无网络情况
#define GetNetworkStatusNotReachable ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)

/// 当前版本号
#define GetCurrentVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

/// 当前app名称
#define GetAppName ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"])

/// 当前app delegate
#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// 获取queue
#define GetMainQueue dispatch_get_main_queue()
#define GetGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(weakSelf) strongSelf = weakSelf

#define kLocalizedString(key) NSLocalizedString(key, nil)

// url
#define URLWithString(str)  [NSURL URLWithString:str]

/// Height/Width
#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width
#define kScreenHeight       [UIScreen mainScreen].applicationFrame.size.height
#define kAllHeight          ([UIScreen mainScreen].applicationFrame.size.height + 20.0)
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)
#define kTabbarHeight       49
#define kSearchBarHeight    45
#define kStatusBarHeight    20
#define kNavigationHeight   44
#define ScreenMutiple (iPhone6?1.171875:(iPhone6plus?1.29375:1))

/// System判断
#define ISiPod      [[[UIDevice currentDevice] model] isEqual:@"iPod touch"]
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define ISiPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)


// end
#define ISIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) // IOS7的系统
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7的系统
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) // IOS8的系统
#define ISIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) // IOS9的系统

#define kHuiFenTeam kIsOnlineEnvironment?@140095:@192900


#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight

// 方便写接口
#define ParamsDic dic
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) [ParamsDic setObject:obj forKey:key]
#define DicValueSet(value,key) [ParamsDic setValue:value forKey:key]


#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

// DataManager && UserModel
#define GetDataManager [DataManager sharedManager]
#define GetDataUserModel [[DataManager sharedManager] userModel]
#define GetDataUid [[DataManager sharedManager].userModel.userId longLongValue]

/// 数值转字符串
#define kIntToString(intValue) ([NSString stringWithFormat:@"%@", @(intValue)])
#define kNumberToString(NumberValue) ([NSString stringWithFormat:@"%@", NumberValue])
#define StrToInt(str) [str integerValue]
#define StrToDouble(str) [str doubleValue]
#define DoubleStringFormat(str) [NSString stringWithFormat:@"%.2f", [str doubleValue]]

/********************** 数值 ****************************/
// 客服电话
#define kService_phone @"4006936588"
#define kService_phone_formatStr @"400-693-6588"



/********************** 标识 ****************************/

#pragma mark - 标识

#define kUserLoginAddressKey @"kUserLoginAddressKey"
#define IQKeyboardDistanceFromTextField 50

#define IMAGE_FOLDER @"ZDHImageFolder"
#define VIDEO_FOLDER @"ZDHVideoFolder"

//购物车刷新通知
#define RefreshShoppingCartData  @"RefreshShoppingCartData"

// 消息提醒设置
#define NewMessageNotifi      @"NewMessageNotifi"

// 铃声提醒 (个人聊天消息 与 群聊天消息)
#define MessageVoiceNotifi      @"MessageVoiceNotifi"

// 振动提醒 (个人聊天消息 与 群聊天消息)
#define MessageVibrationNotifi  @"MessageVibrationNotifi"

/********************** 图片 ****************************/

#pragma mark - 图片

/********************** ****************************/

// 手机号的框 四种情况组合输入框和cell的背景
#define kImage_LTSB [[UIImage imageWithName:@"longTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTLB [[UIImage imageWithName:@"longTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB [[UIImage imageWithName:@"noTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTLB [[UIImage imageWithName:@"noTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTSB2 [[UIImage imageWithName:@"longTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 70, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB2 [[UIImage imageWithName:@"noTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 2, 0) resizingMode:UIImageResizingModeStretch]

/********************** ****************************/
//  通用橙色确认按钮
//  按钮
#define kCommon_bt_normal @"common_bt_normal"
#define kCommon_bt_touchDown @"common_bt_touchDown"
#define kCommon_bt_disable @"common_bt_disable"

#define kImg_Common_bt_normal [[UIImage imageWithName:kCommon_bt_normal] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define kImg_Common_bt_touchDown [[UIImage imageWithName:kCommon_bt_touchDown] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define kImg_Common_bt_disable [[UIImage imageWithName:kCommon_bt_disable] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

// 图片
#define ImageWithName(name) [UIImage imageWithName:name]
#define ImageStretchWithName(name) [[UIImage imageWithName:name] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define ImageWithColor(color) [[UIImage imageWithColor:color andSize:CGSizeMake(10, 10)] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

#define kChatImageDirectory @"ChatImage"

//拉伸图片边框处理
#define kImageWithUIEdge(text) [[UIImage imageNamed:text] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

/********************** 标识 ****************************/

#pragma mark - 标识

#define IQKeyboardDistanceFromTextField 50

#define kSSToolkitTestsServiceName @"HKMUser"

#define kUserLoginAddressKey @"kUserLoginAddressKey"

//本地搜索历史记录
#define khistoryData          @"kHistoryData"
#define kHistoryShopListData          @"kHistoryShopListData"
#define kmerhistoryData       @"kmerhistoryData"

// 手机号的框 四种情况组合输入框和cell的背景
#define kImage_LTSB [[UIImage imageWithName:@"longTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTLB [[UIImage imageWithName:@"longTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB [[UIImage imageWithName:@"noTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTLB [[UIImage imageWithName:@"noTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTSB2 [[UIImage imageWithName:@"longTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 70, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB2 [[UIImage imageWithName:@"noTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 2, 0) resizingMode:UIImageResizingModeStretch]

#endif

#pragma mark - 颜色

/// 拉伸图片边框处理
#define kImageUIEdgeWithName(text) [[UIImage imageNamed:text] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

/// 图片，根据颜色设置
#define kImageWithColor(color) [UIImage imageWithColor:color andSize:CGSizeMake(1.0, 1.0)]

/// 获取图片
#define kImageWithName(text) [UIImage imageNamed:text]

/// 设置颜色
#define UIColorRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 设置颜色 示例：UIColorHexStr(@"#7b7b7b");
#define UIColorHexStr(hex)     [DataHelper colorWithHexString:hex]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]


// 假数据
#define FalseData(jsonString) [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]


#define firstCategoryWidth (AutoWHGetWidth(70))





#define HXWalletWebLogURL_KEY           @"HXWalletWebLogURL_KEY"
#define HXWalletDownload_KEY            @"HXWalletDownload_KEY"
#define HFAPPDownload_KEY               @"HFAPPDownload_KEY"
#define HKMALLDownload_KEY              @"HKMALLDownload_KEY"

#define SaveObjToUserDefaults(obj,key)  [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]

// 惠粉App在AppStore审核状态   YES,表示审核中，NO,表示审核通过
#define AppStoreReViewStatu             @"AppStoreReViewStatu"

#define SaveBOOLToUserDefaults(bool,key)  [[NSUserDefaults standardUserDefaults] setBool:bool forKey:key]
#define GetBoolFromUserDefaults(key)      [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define synUserDefaults                   [[NSUserDefaults standardUserDefaults] synchronize]

// app Logo
#define TimeStr                 [TimeUtil getDate:[NSDate date] withFormat:@"yyyyMMddHHmmss"]


#define kRegex_emo_all @".*(\\[[\\u4e00-\\u9fa5]+\\]$)"   //表情删除匹配
#define kRegex_emo     @"(\\[[\\u4e00-\\u9fa5]+\\])"      //表情匹配
//-----------------------------惠粉----------------------------



// 定义是否打开指定app
#define CanOpenAppURL(urlScheme) [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlScheme]]

// 定义开发指定app
#define OpenAppURL(urlScheme) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlScheme]]

//不使用webrtc 请注释掉以下行代码
#define kUse_WebRTC
#define kWebRTCLogoutNotifi     @"hkmall.kWebRTCLogoutNotifi"

#define kSmallImgUrlSize        @"240x240"
#define kSmallImgUrl(imageUrl)        [UserModel smallImgUrl:imageUrl]

///
#define AppBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#endif /* Common_define_h */
