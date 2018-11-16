//
//  TestVC14.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC14.h"

@interface TestVC14 ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC14

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.btn];
    
    
    UIImage *img = [UIImage imageNamed:@"time_count"];
    NSLog(@"img宽高 %f,  %f,  ", img.size.width, img.size.height);
    
    
    [self createView1];
    
    //    [self createView2];
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
        _btn.frame = CGRectMake(100, 30, 100, 30);
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)createView2
{
    self.imgView = [[UIImageView alloc] init];
    self.imgView.frame = CGRectMake(100, 100, 100, 100);
    self.imgView.backgroundColor = [UIColor clearColor];
    self.imgView.image = [UIImage imageNamed:@"time_count.png"];
    [self.view addSubview:self.imgView];
    
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,0,1)],
                           nil];
    theAnimation.cumulative = YES;
    theAnimation.duration = 0.7;
    theAnimation.repeatCount = 1000;
    theAnimation.removedOnCompletion = NO;
    
    [self.imgView.layer addAnimation:theAnimation forKey:@"transform"];
}

- (void)createView1
{
    self.imgView = [[UIImageView alloc] init];
    self.imgView.frame = CGRectMake(100, 100, 100, 100);
    self.imgView.backgroundColor = [UIColor clearColor];
    self.imgView.image = [UIImage imageNamed:@"time_count"];
    [self.view addSubview:self.imgView];
    
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0)];
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    //转完之后停止动画
    animation.removedOnCompletion = NO;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,self.imgView.frame.size.width, self.imgView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [self.imgView.image drawInRect:CGRectMake(1,1,self.imgView.frame.size.width-2,self.imgView.frame.size.height-2)];
    self.imgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.imgView.layer addAnimation:animation forKey:nil];
}

- (void)click:(UIButton *)sender
{
    
    //    animation.repeatCount = 1000;
    //    这个你要想一直旋转，设置一个无穷大就得了
    //
    //    停止的话直接这样就停止了
    //    [self.view.layer removeAllAnimates];
    
    [self.imgView.layer removeAllAnimations];
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
