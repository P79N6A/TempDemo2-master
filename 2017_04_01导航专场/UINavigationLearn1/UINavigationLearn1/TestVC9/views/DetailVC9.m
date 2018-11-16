//
//  DetailVC9.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/9.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DetailVC9.h"

@interface DetailVC9 ()

@end

@implementation DetailVC9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
    
    //1.定制导航栏背景图片
    /*
     第二个参数 指定是横屏还是竖屏
     UIBarMetricsDefault,竖屏
     UIBarMetricsLandscapePhone,横屏
     */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarBg"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    //2.定制工具栏背景图片，工具栏默认是隐藏的
    self.navigationController.toolbarHidden = NO;
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"toolBarBg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    
    //3.定制分栏背景图片
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBarBg"]];
    
    
    
    /**
     在这里写就是这样写
     
     1.定制导航栏背景图片
     [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"1.png"] forBarMetrics:UIBarMetricsDefault];
     
     2.定制工具栏背景图片，工具栏默认是隐藏的
     nav.toolbarHidden = NO;
     [nav.toolbar setBackgroundImage:[UIImage imageNamed:@"3.png"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
     
     3.定制分栏背景图片
     [tabBarCtl.tabBar setBackgroundImage:[UIImage imageNamed:@"2.png"]];
     
     */
    
    
    
    /* 状态栏
     * (320 * 20)
     */
    
    NSLog(@"状态栏==(%f, %f)", [UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height);
    /*=======================================================*/
    
    
    
    /*
     * 导航栏
     * (320 * 44)
     */
    NSLog(@"(%f, %f)", self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    /*=======================================================*/
    
    
    /*
     * 导航控制器的  工具栏  默认是隐藏的
     * (320 * 44)
     */
    
    self.navigationController.toolbarHidden = NO;
    NSLog(@"(%f, %f)", self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.frame.size.height);
    
    /*=======================================================*/
    
    
    /* 分栏控制器的分栏
     * (320 * 49)
     */
    //    NSLog(@"(%f, %f)", self.tabBar.frame.size.width, tabBarCtl.tabBar.frame.size.height);
    
    /*=======================================================*/
    

    
    
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
