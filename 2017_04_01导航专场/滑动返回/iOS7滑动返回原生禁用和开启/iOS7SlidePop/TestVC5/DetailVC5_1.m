//
//  DetailVC5_1.m
//  iOS7SlidePop
//
//  Created by xiaoyulong on 16/7/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC5_1.h"
#import "BaseNavController.h"

@interface DetailVC5_1 ()

@end

@implementation DetailVC5_1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情2";
    self.view.backgroundColor = [UIColor blueColor];
    
    BaseNavController *baseNav = (BaseNavController *) self.navigationController;
    // 默认可以滑动返回的，开启不能滑动的
    baseNav.isCanSlideBack = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
