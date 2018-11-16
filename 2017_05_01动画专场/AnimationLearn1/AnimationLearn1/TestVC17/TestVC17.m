//
//  TestVC17.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC17.h"

@interface TestVC17 () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TestVC17

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
    /* 动画1（在X轴方向移动） */
    CABasicAnimation *animation1 =
    [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    // 终点设定
    animation1.toValue = [NSNumber numberWithFloat:80];; // 終点
    
    
    /* 动画2（绕Z轴中心旋转） */
    CABasicAnimation *animation2 =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定旋转角度
    animation2.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的角度
    animation2.toValue = [NSNumber numberWithFloat:44 * M_PI]; // 结束时的角度
    
    
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 动画选项设定
    group.duration = 6.0;
    group.repeatCount = 1;
    
    // 添加动画
    group.animations = [NSArray arrayWithObjects:animation1, animation2, nil];
    
    // 动画终了后不返回初始状态
    group.removedOnCompletion = NO;
    group.fillMode  = kCAFillModeForwards;
    group.delegate = self;
    [_imgView.layer addAnimation:group forKey:@"move-rotate-layer"];
}

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
