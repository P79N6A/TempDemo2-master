//
//  BVC.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2018/5/23.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "BVC.h"
#import "CVC.h"
#import "DVC.h"

@interface BVC ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation BVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"BVC";

    [self.view addSubview:self.btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(40, 100, 240, 40);
        [_btn setTitle:@"PUSH" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick:(UIButton *)sender
{
    DVC *controller = [[DVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
    NSMutableArray*tempMarr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    CVC *cVC = [[CVC alloc] init];
    
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self.navigationController.visibleViewController];
    
    
//    [tempMarr insertObject:cVC atIndex:index - 1];
//    [tempMarr removeObject:self]; //此时 的self 就是指 B ,因为在 B 中呢
    
    // 也可以用这个方法
    [tempMarr replaceObjectAtIndex:index-1 withObject:cVC];
    
    
//    [self.navigationController setViewControllers:tempMarr animated:NO];
    self.navigationController.viewControllers = tempMarr;
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
