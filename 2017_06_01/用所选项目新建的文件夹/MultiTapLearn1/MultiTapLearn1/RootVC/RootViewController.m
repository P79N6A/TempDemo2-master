//
//  RootViewController.m
//  MultiTapLearn1
//
//  Created by xiaoyulong on 2017/6/5.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "MultiTapView.h"

@interface RootViewController ()

@property (nonatomic, strong) MultiTapView *multiTapView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.multiTapView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (MultiTapView *)multiTapView
{
    if (_multiTapView == nil)
    {
        _multiTapView = [[MultiTapView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
        _multiTapView.backgroundColor = [UIColor yellowColor];
    }
    return _multiTapView;
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
