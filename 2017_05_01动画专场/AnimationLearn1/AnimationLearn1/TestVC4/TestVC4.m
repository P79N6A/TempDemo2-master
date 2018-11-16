//
//  TestVC4.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()
{
    UIView * _view1;
    UIView * _view2;
}
@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    _view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view1];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    _view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_view2];
    
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    //    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
    
    for (int i = 0; i < 4; i++)
    {
        UIButton *myBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        myBtn.frame = CGRectMake(0, 50+80*i, 70, 30);
        myBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        myBtn.layer.borderWidth = 2.0;
        myBtn.tag = 100+i;
        
        myBtn.tintColor = [UIColor whiteColor];
        [myBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        [myBtn addTarget:self action:@selector(onMyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:myBtn];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onMyBtnClick:(UIButton *)b
{
#if 0

    
    UIViewAnimationTransition tran = UIViewAnimationTransitionNone;
    switch (b.tag)
    {
        case 100:
            tran = UIViewAnimationTransitionCurlDown;
            break;
        case 101:
            tran = UIViewAnimationTransitionCurlUp;
            break;
        case 102:
            tran = UIViewAnimationTransitionFlipFromLeft;
            break;
        case 103:
            tran = UIViewAnimationTransitionFlipFromRight;
            break;
            
        default:
            break;
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.0];
    
    //如果是UIButton的话，那么forView:b   因为UIButton 也继承于UIView
    [UIView setAnimationTransition:tran forView:self.view cache:YES];
    
    // 动画内容
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    [UIView commitAnimations];

#endif
    
    
    
    
    UIViewAnimationOptions tran = UIViewAnimationOptionTransitionNone;
    switch (b.tag)
    {
        case 100:
            tran = UIViewAnimationOptionTransitionCurlUp;
            break;
        case 101:
            tran = UIViewAnimationOptionTransitionCurlDown;
            break;
        case 102:
            tran = UIViewAnimationOptionTransitionCrossDissolve;
            break;
        case 103:
            tran = UIViewAnimationOptionTransitionFlipFromBottom;
            break;
            
        default:
            break;
    }
    
    [UIView transitionWithView:self.view duration:0.5 options:tran animations:^{
        
        // 动画内容
        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];

    } completion:^(BOOL finished) {
        
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
