//
//  Common_define.h
//  DataHelper
//
//  Created by yulong on 15/12/14.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//

#ifndef Common_define_h
#define Common_define_h

/***common**/
#import "AppDelegate.h"
#import "Common_color.h"
#import "Common_font.h"
#import "Common_limit.h"
#import "Common_time.h"
#import "Common_Markwords.h"
#import "NetConfigure.h"
#import "AutoSizeCGRect.h"
//#import "DataHelper.h"



/********************** app环境 ****************************/
#pragma mark - app环境，0开发或1发布

// 是否是企业包 0=非企业包(com.365sji.HKUniversal) 1=企业包(com.365sji.EnterpriseHKUniversal)
#define kIsEnterpriseBundle [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.365Thail.DealOnTo"]

#define isTrueEnvironment 0
#if isTrueEnvironment
#define kServerHost         [NetConfigure getPublicNetwork]
#else
#define kServerHost         [NetConfigure getDefaultNetwork]
#endif

//是否是正式环境，预生成算正式，与IM环境一致
#define kIsOnlineEnvironment ((NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkService"]).intValue

#define kDctype 7

#define kJoinHFPayAmount 9.90

// 这里配置是否需要为审核做配置:企业包不需要审核配置，非企业包需要审核配置
#define kIsForAppReview (!kIsEnterpriseBundle)
// 获取实际的一个状态[app是否处于审核状态]
#define GetIsAppReviewing ([[[NSUserDefaults standardUserDefaults] objectForKey:kIsAppReviewingKey] boolValue])

#define kHuiFenTeam kIsOnlineEnvironment?@140095:@192900

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
#define kBlockSelf __strong __typeof__(self) blockSelf = weakSelf

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

/// 分类下拉框
#define kComboxListHeight kBodyHeight - kTabbarHeight - kComboxViewHeight- 88 //combox下拉框距tabbar上部88
#define kComboxViewHeight 75/2 //combox的高度

/// System判断
#define ISiPod      [[[UIDevice currentDevice] model] isEqual:@"iPod touch"]
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define ISiPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
// end

#define ISIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) // IOS6和其以上的系统
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7和其以上的系统
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) // IOS8和其以上的系统
#define ISIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) // IOS9和其以上的系统


#define ISIOSSYSTEM [[[UIDevice currentDevice] systemVersion] floatValue]

#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight


// 方便写接口
#define ParamsDic dic
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) [ParamsDic setObject:obj forKey:key]
#define DicValueSet(value,key) [ParamsDic setValue:value forKey:key]


// 如果release状态就不执行NSLog函数
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

// DataManager && UserModel
#define GetDataManager [DataManager sharedManager]
#define GetDataUserModel [[DataManager sharedManager] userModel]


/// 数值转字符串
#define kIntToString(intValue) ([NSString stringWithFormat:@"%@", @(intValue)])
#define StrToInt(str) [str integerValue]
#define StrToDouble(str) [str doubleValue]
#define DoubleStringFormat(str) [NSString stringWithFormat:@"%.2f", [str doubleValue]]

/********************** 数值 ****************************/

/********************** 标识 ****************************/

#pragma mark - 标识

#define kSSToolkitTestsServiceName @"TOOKTLOOK_M_U_User"

#define IQKeyboardDistanceFromTextField 50



/********************** 图片 ****************************/

#pragma mark - 图片

// 手机号的框 四种情况组合输入框和cell的背景
#define kImage_LTSB [[UIImage imageNamed:@"longTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTLB [[UIImage imageNamed:@"longTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB [[UIImage imageNamed:@"noTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTLB [[UIImage imageNamed:@"noTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTSB2 [[UIImage imageNamed:@"longTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 70, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB2 [[UIImage imageNamed:@"noTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 2, 0) resizingMode:UIImageResizingModeStretch]

// 图片
#define ImageWithName(name) [UIImage imageWithName:name]
#define ImageStretchWithName(name) [[UIImage imageWithName:name] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define ImageWithColor(color) [[UIImage imageWithColor:color andSize:CGSizeMake(10, 10)] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

/********************** ****************************/


/********************** 国际化 ****************************/

//#define kLocalizedString(key) NSLocalizedString(key, nil)

#define kLocalizedString(key) HKLocalizedStringFromTable(key, @"Localizable")

#define kLocalizedStringFromTable(key, tbl) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:(key) table:(tbl)]

#define kCurrentLanguage [[HKLanguageTools shareInstance] defineUserLanguage]
#define kCurrentLanguageNumber [[HKLanguageTools shareInstance] defineUserLanguageNumber]

/// 多语言文件
#define tableLocalizable @"Localizable"

#define MoneyTai @"฿" // 泰国货币
//#define MoneyTai @"บาท" // 泰国货币


#define documentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define libraryPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
#define cachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define tempPath NSTemporaryDirectory()


#endif /* Common_define_h */
















