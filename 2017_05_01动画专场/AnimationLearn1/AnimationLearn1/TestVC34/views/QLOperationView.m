//
//  QLOperationView.m
//  AnimationLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "QLOperationView.h"
#import "VideoBackBtn.h"


#define startOrderBtnWidth (kScreenWidth > 320 ? 150.0 : 100.0)

#define otherBtnWidth ((kScreenWidth - startOrderBtnWidth) / 3)


@interface QLOperationView ()

@property (nonatomic, strong) VideoBackBtn *collectBtn;

@end

@implementation QLOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)createUI
{
    [self addSubview:self.collectBtn];
}


#pragma mark - 按钮响应事件
- (void)collectBtnCLick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    BOOL isCollected = sender.selected;
    
    if (isCollected)
    {
        // 已经关注
        
        UIImage *image = [UIImage imageNamed:@"icon-38×38-shoucang"];
        
        _collectBtn.cusImageView.image = image;
        _collectBtn.cusImageView.frame = CGRectMake((otherBtnWidth-image.size.width) / 2, (QLOperationViewHeight-20)/2 - 8, image.size.width, image.size.height);
        
        
        _collectBtn.cusTitleLabel.frame = CGRectMake(0, (QLOperationViewHeight-20)/2 + 12, otherBtnWidth, 20);
        _collectBtn.cusTitleLabel.font = [UIFont systemFontOfSize:11];
        _collectBtn.cusTitleLabel.text = @"已关注";
        _collectBtn.cusTitleLabel.textAlignment = NSTextAlignmentCenter;
        
    
//        [self makeRippleAnimation];
        
        
        
        //关键帧动画
        //用动画完成放大的效果
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        //需要给他设置一个关键帧的值,这个值就是变化过程
        //values是一个数组
        animation.values = @[@(0.5), @(1.0), @(1.5)];
        //设置动画的时长
        animation.duration = 0.2;
        //加到button上
        [_collectBtn.cusImageView.layer addAnimation:animation forKey:@"animation"];
        
        
        
        //根据状态更换图片
//        if (self.isSelect == NO) {
//            [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"IconHgood.png"] forState:UIControlStateNormal];
//        }else{
//            [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon-38×38-shoucang-normal"] forState:UIControlStateNormal];
//        }
//        
        
        
    }
    else
    {
        // 未关注
        
        UIImage *image = [UIImage imageNamed:@"icon-38×38-shoucang-normal"];
        
        _collectBtn.cusImageView.image = image;
        _collectBtn.cusImageView.frame = CGRectMake((otherBtnWidth-image.size.width) / 2, (QLOperationViewHeight-20)/2 - 8, image.size.width, image.size.height);
        
        
        _collectBtn.cusTitleLabel.frame = CGRectMake(0, (QLOperationViewHeight-20)/2 + 12, otherBtnWidth, 20);
        _collectBtn.cusTitleLabel.font = [UIFont systemFontOfSize:11];
        _collectBtn.cusTitleLabel.text = @"关注";
        _collectBtn.cusTitleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
}

- (void)makeRippleAnimation
{
    CGRect pathFrame = CGRectMake(-10, -10, 20, 20);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:10.0];
    
    NSLog(@"pathFrame==%@", NSStringFromCGRect(pathFrame));
    
    CGPoint shapePosition = CGPointMake(self.collectBtn.center.x, self.collectBtn.center.y - 10);
    
    NSLog(@"shapePosition (%f,%f)", shapePosition.x, shapePosition.y);
    UIColor *stroke = UIColorRGB(245, 78, 0);

    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = stroke.CGColor;
    circleShape.lineWidth = 5;
    [self.layer addSublayer:circleShape];
    
    
    // 放大
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    
    // 不透明度 从1 到 0
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[scaleAnimation, alphaAnimation];
    groupAnimation.duration = 0.5;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:groupAnimation forKey:nil];
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter




- (VideoBackBtn *)collectBtn
{
    if (_collectBtn == nil)
    {
        _collectBtn = [VideoBackBtn buttonWithType:UIButtonTypeCustom];
        _collectBtn.backgroundColor = [UIColor whiteColor];
        _collectBtn.frame = CGRectMake(30, 0, otherBtnWidth, QLOperationViewHeight);
        
        
        //        [_collectBtn setTitle:@"关注" forState:UIControlStateNormal];
        //        [_collectBtn setTitle:@"已关注" forState:UIControlStateSelected];
        //        [_collectBtn setTitleColor:UIColorRGB(102, 102, 102) forState:UIControlStateNormal];
        //        _collectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        //
        //        [_collectBtn setImage:[UIImage imageNamed:@"icon-38×38-shoucang-normal"] forState:UIControlStateNormal];
        //        [_collectBtn setImage:[UIImage imageNamed:@"icon-38×38-shoucang"] forState:UIControlStateSelected];
        //
        //        [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(24, -18, 0, 0)];
        //        [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-14, 30, 0, 0)];
        
        
        UIImage *image = [UIImage imageNamed:@"icon-38×38-shoucang-normal"];
        
        _collectBtn.cusImageView.image = image;
        _collectBtn.cusImageView.frame = CGRectMake((otherBtnWidth-image.size.width) / 2, (QLOperationViewHeight-20)/2 - 8, image.size.width, image.size.height);
        
        
        _collectBtn.cusTitleLabel.frame = CGRectMake(0, (QLOperationViewHeight-20)/2 + 12, otherBtnWidth, 20);
        _collectBtn.cusTitleLabel.font = [UIFont systemFontOfSize:11];
        _collectBtn.cusTitleLabel.text = @"关注";
        _collectBtn.cusTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        [_collectBtn addTarget:self action:@selector(collectBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
