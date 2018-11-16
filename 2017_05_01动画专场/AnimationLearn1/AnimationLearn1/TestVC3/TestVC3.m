//
//  TestVC3.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC3.h"

@interface TestVC3 ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *label;

@end

@implementation TestVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.btn];
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(20, 20, 100, 30);
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn setTitle:@"动画开始" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)label
{
    if (_label == nil)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 30)];
        _label.backgroundColor = [UIColor redColor];
        _label.text = @"时光飞逝";
    }
    return _label;
}

- (void)click:(UIButton *)sender
{
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"move1" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    /*
     UIViewAnimationTransitionNone,
     UIViewAnimationTransitionFlipFromLeft,
     UIViewAnimationTransitionFlipFromRight,
     UIViewAnimationTransitionCurlUp,
     UIViewAnimationTransitionCurlDown,
     */
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_label cache:YES];

    _label.center = CGPointMake(280, 100);
    
    //设置了代理，才走下面这个方法
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(down)];
    [UIView commitAnimations];
 
}

- (void)down
{
    [UIView beginAnimations:@"move1" context:nil];
    [UIView setAnimationDuration:2.0];
    _label.center=CGPointMake(280, 450);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(left)];
    [UIView commitAnimations];
}

- (void) left
{
    [UIView beginAnimations:@"move2" context:nil];
    [UIView setAnimationDuration:2.0];
    
    _label.center=CGPointMake(50, 450);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(up)];
    [UIView commitAnimations];

}

- (void) up
{
    [UIView beginAnimations:@"move3" context:nil];
    [UIView setAnimationDuration:2.0];
    _label.center=CGPointMake(50, 100);
    [UIView commitAnimations];
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
