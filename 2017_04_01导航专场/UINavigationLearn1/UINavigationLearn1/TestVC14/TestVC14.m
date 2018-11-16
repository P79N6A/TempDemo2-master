//
//  TestVC14.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC14.h"

@interface TestVC14 ()

@end

@implementation TestVC14

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demo1
{
    /**
     
     
     UINavigationController:管理UIView使用视图控制器 管理视图控制器
     UINavigationController切换 push... pop...
     以栈的形式管理UIViewController
     
     UIViewController切换 presentViewController/ dismiss...
     UIViewController管理UIView：ctl.view 当前页面的所有UIView都是添加在ctl.view上
     
     
     与导航控制器的层级关系相关
     UIBarButtonItem:一类特殊的按钮类 放在导航栏 工具栏上
     
     UINavigationItem:定制当前ctl导航栏上的按钮标题
     leftBarButtonItem + title（定制使用titleView）+ rightBarButtonItem + backBarButtonItem(下一个ctl的leftBarButtonItem位置)
     
     UINavigationController:UINavigationBar + ctl.view + UIToolBar
     
     UINavigationController.view:UINavigationTransitionView(320*480) + UINavigationBar(320*44)
     
     

     */
    
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
