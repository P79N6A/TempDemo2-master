//
//  TestVC2.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/1.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 () <CAAnimationDelegate>
{
    NSString *_strPrise;
}

@property (nonatomic, strong) UIView  *popView;

@property (nonatomic, strong) UIImageView *zhuanpanImageView;
@property (nonatomic, strong) UILabel *labPrise;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景
    UIImageView *imgViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgViewBg.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imgViewBg];
    
    
    //转盘
    _zhuanpanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-280)/2,10, 280, 280)];
    _zhuanpanImageView.image = [UIImage imageNamed:@"zhuanpan"];
    [self.view addSubview:_zhuanpanImageView];
    
    
    
    //手指
    UIImageView *hander = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    hander.center = CGPointMake(_zhuanpanImageView.center.x, _zhuanpanImageView.center.y-30);
    hander.image = [UIImage imageNamed:@"hander"];
    [self.view addSubview:hander];

    
    _labPrise = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_zhuanpanImageView.frame), CGRectGetMaxY(_zhuanpanImageView.frame)+50, CGRectGetWidth(_zhuanpanImageView.frame), 20)];
    _labPrise.textColor = [UIColor orangeColor];
    _labPrise.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labPrise];
    
    
    //开始或停止按钮
    _btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, CGRectGetMaxY(_labPrise.frame)+50, 200, 35)];
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"开始" forState:UIControlStateNormal];
    [_btn setBackgroundColor:[UIColor orangeColor]];
    _btn.layer.borderColor = [UIColor orangeColor].CGColor;
    _btn.layer.borderWidth = 1.0f;
    _btn.layer.cornerRadius = 5.0f;
    _btn.layer.masksToBounds = YES;
    [self.view addSubview:_btn];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)btnClick
{
    NSInteger angle;
    NSInteger randomNum = arc4random()%100;
    
    if (randomNum>=91 && randomNum<=99) {
        angle = 300;
        _strPrise = @"一等奖";
    } else if (randomNum>=76 && randomNum<= 90) {
        angle = 60;
        _strPrise = @"二等奖";
    } else if (randomNum >=51 && randomNum<=75) {
        angle = 180;
        _strPrise = @"三等奖";
    } else {
        angle = 240;
        _strPrise = @"没中奖";
    }
    
    [_btn setTitle:@"抽奖中..." forState:UIControlStateNormal];
    _labPrise.text = [NSString stringWithFormat:@"中奖结果:%@",@"等待开奖结果"];
    _btn.enabled = NO;
    
    
    CABasicAnimation*rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:angle*M_PI/180 ];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    //以下两行同时设置才能保持移动后的位置状态不变
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    
    [_zhuanpanImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [UIView animateWithDuration:2.0
                     animations:^{
                         
                         _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                         _popView.backgroundColor = [UIColor clearColor];
                         _popView.transform = CGAffineTransformMakeScale(2, 2);
                         [self.view addSubview:_popView];
                         
                         UIImageView *popImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, self.view.frame.size.width-200, self.view.frame.size.width-200)];
                         popImageView.image = [UIImage imageNamed:@"prise"];
                         [_popView addSubview:popImageView];
                         
                     }
                     completion:^(BOOL finished) {
                         [_popView removeFromSuperview];
                         _labPrise.text = [NSString stringWithFormat:@"中奖结果 : %@", _strPrise];
                         [_btn setTitle:@"开始抽奖" forState:UIControlStateNormal];
                         _btn.enabled = YES;
                     }];


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
