//
//  RootViewController.m
//  DrawImageLearn1
//
//  Created by xiaoyulong on 2017/6/5.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "MyView.h"

@interface RootViewController ()

@property (nonatomic, strong) MyView *myView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.myView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MyView *)myView
{
    if (_myView == nil)
    {
        _myView = [[MyView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
        _myView.backgroundColor = [UIColor yellowColor];
    }
    return _myView;
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
