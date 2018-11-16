//
//  TestVC9.m
//  Animation
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC9.h"

@interface TestVC9 ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end

@implementation TestVC9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     CAAnimation是什么呢？
     
     CAAnimation可分为四种：
     
     1.CABasicAnimation
     通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
     
     2.CAKeyframeAnimation
     Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
     
     3.CAAnimationGroup
     Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行，如何按顺序执行我到时候再讲。
    
     4.CATransition
     这个就是苹果帮开发者封装好的一些动画
     */
    
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)setUI
{
    [self.view addSubview:self.imageView];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
}

#pragma mark - setter, getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
//        loading_gif.gif
        UIImage *loading_gif = [UIImage imageNamed:@"loading_gif.gif"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, loading_gif.size.width, loading_gif.size.height)];
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.image = loading_gif;
    }
    return _imageView;
}

- (UIButton *)btn1
{
    if (_btn1 == nil)
    {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(30, [UIScreen mainScreen].bounds.size.height-120, 100, 40);
        _btn1.backgroundColor = [UIColor yellowColor];
        [_btn1 setTitle:@"把图片移到右下角变透明" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn1.titleLabel.numberOfLines = 0;
        [_btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (UIButton *)btn2
{
    if (_btn2 == nil)
    {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(_btn1.frame.origin.x+_btn1.frame.size.width+20, _btn1.frame.origin.y, 100, 40);
        _btn2.backgroundColor = [UIColor yellowColor];
        [_btn2 setTitle:@"旋转并向右移动" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn2.titleLabel.numberOfLines = 0;
        [_btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (UIButton *)btn3
{
    if (_btn3 == nil)
    {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(_btn2.frame.origin.x+_btn2.frame.size.width+20, _btn1.frame.origin.y, 100, 40);
        _btn3.backgroundColor = [UIColor yellowColor];
        [_btn3 setTitle:@"旋转并消除边缘锯齿" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn3.titleLabel.numberOfLines = 0;
        [_btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

#pragma mark - 按钮响应事件

- (void)btn1Click:(UIButton *)sender
{
    CGPoint fromPoint = _imageView.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(300, 460);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    
    //关键帧,设置了动画的路径，
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化,设置了缩小
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化,设置了透明度的变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim,scaleAnim,opacityAnim,nil];
    animGroup.duration = 1;
    [_imageView.layer addAnimation:animGroup forKey:nil];
}

- (void)btn2Click:(UIButton *)sender
{
    
    //    向右移动是因为关键帧使用了路径为直线的路径。
    CGPoint fromPoint = _imageView.center;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(fromPoint.x +100 , fromPoint.y ) ;
    [movePath addLineToPoint:toPoint];
    
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    
    //    CATransform3DMakeRotation，这返回的是旋转的值
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    
    
    
    //沿Z轴旋转
    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    //    CATransform3DMakeScale缩放的值
    
    //沿Y轴旋转
    //       TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,1.0,0)];
    
    //沿X轴旋转
    //    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,1.0,0,0)];
    
    TransformAnim.cumulative = YES;
    TransformAnim.duration =3;
    //旋转2遍，360度
    TransformAnim.repeatCount =2;
    _imageView.center = toPoint;
    TransformAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, TransformAnim, nil];
    animGroup.duration = 6;
    
    [_imageView.layer addAnimation:animGroup forKey:nil];
}

- (void)btn3Click:(UIButton *)sender
{
    //图片旋转360度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0, 0, 1.0) ];
    animation.duration = 3;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 2;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [_imageView.image drawInRect:CGRectMake(1,1,_imageView.frame.size.width-2,_imageView.frame.size.height-2)];
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [_imageView.layer addAnimation:animation forKey:nil];
    
    
    /**
     如果你仔细观察，会看到第二个动画里在旋转时，图片边缘是有锯齿的，如何消除呢？在图片边缘添加一个像素的透明区域，去图片锯齿。
     UIGraphicsBeginImageContext 开始图片内容
     UIGraphicsGetImageFromCurrentImageContext 获取当前内容作为图片，
     UIGraphicsEndImageContext结束。是和UIGraphicsBeginImageContext配套使用的。
     */

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
