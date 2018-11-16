//
//  TestVC1.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "CircleLayer.h"


@interface TestVC1 ()

@property (nonatomic, strong) CircleLayer *layer;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 实现方式一: 直接添加操作图层处理
    self.layer = [[CircleLayer alloc] init];
    self.layer.frame = CGRectMake(50, 100, 100, 100);
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)move:(CircleLayer *)layer
{
    [self.layer animateCircle];

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
