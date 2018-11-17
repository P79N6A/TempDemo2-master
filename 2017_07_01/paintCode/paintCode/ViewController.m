//
//  ViewController.m
//  paintCode
//
//  Created by wsh on 16/7/27.
//  Copyright © 2016年 wsh. All rights reserved.
//

#import "ViewController.h"
#import "Stopwatch.h"
#import "StopwatchHand.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()
@property (nonatomic, strong) Stopwatch *stopWatchView;
@property (nonatomic, strong) StopwatchHand *stopwatchHandView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stopWatchView = [[Stopwatch alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 250) / 2.0, 10, 250, 250)];
    _stopwatchHandView = [[StopwatchHand alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 250) / 2.0, 40, 250, 220)];
    
    
    
    [self.view addSubview:_stopWatchView];
    [self.view addSubview:_stopwatchHandView];
}

- (void)rotateStopWatchHand {
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.stopwatchHandView.transform = CGAffineTransformRotate(self.stopwatchHandView.transform,M_PI_2);
    } completion:^(BOOL finished) {
//        [self rotateStopWatchHand];
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self rotateStopWatchHand];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
