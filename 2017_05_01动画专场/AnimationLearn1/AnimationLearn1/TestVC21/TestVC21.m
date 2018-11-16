//
//  TestVC16.m
//  Animation
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC21.h"
#import "CALayer+Animation.h"
#import "UIBezierPath+Route.h"
#import "AppDelegate.h"

#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong  __typeof__(weakSelf) strongSelf = weakSelf


@interface TestVC21 ()

// 记录购物车里面的商品数量
@property (nonatomic, assign) NSInteger shoppingCartNumber;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *shoppingCartBtn;

@property (nonatomic, strong) UIBezierPath *bezierPath;

@property (nonatomic, strong) CALayer *goodsLayer;

@end

@implementation TestVC21

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _shoppingCartNumber = 0;
    }
    return self;
}

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
    [self.view addSubview:self.shoppingCartBtn];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.countLabel];
    if (_shoppingCartNumber == 0)
    {
        self.countLabel.hidden = YES;
    }
    
    self.bezierPath = [UIBezierPath bezierPath];
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
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil)
    {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 295, 20, 20)];
        _countLabel.backgroundColor = [UIColor whiteColor];

        UIColor *customColor  = [UIColor colorWithRed:237/255.0 green:20/255.0 blue:91/255.0 alpha:1.0f];

        _countLabel.textColor = customColor;
        _countLabel.layer.cornerRadius = CGRectGetHeight(_countLabel.bounds)/2;
        _countLabel.layer.masksToBounds = YES;
        _countLabel.layer.borderWidth = 1.0f;
        _countLabel.layer.borderColor = customColor.CGColor;

        _countLabel.font = [UIFont boldSystemFontOfSize:13];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UIButton *)shoppingCartBtn
{
    if (_shoppingCartBtn == nil)
    {
        _shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shoppingCartBtn.frame = CGRectMake(0, 0, 50, 50);
        _shoppingCartBtn.backgroundColor = [UIColor clearColor];
        [_shoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"TabCartSelected"] forState:UIControlStateNormal];
        //        [_shoppingCartBtn setTitle:@"购物车" forState:UIControlStateNormal];
        _shoppingCartBtn.center = CGPointMake(270, 320);

    }
    return _shoppingCartBtn;
}

- (CALayer *)goodsLayer
{
    if (_goodsLayer == nil)
    {
        _goodsLayer = [CALayer layer];
        _goodsLayer.contents = (__bridge id)[UIImage imageNamed:@"test01.jpg"].CGImage;
        _goodsLayer.contentsGravity = kCAGravityResizeAspectFill;
        _goodsLayer.bounds = CGRectMake(0, 0, 50, 50);
        [_goodsLayer setCornerRadius:CGRectGetHeight([_goodsLayer bounds]) / 2];
        _goodsLayer.masksToBounds = YES;
        _goodsLayer.position = CGPointMake(50, 150);
    }
    return _goodsLayer;
}

#pragma mark - 按钮响应事件

- (void)click:(UIButton *)sender
{
    self.btn.enabled = NO;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    NSLog(@"appDelegate.window==%@", appDelegate.window);
    //    NSLog(@"self.view.window==%@", self.view.window);
    [appDelegate.window.layer addSublayer:self.goodsLayer];
    
    
    // 1.从左边抛出
//    CGPoint beginPoint = CGPointMake(50, 50);
//    CGPoint endpoint = CGPointMake(270, 300);
//    CGPoint controlPoint = CGPointMake(150, 20);  // controlPoint 画曲线的基准点
    
    // 2.从右边抛出
//    CGPoint beginPoint = CGPointMake([UIScreen mainScreen].bounds.size.width-50, 50);
//    CGPoint endpoint = CGPointMake(270, 300);
//    CGPoint controlPoint = CGPointMake([UIScreen mainScreen].bounds.size.width-150, 20);  // controlPoint 画曲线的基准点
    
    // 3. 从左边向右上方抛出
    CGPoint beginPoint = CGPointMake(50, 150);
    CGPoint endpoint = CGPointMake(270, 300);
    CGPoint controlPoint = CGPointMake(150, 20);  // controlPoint 画曲线的基准点

    
    [self.bezierPath beginPoint:CGPointMake(beginPoint.x, beginPoint.y) endPoint:CGPointMake(endpoint.x, endpoint.y) controlPoint:CGPointMake(controlPoint.x, controlPoint.y)];
    
    kSelfWeak;
    [self.goodsLayer addShoppingcartGroupAnimationWithBezierPath:self.bezierPath with:^(BOOL flag, CAAnimation *anim) {
        kSelfStrong;
        
        if ([self.goodsLayer animationForKey:@"group"] == anim)
        {
            if (flag)
            {
                strongSelf.shoppingCartNumber++;
                if (strongSelf.shoppingCartNumber >= 1)
                {
                    // 1. 购物车数字
                    strongSelf.countLabel.hidden = NO;
                    [strongSelf.countLabel.layer shoppingCartLabelTextShadeChange];
                    strongSelf.countLabel.text = [NSString stringWithFormat:@"%ld", strongSelf.shoppingCartNumber];
                }
                
                // 2.购物车图标震动
                [strongSelf.shoppingCartBtn.layer shoppingCartShake];
                
                NSLog(@"动画完成");
                [strongSelf.goodsLayer removeFromSuperlayer];
                strongSelf.goodsLayer = nil;
                // 贝塞尔曲线移除
                [strongSelf.bezierPath removeAllPoints];
                
                strongSelf.btn.enabled = YES;

            }
        }
    }];
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
