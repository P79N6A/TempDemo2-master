//
//  TestVC8.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC8.h"

@interface TestVC8 ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end

@implementation TestVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick:(UIButton *)sender
{
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:controller animated:YES completion:^{
    }];
    
    // 消失时对应的是 dismiss
}

- (void)btn3Click:(UIButton *)sender
{
    // 也可以 present 出 tabBarControler 的控制器
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor yellowColor];
    controller.title = @"ctl1";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];

    
    
    UIViewController *controller2 = [[UIViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav, controller2];
    
    [self presentViewController:tabBarController animated:YES completion:^{
    }];
}

- (void)btn2Click:(UIButton *)sender
{
    // 也可以 present 出带导航栏的
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor yellowColor];
    controller.title = @"ctl1";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(40, 100, 240, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIButton *)btn2
{
    if (_btn2 == nil)
    {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.backgroundColor = [UIColor yellowColor];
        _btn2.frame = CGRectMake(40, _btn.frame.origin.y + _btn.frame.size.height + 60, 240, 40);
        [_btn2 setTitle:@"标题2" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (UIButton *)btn3
{
    if (_btn3 == nil)
    {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.backgroundColor = [UIColor yellowColor];
        _btn3.frame = CGRectMake(40, _btn2.frame.origin.y + _btn2.frame.size.height + 60, 240, 40);
        [_btn3 setTitle:@"标题3" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
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
