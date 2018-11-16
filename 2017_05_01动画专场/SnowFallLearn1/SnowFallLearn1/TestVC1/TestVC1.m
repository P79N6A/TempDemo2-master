//
//  TestVC1.m
//  HHSnowAnimationView
//
//  Created by 张家欢 on 16/8/1.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "TestVC1.h"
#import "HHSnowView.h"
@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HHSnowView *snowView = [[HHSnowView alloc] initWithFrame:self.view.bounds withBackgroundImageName:@"snow_background.jpg" withSnowImgName:@"snow"];
    [snowView beginSnow];
    [self.view addSubview:snowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
