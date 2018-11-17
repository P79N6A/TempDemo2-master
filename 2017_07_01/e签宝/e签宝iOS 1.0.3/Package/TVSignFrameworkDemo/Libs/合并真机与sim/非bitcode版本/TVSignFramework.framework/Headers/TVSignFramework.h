//
//  TVSignFramework.h
//  TVSignFramework
//
//  Created by wz on 16/5/11.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#ifndef TVSignFramework_h
#define TVSignFramework_h

#import <UIKit/UIKit.h>
#import "TVSignProtocol.h"
#import "TVSignTypes.h"

// 当前framework版本，仅用于标注
#define TV_SIGN_IOS_FRAMEWORK_VERSION 1.0.3

@interface TVSignFramework : NSObject

/*!
 @method 设置项目配置信息
 @param  _projectId      项目编号
 @param  _projectSecret  项目密钥
 */
+ (void)setAppProjectId:(NSString*)_projectId
          projectSecret:(NSString*)_projectSecret;

/*!
 @method 设置项目配置信息
 @param  _projectId         项目编号
 @param  _projectSecret     项目密钥
 @param  _serverEnviroment  服务器环境 0-正式 1-测试 2-模拟
 */
+ (void)setAppProjectId:(NSString*)_projectId
          projectSecret:(NSString*)_projectSecret
       serverEnviroment:(NSInteger)_serverEnviroment;

/*!
 @method 手绘返回印章（快捷签接口）
 @param  _ctrl          用于跳转视图
 @param  _accountUid    用户uid
 @param  _signProtocol  回调
 */
+ (void)tvSignCtrl:(UIViewController*)_ctrl
        accountUid:(NSString*)_accountUid
      signProtocol:(id<TVSignProtocol>)_signProtocol;


/*!
 @method 手绘返回印章 add at v1.0.2
 @param  _type          界面显示
 @param  _ctrl          用于跳转视图
 @param  _accountUid    用户uid
 @param  _signProtocol  回调
 */
+ (void)tvSignCtrlWithType:(TVSignCtrlType)_type
                      ctrl:(UIViewController*)_ctrl
                accountUid:(NSString*)_accountUid
              signProtocol:(id<TVSignProtocol>)_signProtocol;

@end

#endif /* TVSignFramework_h */
