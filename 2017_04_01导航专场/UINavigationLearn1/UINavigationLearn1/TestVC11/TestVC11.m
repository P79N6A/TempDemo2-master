//
//  TestVC11.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC11.h"

@interface TestVC11 ()

@end

@implementation TestVC11

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self demo1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demo1
{
    self.navigationController.toolbarHidden = NO;
    // 给toolBar添加按钮
    UIBarButtonItem * toolBar1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    UIBarButtonItem * toolBar2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    UIBarButtonItem * toolBar3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:nil action:nil];
    UIBarButtonItem * toolBar4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    UIBarButtonItem * toolBar5 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    
    
    self.toolbarItems = @[toolBar1,toolBar2,toolBar3,toolBar4,toolBar5];
    
    NSLog(@"toolBar is %@",self.navigationController.toolbar);
    
    // <UIToolbar: 0x7fde2d50e9b0; frame = (0 623; 375 44); opaque = NO; autoresize = W+TM; layer = <CALayer: 0x600000026ca0>>


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
