//
//  TestVC4.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 修改导航栏标题
    
    self.navigationItem.title = @"时尚是什么";

    self.title = @"设置";
    
    
    /**
     self.title是控制器默认 view 的title
     self.navigationItem.title 是显示在navgationbar的中间。
     
     换言之self.title 设置了，不论在哪种控制器里面，都会优先显示self.title。
     要是没有设置，可以根据在 NavigationController 设置 navigationItem.title，
     或者在 TabbarController 设置 tabBarItem.title；
     */
    /**
     我查了一些资料:
     1.当self.navigationItem.title，self.tabBarItem.title没有赋值情况下值和self.title一致。
     2.UINavigationItem是UINavigationBar的SubView,可以设置title和左右导航栏按钮。
     */
    
    NSLog(@"self.navigationItem.title==%@", self.navigationItem.title);
    NSLog(@"self.title==%@", self.title);
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
