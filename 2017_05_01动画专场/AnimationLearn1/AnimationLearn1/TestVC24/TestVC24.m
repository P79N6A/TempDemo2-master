//
//  TestVC16_2_1.m
//  Animation
//
//  Created by yulong on 16/2/16.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC24.h"

@interface TestVC24 ()

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;

@end

@implementation TestVC24

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    self.view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.view1];
    
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.view2.backgroundColor = [UIColor redColor];
    [self.view1 addSubview:self.view2];
    
    
    //    [self click1];
    [self click2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 将view2 上的坐标 35, 35 转变为 view1 上的坐标

- (void)click1
{
    // view2 在view1 上的中心点
    NSLog(@"view2.center==%@", NSStringFromCGPoint(self.view2.center));
    //    view2.center=={35, 35}
    
    // 将view2 上的坐标 35, 35 转变为 view1 上的坐标
    // 方法1
    CGPoint point1 = [self.view2 convertPoint:CGPointMake(self.view2.center.x, self.view2.center.y) toView:self.view1];
    NSLog(@"point==%@", NSStringFromCGPoint(point1));
    //    point=={45, 45}
    
    // 将view2 上的坐标 35, 35 转变为 view1 上的坐标
    // 方法2
    CGPoint point11 = [self.view1 convertPoint:self.view2.center fromView:self.view2];
    NSLog(@"point11==%@", NSStringFromCGPoint(point11));
    
    
    //    CGPoint point2 = [self.view2 convertPoint:CGPointMake(25, 25) toView:self.view1];
    //    NSLog(@"point2==%@", NSStringFromCGPoint(point2));
    //    point2=={35, 35}
    
}

- (void)click2
{
    // 将view2 上的坐标 35, 35 转变为 view1 上的坐标
    // 方法1
    CGPoint point1 = [self.view2 convertPoint:CGPointMake(self.view2.center.x, self.view2.center.y) toView:self.view1];
    NSLog(@"point==%@", NSStringFromCGPoint(point1));
    //    point=={45, 45}
    
    CGPoint point11 = [self.view1 convertPoint:CGPointMake(35, 35) toView:self.view2];
    NSLog(@"point11==%@", NSStringFromCGPoint(point11));
    //    point11=={25, 25}
    
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
