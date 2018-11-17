//
//  AppDelegate.h
//  TVSignLearn1
//
//  Created by xiaoyulong on 2017/6/30.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIGN_SERVER_ENVIROMENT 0


// 生产
//#define eSignBaoProjectId @"1111564319"
//#define eSignBaoProjectSecret @"a3b013306da7ce6962a6bd3d9e5c2654"



// 测试
#define eSignBaoProjectId @"1111563517"
#define eSignBaoProjectSecret @"95439b0863c241c63a861b87d1e647b7"


/*
 sim 中的framework 可以在模拟器中运行，不能在真机上运行；
 
 
 因为 趣旅app中使用的是 bitcode 的为NO，
 所以我们用 合并真机与sim 文件夹下的 非bitcode版本，就可以在真机和模拟器中都能运行了。
 
 需添加库
 AVFoundation.framework
 GLKit.framework
 libstdc++.tbd
 libresolv.tbd
 */


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

