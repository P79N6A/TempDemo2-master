//
//  RootViewController.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 100, 100)];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:imgView];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [imgView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)myTap:(UITapGestureRecognizer *)tap
{
    UIImageView * v = (UIImageView *)tap.view;
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.backgroundColor = [UIColor blackColor];
    // image传过来了
    imgView.image = v.image;
    imgView.contentMode = UIViewContentModeCenter;
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];

    UITapGestureRecognizer * myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTapReset:)];
    [imgView addGestureRecognizer:myTap];
    

    [UIView animateWithDuration:1.0 animations:^{
        [imgView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    } completion:nil];
}

- (void) myTapReset:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:1.0 animations:^{
        tap.view.alpha = 0;
        tap.view.frame = CGRectMake(0, 20, 100, 100);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [tap.view removeFromSuperview];
        }
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
