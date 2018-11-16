//
//  TestVC9.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/9.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC9.h"
#import "DetailVC9.h"

@interface TestVC9 ()

@end

@implementation TestVC9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailVC9 *detailVC = [[DetailVC9 alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    [self presentViewController:nav animated:YES completion:^{
    }];
    
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
