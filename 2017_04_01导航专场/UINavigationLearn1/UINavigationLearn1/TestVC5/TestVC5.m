//
//  TestVC2.m
//  UINavigation
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//

#import "TestVC5.h"

@interface TestVC5 ()

@end

@implementation TestVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self click1];
    
    [self click2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click1
{
    /**
     * 或者在  AppDelegate.m 中这么写 nav.navigationBar.translucent = NO;
     */
    self.navigationController.navigationBar.translucent = NO;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    
    /**
     *  xib  中 Top Bar
     *  Translucent Navigation Bar  透明的
     *  Opaque  Navigation Bar    不透明的
     */
    
    
    
    
    
    /*
     那么区别：
     当导航栏是非透明时，加载的UIView是从导航栏下面开始算
     (0, 0, 200, 200)
     
     当导航栏是透明（默认是透明）时，加载的UIView是从状态栏开始算
     (0, 64, 200, 200)
     
     */
}


- (void)click2
{
    // 如果导航栏透明，加载的UIView是从导航栏下面开始算
    
    // iOS 7.0 特性,  默认是UIRectEdgeAll
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];

    
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
