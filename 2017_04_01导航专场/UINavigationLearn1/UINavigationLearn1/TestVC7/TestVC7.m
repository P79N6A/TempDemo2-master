//
//  TestVC7.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC7.h"

@interface TestVC7 ()

@end

@implementation TestVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBarButtonItemClick)];
    
    self.navigationItem.title = [NSString stringWithFormat:@"第%@层", @(self.navigationController.viewControllers.count)];
    
    NSLog(@"self.navigationController.viewControllers.count==%@", @(self.navigationController.viewControllers.count));
    
    NSLog(@"self.navigationController.childViewControllers.count==%@", @(self.navigationController.childViewControllers.count));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onRightBarButtonItemClick
{
    TestVC7 *root = [[TestVC7 alloc] init];
    [self.navigationController pushViewController:root animated:YES];
    
    /*
     第几层就没有错了。
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
