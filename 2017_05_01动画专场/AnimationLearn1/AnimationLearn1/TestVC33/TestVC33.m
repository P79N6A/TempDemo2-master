//
//  TestVC33.m
//  AnimationLearn1
//
//  Created by xiaoyulong on 2017/6/6.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC33.h"
#import "DetailVC33.h"

@interface TestVC33 ()

@end

@implementation TestVC33

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailVC33 *detailVC = [[DetailVC33 alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
