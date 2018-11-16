//
//  TestVC6.m
//  iOS7SlidePop
//
//  Created by xiaoyulong on 16/7/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC6.h"
#import "MLNavigationController.h"
#import "DetailVC6.h"

@interface TestVC6 ()

@end

@implementation TestVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailVC6 *ctl1 = [[DetailVC6 alloc] init];
    ctl1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
    MLNavigationController *nav1 = [[MLNavigationController alloc] initWithRootViewController:ctl1];
    nav1.title = @"Feature";
    
    
    DetailVC6 *ctl2 = [[DetailVC6 alloc] init];
    ctl2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    MLNavigationController *nav2 = [[MLNavigationController alloc] initWithRootViewController:ctl2];
    nav2.canDragBack = NO;
    nav2.title = @"More";

    self.viewControllers = @[nav1, nav2];

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
