//
//  TestVC7.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC7.h"

@interface TestVC7 ()

@end

@implementation TestVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 250, 300)];
    imgView.tag = 102;
    imgView.center = CGPointMake(160, 240);
    imgView.image = [UIImage imageNamed:@"1.png"];
    /****************************/
    // 默认UIImageView无法接受手势
    imgView.userInteractionEnabled = YES;
    /****************************/
    [self.view addSubview:imgView];
    
    
    
    
    // 点击手势
    // 只要是UIView都可以添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    // 默认是单击手势
    // 双击手势
    tap.numberOfTapsRequired = 2;
    // 添加手势
    [imgView addGestureRecognizer:tap];
    
    
    NSLog(@"%f %f",imgView.frame.origin.x,imgView.frame.origin.y);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

bool flag = YES;
- (void) myTap:(UITapGestureRecognizer *)tap
{
    //手势作用的UIView传递下来
    NSLog(@"%@", tap.view);
    
    //可以将当前手势作用的位置传递下来,参数是哪个视图，就转化为哪个视图的坐标
    CGPoint point = [tap locationInView:tap.view];
    NSLog(@"point (%f, %f)", point.x, point.y);
    
    //    [UIView beginAnimations:nil context:NULL];
    //    //设置动画的持续时间
    //    [UIView setAnimationDuration:0.5];
    //    if (flag)
    //    {
    //        tap.view.frame = CGRectMake(0, 0, 320, 480);
    //        //置于最顶层
    //        [self.view bringSubviewToFront:tap.view];
    //    }
    //    else
    //    {
    //        tap.view.frame = CGRectMake(35, 90, 250, 300);
    //    }
    //
    //    flag = !flag;
    //    [UIView commitAnimations];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        if (flag)
        {
            tap.view.frame = CGRectMake(0, 0, 320, 480);
            //置于最顶层
            [self.view bringSubviewToFront:tap.view];
        }
        else
        {
            tap.view.frame = CGRectMake(35, 90, 250, 300);
        }
    } completion:^(BOOL finished) {
        if (finished)
        {
            flag = !flag;
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
