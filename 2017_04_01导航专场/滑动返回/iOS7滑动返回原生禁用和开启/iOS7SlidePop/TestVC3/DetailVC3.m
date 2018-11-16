//
//  DetailVC3.m
//  iOS7SlidePop
//
//  Created by xiaoyulong on 16/7/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC3.h"

@interface DetailVC3 ()

@end

@implementation DetailVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 如果是针对这个controller禁用右滑动返回手势
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NSString *str = @"7.0.1";
    
    NSComparisonResult result = [str compare:@"7.0"];
    NSLog(@"result==%d", result);

    if (result != NSOrderedAscending)
    {
        NSLog(@"result=dad=%d", result);   
    }
    
    NSLog(@"systemVersion==%@", [UIDevice currentDevice].systemVersion);
    NSLog(@"systemVersion.floatValue==%f", [UIDevice currentDevice].systemVersion.floatValue);
    

//    systemVersion==9.3.2
//    systemVersion.floatValue==9.300000
    
    if ([UIDevice currentDevice].systemVersion.floatValue > 9.0)
    {
        // 所以用这种方式判断不是特别的准确
        NSLog(@"kk");
    }
    
    
    //禁用 iOS 7 滑动返回手势
    if ([[UIDevice currentDevice].systemVersion compare:@"7.0"] != NSOrderedAscending)
    {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }

    }

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //    这个Controller消失后就开启滑动返回功能
    if ([[UIDevice currentDevice].systemVersion compare:@"7.0"] != NSOrderedAscending)
    {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
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
