//
//  TestVC1.m
//  romantic
//
//  Created by xiaoyulong on 16/6/22.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()

@property(nonatomic, strong)UILabel  *label;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SetupLayer];

    
    
    
    /**
     int [] arr = new int[] [8, 2, 1, 0, 3];
     int [] index = new int[] {20324013233};
     
     String tel = "";
     
     for (int i : index)
     {
        tel += arr[i];
     }
     
     System.out.printIn("联系方式:"+ tel)
     
     */
    
    
    
    /**
     for (int i : index)
     将 : 后面数组中的元素一一取出赋给 : 左边的变量 然后执行循环体
     以下列子 两个for循环的功能是一样的 但第二个明显方便不少
     当然在数组排序时是不适用的
     
     {
     public static void main(String[] args) {
     int a[] = {7,3,9,9,3,2,7,20};
     
     for (int i=0; i<a.length ;i++ )
     {
     System.out.print(a[i] + " ");
     }
     
     
     for (int b:a)
     {
     System.out.print(b + " ");
     
     }
     
     }
     }

     
     */
    
    NSArray *arr = @[@"8", @"2", @"1", @"0", @"3", @"", @"", @"", @"", @"", @"", @"", @"", @""];
    NSArray *indexArr = @[@"2", @"0", @"3", @"2", @"4", @"0", @"1", @"3", @"2", @"3", @"3"];
    NSString *tel = @"";
    
    for (NSInteger i = 0; i < indexArr.count; i++)
    {
        NSString *temp = indexArr[i];

        NSString *str = [arr objectAtIndex:temp.integerValue];
        tel = [NSString stringWithFormat:@"%@,%@", tel, str];
    }
    
    NSLog(@"tel==%@", tel);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)SetupLayer{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 20, 100, 30)];
    label.text = @"哈哈哈";
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    _label = label;
    [_label.layer addAnimation:[self SetupScaleAnimation] forKey:@"scale"];
}


- (CAAnimation *)SetupScaleAnimation{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 3.0;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:3.0];
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    
    return scaleAnimation;
}


- (CAAnimation *)SetupMoveAnimation{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:_label.layer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_label.layer.position.x, 667-60)];
    moveAnimation.autoreverses = YES;
    moveAnimation.duration = 3.0;
    return moveAnimation;
}

- (CAAnimation *)SetupRotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.duration = 1.5;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    rotationAnimation.fillMode = kCAFillModeBoth;
    return rotationAnimation;
}


- (CAAnimation *)SetupGroupAnimation{
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 3.0;
    groupAnimation.animations = @[[self SetupScaleAnimation], [self SetupMoveAnimation], [self SetupRotationAnimation]];
    groupAnimation.autoreverses = YES;
    groupAnimation.repeatCount = MAXFLOAT;
    return groupAnimation;
}

- (CABasicAnimation *)SetupOpacityAnimation

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    
    animation.toValue = [NSNumber numberWithFloat:0.0];
    
    animation.autoreverses = YES;
    
    animation.duration = 0.3;
    
    animation.repeatCount = FLT_MAX;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
    
}

- (CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time; //有闪烁次数的动画

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.4];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=YES;
    
    return  animation;
    
}


- (CABasicAnimation *)moveX:(float)time X:(NSNumber *)x //横向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



- (CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y //纵向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue=y;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



- (CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes //缩放

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.autoreverses=YES;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



- (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes //组合动画

{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



- (CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes //路径动画

{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}



- (CABasicAnimation *)movepoint:(CGPoint )point //点移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



- (CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount //旋转

{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses= NO;
    
    animation.cumulative= YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.repeatCount= repeatCount;
    
    animation.delegate= self;
    
    
    
    return animation;
    
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
