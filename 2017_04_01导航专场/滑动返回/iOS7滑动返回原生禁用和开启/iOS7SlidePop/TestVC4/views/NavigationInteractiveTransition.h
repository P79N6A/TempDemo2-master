//
//  NavigationInteractiveTransition.h
//  slidePop
//
//  Created by yulong on 15/5/8.
//  Copyright (c) 2015年 HuiXin. All rights reserved.
//  专门处理交互对象

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NavigationInteractiveTransition : NSObject <UINavigationControllerDelegate>

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;


- (instancetype)initWithViewController:(UIViewController *)vc;

@end
