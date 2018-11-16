//
//  TestVC15.m
//  Animation
//
//  Created by yulong on 16/1/28.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC15.h"
#import "AView.h"
#import "UIView+i7Rotate360.h"

@interface TestVC15 ()

@end

@implementation TestVC15

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AView *aView = [[AView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    aView.backgroundColor = [UIColor yellowColor];
    aView.frame = CGRectMake(122,170,75,75);
    aView.userInteractionEnabled = YES;
    [self.view addSubview:aView];
    
    [aView rotate360WithDuration:0.5 repeatCount:3 timingMode:i7Rotate360TimingModeLinear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
