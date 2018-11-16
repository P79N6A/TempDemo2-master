//
//  TestVC2.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 可以改变导航栏 自带的左侧 右侧的按钮字体的颜色
     self.navigationController.navigationBar.tintColor = [UIColor yellowColor];

    // 可以改变导航栏颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];

    // 字体变成了黄色
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
//    [UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:<#(nullable SEL)#>
    
//    [UIBarButtonItem alloc] initWithImage:<#(nullable UIImage *)#> landscapeImagePhone:<#(nullable UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(nullable id)#> action:<#(nullable SEL)#>
    
    
//    [UIBarButtonItem alloc] initWithImage:<#(nullable UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(nullable id)#> action:<#(nullable SEL)#>

    // 自定义导航按钮
//    [UIBarButtonItem alloc] initWithCustomView:<#(nonnull UIView *)#>
    
    
//    self.navigationItem.rightBarButtonItems
//    self.navigationItem.leftBarButtonItem
//    self.navigationItem.leftBarButtonItems
    
    // 如果设置了  self.navigationItem.leftBarButtonItems，就会覆盖原来的 self.navigationItem.backBarButtonItem
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClick
{
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:controller animated:YES];

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
