//
//  ViewController.m
//  DGSlimeView
//
//  Created by 段昊宇 on 16/5/29.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ViewController.h"
#import "DGSlimeDotView.h"
#import "DGSlimeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    DGSlimeView *slimeView = [[DGSlimeView alloc] initWithFrame:CGRectMake(100, 30, 200, 200)];

    DGSlimeView *slimeView = [[DGSlimeView alloc] initWithFrame: self.view.bounds];
    slimeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: slimeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
