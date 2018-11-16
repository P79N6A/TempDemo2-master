//
//  DetailVC1.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DetailVC1.h"

@interface DetailVC1 ()

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIButton *btn;


@end

@implementation DetailVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    
    [self.view addSubview:self.btn];

}


#pragma mark - 按钮响应事件

- (void)backBtnClick:(UIButton *)sender
{
    NSLog(@"DetailVC1 viewControllers==%@", self.navigationController.viewControllers);

    
    if (self.navigationController.viewControllers.count == 3)
    {
        // 遇到某一类 则跳出。
    //        for (UIViewController *ctl in self.navigationController.viewControllers)
    //        {
    //            if ([ctl isKindOfClass:[RootViewController class]])
    //            {
    //                [self.navigationController popToViewController:ctl animated:YES];
    //            }
    //        }
        
        
        
        // 获取当前 controller 在栈中是第几个。
//        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self.navigationController.visibleViewController];
        
        /**
         或者需要返回到上一层的上一层
         */
        UIViewController *ctl = nil;
        if (self.navigationController.viewControllers.count >= 3) {
            ctl = self.navigationController.viewControllers[index-2];
        }
        
        
        [self.navigationController popToViewController:ctl animated:YES];
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)btnClick:(UIButton *)sender
{
    DetailVC1 *controller = [[DetailVC1 alloc] init];
    controller.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:controller animated:YES];
    
    //    for (UIViewController *controller in self.navigationController.viewControllers) {
    //        if ([controller isKindOfClass:[TestVC1 class]]) {
    //            [self.navigationController.viewControllers remove];
    //        }
    //    }
    
    NSLog(@"viewControllers==%@", self.navigationController.viewControllers);
    [self removeFromParentViewController];
    NSLog(@"后viewControllers==%@", self.navigationController.viewControllers);
    
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)backBtn
{
    if (_backBtn == nil)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, 40, 40);
        _backBtn.backgroundColor = [UIColor yellowColor];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
