//
//  TestVC6.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC6.h"

@interface TestVC6 ()
{
    UIView *_bgView;
    
    UIView *_view1;
    
}
@end

@implementation TestVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width-40, 80)];
    _bgView.backgroundColor = [UIColor yellowColor];
    /**
     When YES, content and subviews are clipped to the bounds of the view. Default is NO.
     */
    _bgView.clipsToBounds = YES;
    [self.view addSubview:_bgView];

    
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 80)];
    _view1.backgroundColor = [UIColor blueColor];
    [_bgView addSubview:_view1];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 400, 80, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click
{
    [UIView animateWithDuration:3.0 animations:^{
        _view1.frame = CGRectMake(0, -80, [UIScreen mainScreen].bounds.size.width-40, 80);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:3.0 animations:^{
            _view1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 80);
        } completion:^(BOOL finished) {
        }];
        
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
