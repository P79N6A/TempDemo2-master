//
//  TestVC16.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC16.h"

@interface TestVC16 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TestVC16

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
    /**
     CABasicAnimation类的使用方式就是基本的关键帧动画。
     所谓关键帧动画，就是将Layer的属性作为KeyPath来注册，指定动画的起始帧和结束帧，然后自动计算和实现中间的过渡动画的一种动画方式。
     */
    
    //    将"QuartzCore.framework"这个库添加到项目中。并且在需要使用CABaseAnimation类的地方import头文件。
    //    iOS 7 以后就不需要了啊
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 创建UI

- (void)setUI
{
    [self.view addSubview:self.imageView];
    [self startAnimation];
}

#pragma mark - setter, getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}

#pragma mark - 按钮响应事件

- (void)startAnimation
{
    // 指定position属性（移动）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2.5; // 动画持续时间
    animation.repeatCount = 1; // 不重复
    animation.beginTime = CACurrentMediaTime() + 2; // 2秒后执行
    
    // 结束后执行逆动画
    animation.autoreverses = YES;
    
    // 动画先加速后减速
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    // 设定动画起始帧和结束帧
    //    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)]; // 起始点
    animation.fromValue = [NSValue valueWithCGPoint:_imageView.layer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(320, 480)]; // 终了点
    
    
    //    // 动画完成后回到  坐标(0,0),动画终了后不返回初始状态
    //    animation.removedOnCompletion = NO;
    //    animation.fillMode  = kCAFillModeForwards;
    
    [self.imageView.layer addAnimation:animation forKey:@"move-layer"];
    
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
