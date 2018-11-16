//
//  RippleView.h
//  Animation
//
//  Created by yulong on 15/1/12.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RippleView.h"

@interface RippleView ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *redPointImgView;

@end

@implementation RippleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)setUI
{
    [self addSubview:self.whiteView];
    [self addSubview:self.redPointImgView];
    [self addSubview:self.btn];
}

#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = self.bounds;
        _btn.backgroundColor = [UIColor clearColor];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIView *)whiteView
{
    if (_whiteView == nil)
    {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _whiteView.userInteractionEnabled = YES;
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 7.5;
        _whiteView.clipsToBounds = YES;
        _whiteView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    }
    return _whiteView;
}

- (UIImageView *)redPointImgView
{
    if (_redPointImgView == nil)
    {
        _redPointImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _redPointImgView.userInteractionEnabled = YES;
        _redPointImgView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _redPointImgView.image = [UIImage imageNamed:@"sign.png"];
    }
    return _redPointImgView;
}


#pragma mark - 按钮响应事件

- (void)btnClick:(UIButton *)sender
{
    if (self.rippleBlock)
    {
        self.rippleBlock();
    }
    
    [self performSelector:@selector(makeRippleAnimation) withObject:nil afterDelay:0];
    [self performSelector:@selector(makeRippleAnimation) withObject:sender afterDelay:0.1];
    [self performSelector:@selector(makeRippleAnimation) withObject:sender afterDelay:0.3];
}

- (void)makeRippleAnimation
{
    
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.whiteView.bounds), -CGRectGetMidY(self.whiteView.bounds), self.whiteView.bounds.size.width, self.whiteView.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.whiteView.layer.cornerRadius];
    
    NSLog(@"pathFrame==%@", NSStringFromCGRect(pathFrame));
    
    CGPoint shapePosition = self.redPointImgView.center;
    //    CGPoint shapePosition = CGPointMake(self.whiteView.center.x, self.whiteView.center.y);
    NSLog(@"shapePosition (%f,%f)", shapePosition.x, shapePosition.y);
    UIColor *stroke = [UIColor whiteColor];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = stroke.CGColor;
    circleShape.lineWidth = 2;
    [self.layer addSublayer:circleShape];
    
    
    // 放大
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
    
    // 不透明度 从1 到 0
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[scaleAnimation, alphaAnimation];
    groupAnimation.duration = 0.5f;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:groupAnimation forKey:nil];
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
