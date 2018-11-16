//
//  TestVC30.m
//  Animation
//
//  Created by yulong on 16/1/17.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC30.h"

@interface TestVC30 ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC30

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        _btn.frame = CGRectMake(100, 100, 100, 30);
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)click:(UIButton *)sender
{
    CATransform3D transform3D = CATransform3DMakeRotation(3.14 / 2.0, 0, 1, 1);
    [UIView animateWithDuration:4.0 animations:^{
        [_btn.layer setTransform:transform3D];
    } completion:^(BOOL finished) {
        
    }];
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
