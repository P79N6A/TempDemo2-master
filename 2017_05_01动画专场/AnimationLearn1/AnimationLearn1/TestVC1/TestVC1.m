//
//  TestVC1.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()
{
    // 定时器
    NSTimer * _timer;
}
@end

@implementation TestVC1

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;

//    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 2; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(270*i, 20+410*i, 50, 50)];
        if (i == 0)
        {
            imgView.image = [UIImage imageNamed:@"pic"];
        }
        else
        {
            imgView.image = [UIImage imageNamed:@"rubbish"];
        }
        imgView.tag = 100+i;
        imgView.userInteractionEnabled = YES;
        [self.view addSubview:imgView];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [imgView addGestureRecognizer:tap];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onTap:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 100)
    {
        /*
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDelay:1.0];
         [UIView setAnimationDuration:1.0];
         tap.view.frame = CGRectMake(320, 480, 5, 5);
         [tap.view removeFromSuperview];
         [UIView commitAnimations];
         // 动画完毕后调用某个方法
         
         //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
         */
        
        [UIView animateWithDuration:1.0 animations:^{
            tap.view.frame = CGRectMake(320, 480, 5, 5);
        } completion:^(BOOL finished) {
            if (finished)
            {
                [tap.view removeFromSuperview];
                UIImageView *imgView = (UIImageView *)[self.view viewWithTag:101];
                imgView.image = [UIImage imageNamed:@"2"];
            }
        }];
    }
    else
    {
        if ([_timer isValid])
        {
            [_timer invalidate];
            _timer = nil;
        }
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(shark) userInfo:nil repeats:YES];
    }
}


int count = 0;
- (void) shark
{
    //旋转
    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:101];
    imgView.transform = CGAffineTransformMakeRotation(30*M_PI/180);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    if (count % 2)
    {
        /*
         实现UIView 的旋转 缩放 平移 需要访问UIView 的transform属性
         */
        imgView.transform = CGAffineTransformMakeRotation(10*M_PI/180);
    }
    else
    {
        imgView.transform = CGAffineTransformMakeRotation(-10*M_PI/180);
    }
    
    [UIView commitAnimations];
    
    count++;
    
    //摇动3次停止
    if (count > 6)
    {
        if ([_timer isValid])
        {
            [_timer invalidate];
            _timer = nil;
            
            //图片复原
            imgView.transform = CGAffineTransformIdentity;
            imgView.image = [UIImage imageNamed:@"rubbish"];
            count = 0;
        }
    }
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
