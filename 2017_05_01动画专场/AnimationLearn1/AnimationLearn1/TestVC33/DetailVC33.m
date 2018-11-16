//
//  DetailVC33.m
//  AnimationLearn1
//
//  Created by xiaoyulong on 2017/6/6.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DetailVC33.h"
#import "math.h"
#import "YMCAAnimationGroup.h"

@interface DetailVC33 ()

@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@property (strong, nonatomic) UIButton *btn4;
@property (strong, nonatomic) UIButton *btn5;

@end

@implementation DetailVC33
{
    NSArray *imageArray;
    double r ;
    double n ;
    BOOL isBig;
    double centerX;
    double centerY;
    BOOL isOpen;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    [self.view addSubview:self.btn5];
    [self.view addSubview:self.menuButton];
    
    
    
    isBig = NO;
    isOpen = NO;
    n = 5;
    r = 150;
    centerX = self.menuButton.center.x;
    centerY = self.menuButton.center.y;
}


#pragma mark - 按钮响应事件


//计算扇形坐标
- (NSMutableArray *)getXWithTanAngle:(double)tanAngle {
    double x;
    double y;
    NSMutableArray *locationArray = [[NSMutableArray alloc]init];
    x = r / (sqrt(1 + tanAngle * tanAngle));
    y = tanAngle * x ;
    [locationArray addObject:[NSString stringWithFormat:@"%f",x]];
    [locationArray addObject:[NSString stringWithFormat:@"%f",y]];
    return locationArray;
}

- (void)btnClick:(UIButton *)sender
{
    
    double tan0 = tan(0);
    double tan1 = tan(M_PI_2 / (n - 1));
    double tan2 = tan((M_PI_2 / (n - 1) * 2));
    double tan3 = tan((M_PI_2 / (n - 1) * 3));
    double tan4 = tan((M_PI_2 / (n - 1) * 4));
    
    double x0 = [[self getXWithTanAngle:tan0] [0] doubleValue];
    double x1 = [[self getXWithTanAngle:tan1] [0] doubleValue];
    double x2 = [[self getXWithTanAngle:tan2] [0] doubleValue];
    double x3 = [[self getXWithTanAngle:tan3] [0] doubleValue];
    
    double y1 = [[self getXWithTanAngle:tan1] [1] doubleValue];
    double y2 = [[self getXWithTanAngle:tan2] [1] doubleValue];
    double y3 = [[self getXWithTanAngle:tan3] [1] doubleValue];
    double y4 = [[self getXWithTanAngle:tan4] [1] doubleValue];
    
    
    if (isOpen) {
        isOpen = NO;
        [self.btn1.layer addAnimation:[YMCAAnimationGroup fromEndPoint:CGPointMake(centerX - x0, centerY) toStartPoint:self.menuButton.center duration:0.15 button:self.btn1] forKey:nil];
        [self.btn2.layer addAnimation:[YMCAAnimationGroup fromEndPoint:CGPointMake(centerX - x1, centerY - y1) toStartPoint:self.menuButton.center duration:0.15 button:self.btn2] forKey:nil];
        [self.btn3.layer addAnimation:[YMCAAnimationGroup fromEndPoint:CGPointMake(centerX - x2, centerY - y2) toStartPoint:self.menuButton.center duration:0.15 button:self.btn3] forKey:nil];
        [self.btn4.layer addAnimation:[YMCAAnimationGroup fromEndPoint:CGPointMake(centerX - x3, centerY - y3) toStartPoint:self.menuButton.center duration:0.15 button:self.btn4] forKey:nil];
        [self.btn5.layer addAnimation:[YMCAAnimationGroup fromEndPoint:CGPointMake(centerX,  centerY - y4) toStartPoint:self.menuButton.center duration:0.15 button:self.btn5] forKey:nil];
        
    }
    else {
        
        isOpen = YES;
        
        [self.btn1.layer addAnimation:[YMCAAnimationGroup fromPoint:self.menuButton.center toPoint:CGPointMake(centerX - x0, centerY) duration:0.3 button:self.btn1] forKey:nil];
        [self.btn2.layer addAnimation:[YMCAAnimationGroup fromPoint:self.menuButton.center toPoint:CGPointMake(centerX - x1, centerY - y1) duration:0.3 button:self.btn2] forKey:nil];
        [self.btn3.layer addAnimation:[YMCAAnimationGroup fromPoint:self.menuButton.center toPoint:CGPointMake(centerX - x2, centerY - y2) duration:0.3 button:self.btn3] forKey:nil];
        [self.btn4.layer addAnimation:[YMCAAnimationGroup fromPoint:self.menuButton.center toPoint:CGPointMake(centerX - x3, centerY - y3) duration:0.3 button:self.btn4] forKey:nil];
        [self.btn5.layer addAnimation:[YMCAAnimationGroup fromPoint:self.menuButton.center toPoint:CGPointMake(centerX,  centerY - y4) duration:0.3 button:self.btn5] forKey:nil];
    }

}
#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)btn1
{
    if (_btn1 == nil)
    {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.backgroundColor = [UIColor yellowColor];
        _btn1.frame = CGRectMake(kScreenWidth - 80, kScreenHeight - 140, 50, 50);
        
        [_btn1 setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (UIButton *)btn2
{
    if (_btn2 == nil)
    {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.backgroundColor = [UIColor yellowColor];
        _btn2.frame = _btn1.frame;
        
        [_btn2 setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (UIButton *)btn3
{
    if (_btn3 == nil)
    {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.backgroundColor = [UIColor yellowColor];
        _btn3.frame = _btn1.frame;
        
        [_btn3 setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

- (UIButton *)btn4
{
    if (_btn4 == nil)
    {
        _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn4.backgroundColor = [UIColor yellowColor];
        _btn4.frame = _btn1.frame;
        [_btn4 setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
        [_btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn4;
}

- (UIButton *)btn5
{
    if (_btn5 == nil)
    {
        _btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn5.backgroundColor = [UIColor yellowColor];
        _btn5.frame = _btn1.frame;
        [_btn5 setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
        [_btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn5;
}

- (UIButton *)menuButton
{
    if (_menuButton == nil)
    {
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuButton.backgroundColor = [UIColor yellowColor];
        _menuButton.frame = _btn1.frame;
        [_menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [_menuButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuButton;
}



@end
