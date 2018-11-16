//
//  TestVC2.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    
    [UIView animateWithDuration:3 animations:^{
        view.frame = CGRectMake(100, 300, 100, 80);
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0.3;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:3 animations:^{
                view.transform = CGAffineTransformMakeRotation(-M_PI_2);
            } completion:^(BOOL finished) {
            }];
        }
    }];
    

    
    [UIView animateWithDuration:5 animations:^{
        view.transform = CGAffineTransformMake(1, 0, -0.5, 1, 0, 1);
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
