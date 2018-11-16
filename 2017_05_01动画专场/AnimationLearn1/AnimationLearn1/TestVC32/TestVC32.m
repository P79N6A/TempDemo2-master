//
//  TestVC32.m
//  Animation1111
//
//  Created by xiaoyulong on 16/7/4.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC32.h"

static NSString *const kShoppingAlertKey = @"ShopingAlertKey";

@interface TestVC32 ()

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation TestVC32

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
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.btn];
}

- (void)animationToPopUp
{
    // 弹出动画
    //    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //    [window addSubview:self];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    //
    animation.values = values;
    [self.bgImageView.layer addAnimation:animation forKey:nil];
    
    [self setAnimated];
}


- (void)setAnimated
{
    // 第一次使用软件
    [[NSUserDefaults standardUserDefaults] setObject:
     [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey]
                                              forKey:kShoppingAlertKey];
}

#pragma mark - 按钮响应事件

- (void)click:(UIButton *)sender
{
    [self animationToPopUp];
    
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(100, 300, 100, 40);
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIImageView *)bgImageView
{
    if (_bgImageView ==  nil)
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _bgImageView.backgroundColor = [UIColor redColor];
        
    }
    return _bgImageView;
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
