//
//  TestVC28.m
//  Animation
//
//  Created by yulong on 16/2/17.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC28.h"

@interface TestVC28 ()
{
    NSTimer *_timer;
}

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end

@implementation TestVC28

- (void)dealloc
{
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
}

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
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    
    /**
     TimerInterval : 执行之前等待的时间。比如设置成1.0，就代表1秒后执行方法
     target : 需要执行方法的对象。
     selector : 需要执行的方法
     repeats : 是否需要循环
     */
    /**
     存在延迟：不管是一次性的还是周期性的timer的实际触发事件的时间，都会与所加入的RunLoop和RunLoop Mode有关，如果此RunLoop正在执行一个连续性的运算，timer就会被延时出发。重复性的timer遇到这种情况，如果延迟超过了一个周期，则会在延时结束后立刻执行，并按照之前指定的周期继续执行。
     
     必须加入Runloop：使用上面的创建方式，会自动把timer加入MainRunloop的NSDefaultRunLoopMode中。如果使用以下方式创建定时器，就必须手动加入Runloop:
     
     NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     */
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}

#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(100, 60, 100, 30);
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn setTitle:@"销毁" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIButton *)btn2
{
    if (_btn2 == nil)
    {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(100, 100, 100, 30);
        _btn2.backgroundColor = [UIColor yellowColor];
        [_btn2 setTitle:@"暂停1" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (UIButton *)btn3
{
    if (_btn3 == nil)
    {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(100, 140, 100, 30);
        _btn3.backgroundColor = [UIColor yellowColor];
        [_btn3 setTitle:@"开始" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

- (void)click:(UIButton *)sender
{
    /**
     [timer invalidate];
     注意 : 调用创建方法后，target对象的计数器会加1，直到执行完毕，自动减1。如果是循环执行的话，就必须手动关闭，否则可以不执行释放方法。
     */
    // 定时器销毁
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    // 一定要销毁，dealloc写
}

- (void)btn2Click:(UIButton *)sender
{
    // 暂停
    _timer.fireDate = [NSDate distantFuture];
}

- (void)btn3Click:(UIButton *)sender
{
    // 开始
    _timer.fireDate = [NSDate date];
}

#pragma mark - 按钮响应事件

- (void)timerAction:(NSTimer *)timer
{
    NSLog(@"timer==%@", timer);
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
