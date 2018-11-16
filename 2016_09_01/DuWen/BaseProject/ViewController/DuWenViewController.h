//
//  DuWenViewController.h
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "WMPageController.h"

/** 
    WMPageController 网易首页控制翻页效果的三方库
    可以将任意控制器加到PageController中
 */

@interface DuWenViewController : WMPageController
/** 内容页的首页是单例的，每次进程值初始化一次 */
+(DuWenViewController *)standard;
+(UINavigationController *)standatdNavi;
@end
