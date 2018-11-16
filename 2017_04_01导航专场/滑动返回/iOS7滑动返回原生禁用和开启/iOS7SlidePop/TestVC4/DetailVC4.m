//
//  DetailVC4.m
//  iOS7SlidePop
//
//  Created by xiaoyulong on 16/7/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC4.h"
#import "ParentNavController.h"

@interface DetailVC4 ()

@end

@implementation DetailVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor redColor];
    
    
    
    ParentNavController *baseNav = (ParentNavController *) self.navigationController;
    // 默认可以滑动返回的
    baseNav.isCanSlideBack = YES;

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
