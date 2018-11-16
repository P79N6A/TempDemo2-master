//
//  Factory.h
//  BaseProject
//
//  Created by tarena on 15/11/17.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject
/** 向控制器添加菜单按钮 */
+(void)addMenuItemToVC:(UIViewController *)vc;

/** 向控制器添加收藏按钮 */
+(void)addCollectItemToVC:(UIViewController *)vc newsPicURL:(NSURL *)picURL newsURL:(NSURL *)url newsTitle:(NSString *)title;

/** 向控制器添加返回按钮 */
+(void)addBackItemToVc:(UIViewController *)vc;
@end
