//
//  TestVC10.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC10.h"

@interface TestVC10 ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TestVC10

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];

    
    [self initScaleLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initScaleLayer
{
    //演员初始化
    CALayer *scaleLayer = [[CALayer alloc] init];
    scaleLayer.backgroundColor = [UIColor blueColor].CGColor;
    scaleLayer.frame = CGRectMake(60, 40, 50, 50);
    scaleLayer.cornerRadius = 10;
    [self.view.layer addSublayer:scaleLayer];

    
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    //开演
    [scaleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}




#pragma mark - 创建UI

- (void)setUI
{
    [self.view addSubview:self.imgView];
    [self startAnimation];
}

#pragma mark - setter, getter

- (UIImageView *)imgView
{
    if (_imgView == nil)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        _imgView.backgroundColor = [UIColor redColor];
    }
    return _imgView;
}

#pragma mark - 按钮响应事件

- (void)startAnimation
{
    // 缩放动画  放大 缩小
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 2.5; // 持续时间
    animation.repeatCount = 1;  // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
    
    
    
    // 添加动画
    [_imgView.layer addAnimation:animation forKey:@"scale-layer"];
    
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
