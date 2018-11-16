//
//  Common_Markwords.h
//  DataHelper
//
//  Created by yulong on 15/12/14.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//  功能描述：常用提示语

#ifndef Common_Markwords_h
#define Common_Markwords_h


/********************** message ****************************/

#pragma mark - 提示语

#pragma mark 弹出视图提示语

#define AlertTitle @"温馨提示"
#define AlertCancel @"取消"
#define AlertExit @"退出"
#define AlertConfirm @"确定"
#define AlertClose @"关闭"
#define AlertUpgrade @"去升级"
#define AlertUpDate @"立即更新"

#pragma mark 网络交互提示语

#define kNetworkWithoutInternet @"网络异常，请检查网络！"
#define kNetworkWithoutData @"暂无数据"
#define kNetworkWithoutInvestmentData @"暂无可投资项目"
#define kNetworkLoading @"加载中..."
#define kNetworkLoadFailed @"加载失败"
#define kNetworkSaveFailed @"保存失败"
//#define kNetworkWaitting @"请稍候..."
#define kNetworkWaitting HKLocalizedStringFromTable(@"请稍候...", tableLocalizable)


#define kAccountLogining @"登录..."
#define kAccountLoginSuccess @"登录成功！"
#define kAccoutRegistering @"注册中..."
#define kAccountRegisterSuccsee @"注册成功！"

/********************** message ****************************/


#endif /* Common_Markwords_h */
