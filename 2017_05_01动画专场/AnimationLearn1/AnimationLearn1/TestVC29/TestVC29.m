//
//  TestVC29.m
//  Animation
//
//  Created by yulong on 16/2/17.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC29.h"

@interface TestVC29 ()

// 定时器，倒计时
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) time_t timeGone;

@end

@implementation TestVC29

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)setUI
{
    // 1. 执行一次的
    [self click1];
    
    
   
    
    
    // 或者这样写，差不多啊
    [self updateTimer];
    _timeGone = 0;
    
}

- (void)updateTimer
{
    // 要写成全局的，不然生命周期结束了
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    //    kSelfWeak;
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf timerAction];
        });
    });
    dispatch_resume(_timer);
    
    
    
    
    /*
     // 2. 重复执行
     NSTimeInterval period = 1.0; //设置时间间隔
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
     dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
     dispatch_source_set_event_handler(_timer, ^{
     //在这里执行事件
     NSLog(@"在这里执行事件");
     });
     dispatch_resume(_timer);
     
     */
}

// 每次调用过去1s钟
- (void)timerAction
{
    _timeGone++;
    NSLog(@"_timeGone==%ld", _timeGone);
}

#pragma mark - setter, getter


#pragma mark - 按钮响应事件


// MARK: - dispatch_after 设置时间间隔后执行一次
- (void)click1
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        // 执行一次
        NSLog(@"执行一次");
    });
    
    /*
     或者这样子写
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     });
     */
    
    
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
