//
//  RootViewController.m
//  UINavigationLearn3
//
//  Created by xiaoyulong on 2017/7/16.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.view addGestureRecognizer:myTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 导航栏
    UIImage *image = [self imageWithColor:[[UIColor orangeColor] colorWithAlphaComponent:1.0]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}


- (void)onTap
{
    //取导航栏状态
    BOOL flag = self.navigationController.navigationBarHidden;
    flag = !flag;
    
    
    //导航栏
    [self.navigationController setNavigationBarHidden:flag animated:YES];

    
    // iOS 7 之前都是全局的
    /**
     第一种
     iOS 7.0以上时，访问状态栏，首先需要在xxx-Info.plist文件中加入
     View controller-based status bar appearance
     Boolen   NO  置位NO
     ios7.0 状态栏半透明 布局状态栏尺寸不计算在内
     */
    
    // 白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UIApplication sharedApplication] setStatusBarHidden:flag withAnimation:UIStatusBarAnimationSlide];
    
    
}

//// 控制状态栏是否隐藏
//- (BOOL)prefersStatusBarHidden
//{
//    if (self.navigationController.navigationBarHidden) {
//        return YES;
//    }
//    return NO;
//}
//
//// 控制状态栏的动画
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
//{
//    return UIStatusBarAnimationSlide;
//}
//
//// 控制状态栏的样式
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    // 黑色
//    // UIStatusBarStyleDefault
//
//    // 白色 ，没有变色是系统的bug
//    return UIStatusBarStyleLightContent;
//}
//


- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
