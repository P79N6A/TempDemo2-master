//
//  TestVC10.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/9.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC10.h"

@interface TestVC10 ()

@end

@implementation TestVC10

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

- (void)onTap
{
    //取导航栏状态
    BOOL flag = self.navigationController.navigationBarHidden;
    flag = !flag;
    
    
    //导航栏
    [self.navigationController setNavigationBarHidden:flag animated:YES];
    
    
    
    /**
     第一种
     iOS 7.0以上时，访问状态栏，首先需要在xxx-Info.plist文件中加入
     View controller-based status bar appearance
     Boolen   NO  置位NO
     ios7.0 状态栏半透明 布局状态栏尺寸不计算在内
     */
//    [[UIApplication sharedApplication] setStatusBarHidden:flag withAnimation:UIStatusBarAnimationSlide];

    
    
    /**
     第二种
     iOS 7 以后，状态栏依赖于 UIViewController 了
     */
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden
{
    if (self.navigationController.navigationBarHidden) {
        return YES;
    }
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
