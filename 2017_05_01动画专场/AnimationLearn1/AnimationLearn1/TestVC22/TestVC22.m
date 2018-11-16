//
//  TestVC16_1.m
//  Animation
//
//  Created by yulong on 16/1/27.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC22.h"

@interface TestVC22 () <CAAnimationDelegate>
{
    UIImageView *_imageView;

}
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *goodsImageView;

@end

@implementation TestVC22

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
    /**
     *  购物车图标
     */
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _imageView.image = [UIImage imageNamed:@"TabCartSelected@2x.png"];
    _imageView.center = CGPointMake(270, 320);
    [self.view addSubview:_imageView];
}

#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(60, [UIScreen mainScreen].bounds.size.height * 0.6, 140, 30);
        //        _btn.backgroundColor = [UIColor yellowColor];
        _btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_btn setBackgroundImage:[UIImage imageNamed:@"ButtonRedLarge"] forState:UIControlStateNormal];
        [_btn setTitle:@"添加" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


#pragma mark - 按钮响应事件

- (void)startAnimation:(UIButton *)sender
{
    _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _goodsImageView.backgroundColor = [UIColor redColor];
    _goodsImageView.image = [UIImage imageNamed:@"test01.jpg"];
    _goodsImageView.layer.borderColor = [UIColor clearColor].CGColor;
    _goodsImageView.layer.borderWidth = 0.0;
    _goodsImageView.layer.masksToBounds = YES;
    _goodsImageView.layer.contentsGravity = kCAGravityResizeAspectFill;
    _goodsImageView.layer.cornerRadius = _goodsImageView.bounds.size.width/2;
    
    [self.view addSubview:_goodsImageView];
    
    // 抛物线关键帧动画
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 为动画设置移动路径的
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _goodsImageView.layer.position.x, _goodsImageView.layer.position.y);//移动到起始点
    
    CGPoint controlPoint = CGPointMake(_goodsImageView.layer.position.x+160, _goodsImageView.layer.position.y);
    CGPoint endPosition = CGPointMake(270, 320);
    
    // 150，30是x,y轴的控制点，自行调整数值可以出现理想弧度效果
    CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, endPosition.x, endPosition.y);
    
    keyframeAnimation.path = path;
//    keyframeAnimation.delegate = self;
    CGPathRelease(path);
    keyframeAnimation.duration = 0.7;
    
//    [_goodsImageView.layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
    
    
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[keyframeAnimation];
    //    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.7;
    groups.removedOnCompletion = YES;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_goodsImageView.layer addAnimation:groups forKey:@"group"];
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_goodsImageView.layer animationForKey:@"group"])
    {
        NSLog(@"动画停止");
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
