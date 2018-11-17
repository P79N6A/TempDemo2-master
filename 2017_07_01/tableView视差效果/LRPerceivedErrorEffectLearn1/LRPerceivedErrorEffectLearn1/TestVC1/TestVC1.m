//
//  TestVC1.m
//  LRPerceivedErrorEffectLearn1
//
//  Created by xiaoyulong on 2017/7/10.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *tyView;



@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.tyView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)bgView
{
    if (_bgView == nil)
    {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 70, [UIScreen mainScreen].bounds.size.width - 40, 100)];
        _bgView.backgroundColor = [UIColor redColor];
    }
    return _bgView;
}


-(UIView *)tyView
{
    if (_tyView==nil) {
        _tyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgView.frame.size.height-48, self.bgView.frame.size.width, 48)];
        // 渐变图层
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = _tyView.bounds;
        // 设置颜色
        gradientLayer.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.0f].CGColor,
                                 (id)[[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor];
        //  gradientLayer.locations = @[[NSNumber numberWithFloat:0.7f],
        //          [NSNumber numberWithFloat:1.0f]];
        // 添加渐变图层
        [_tyView.layer addSublayer:gradientLayer];
        
        
    }
    return _tyView;
    
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
