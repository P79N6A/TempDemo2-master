//
//  DetailVC.m
//  FDFullscreenPopGestureLearn1
//
//  Created by xiaoyulong on 16/7/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor redColor];
    
    
    //  隐藏导航栏
    self.fd_prefersNavigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = YES;
    
    // 禁止滑动 针对这个 navigationController
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    
    // 针对这个viewController
    self.fd_interactivePopDisabled = NO;
    

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    self.navigationController.navigationBarHidden = NO;
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
