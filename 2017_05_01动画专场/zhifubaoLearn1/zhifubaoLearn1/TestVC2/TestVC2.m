//
//  TestVC2.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor colorWithRed:35 / 255.0 green:39 / 255.0 blue:63 / 255.0 alpha:1];
    //设置中间点击按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"zhifubao"] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick:(UIButton *)btn {
    
    for (NSInteger i = 0; i < 10; i++) {
        
        // 1.创建一个圆圈view
        UIView *circleView = [[UIView alloc] init];
        circleView.backgroundColor = [UIColor colorWithRed:0 green:170  / 255.0 blue:238 / 255.0 alpha:1];
        circleView.frame = btn.frame;
        
        //    [self.view addSubview:circleView];
        // 把圆圈添加到控制器的view上并且加上支付宝按钮的上面
        //    [self.view insertSubview:circleView aboveSubview:btn];
        // 在支付宝按钮按钮下面插入一个view
        [self.view insertSubview:circleView belowSubview:btn];
        circleView.layer.cornerRadius = circleView.frame.size.width * 0.5;
        
        circleView.layer.masksToBounds = YES;
        
        // 让每一个圆圈延迟时间不一样
        [UIView animateWithDuration:1.0 delay:i * 0.2 options:0 animations:^{
            circleView.transform = CGAffineTransformMakeScale(16, 16);
            circleView.alpha = 0;
        } completion:^(BOOL finished) {
            [circleView removeFromSuperview];
        }];
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
