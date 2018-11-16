//
//  TestVC12.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC12.h"

@interface TestVC12 ()

@property (nonatomic, strong) UIImageView *refreshImageView;
@property (nonatomic, strong) UIButton *refreshLocationBtn;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC12

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)setUI
{
    [self.view addSubview:self.btn];
    [self.view addSubview:self.refreshImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAction:)];
    [self.refreshImageView addGestureRecognizer:tap];
}

#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(100, 200, 150, 30);
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn setTitle:@"移除动画点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)click:(UIButton *)sender
{
    [self stopTurnAroundAnimation];
}

#pragma mark - 按钮响应事件

- (void)click {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(-2 * M_PI)];
    anim.repeatCount = MAXFLOAT;
    anim.duration = 3;
    anim.removedOnCompletion = YES;
    
//    [self.refreshImageView.layer addAnimation:anim forKey:nil];
}



- (void)onTapAction:(UITapGestureRecognizer *)tap
{
    [self startClockwiseTurnAroundAnimation];
    //    [self startAnticlockwiseTurnAroundAnimation];
    
    //    [self performSelector:@selector(stopTurnAroundAnimation) withObject:nil afterDelay:2.0];
}

/// 开始转圈 (Clockwise  顺时针)
- (void)startClockwiseTurnAroundAnimation
{
    //     围绕Z轴旋转，垂直与屏幕  这个是逆时针的
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI, 0.0, 0.0, 1.0)];
    
    //    // 围绕Z轴旋转，垂直与屏幕  这个是顺时针的
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    // 设定旋转角度
    //    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    //    animation.toValue = [NSNumber numberWithFloat:M_PI]; // 终止角度
    
    
    
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    //    转完之后停止动画
    animation.removedOnCompletion = NO;
    [self.refreshImageView.layer addAnimation:animation forKey:nil];
}


/// 开始转圈 (Anticlockwise  逆时针)
- (void)startAnticlockwiseTurnAroundAnimation
{
    // 围绕Z轴旋转，垂直与屏幕  这个是顺时针的
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:M_PI]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:0]; // 终止角度
    animation.duration = 0.5;
    
    // 旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    //    转完之后停止动画
    animation.removedOnCompletion = NO;
    [self.refreshImageView.layer addAnimation:animation forKey:nil];
}

/// 停止转圈
- (void)stopTurnAroundAnimation
{
    [self.refreshImageView.layer removeAllAnimations];
}

#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark -

- (UIImageView *)refreshImageView
{
    if (_refreshImageView == nil)
    {
        _refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_refresh"]];
        _refreshImageView.userInteractionEnabled = YES;
        _refreshImageView.backgroundColor = [UIColor clearColor];
        _refreshImageView.frame = CGRectMake(100, 100, 50, 50);
    }
    return _refreshImageView;
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
