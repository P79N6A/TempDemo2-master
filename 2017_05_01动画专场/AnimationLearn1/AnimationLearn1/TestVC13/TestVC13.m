//
//  TestVC13.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC13.h"

@interface TestVC13 () <CAAnimationDelegate>

@end

@implementation TestVC13

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgView.image = [UIImage imageNamed:@"qdy"];
    [self.view addSubview:bgView];
    
    UIImageView *bgView01=[[UIImageView alloc]initWithFrame:self.view.frame];
    if([UIScreen mainScreen].bounds.size.height > 480)
    {
        bgView01.image=[UIImage imageNamed:@"加载320.jpg"];
    }
    else
    {
        bgView01.image=[UIImage imageNamed:@"qdy02"];
    }
    
    [self.view addSubview:bgView01];
    
    
    UIImageView *rotateView=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-187/2, [UIScreen mainScreen].bounds.size.height/2-100, 187, 187)];
    rotateView.image=[UIImage imageNamed:@"loading01"];
    [self.view addSubview:rotateView];
    
    
    UIImageView *bgView02=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-70, [UIScreen mainScreen].bounds.size.height/2-40, 140, 80)];
    bgView02.image=[UIImage imageNamed:@"loding_text"];
    [self.view addSubview:bgView02];
    
    
    //旋转
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:0];
    shake.toValue = [NSNumber numberWithFloat:-2*M_PI];
    shake.duration = 3.0;
    shake.autoreverses = NO;
    shake.repeatCount = 1;
    shake.delegate = self;
    [rotateView.layer addAnimation:shake forKey:@"shakeAnimation"];
    rotateView.alpha = 1.0;
}

#pragma mark - 按钮响应事件



#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
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
