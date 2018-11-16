//
//  RootViewController.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/5/31.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//



#import "RootViewController.h"


/*控制微动画的时间*/
float SMALL_ROTATE_DURATION=0.05;


/*控制定时器调用指定方法的时间*/
float TIMER_INVAL=0.05;

/*最大转动速度*/
static float MAX_SPEED = 1.0;

/*最小转动速度*/
float MIN_SPEED = 0.05;



enum RotateDirection{
    CLOCK,   // CLOCK顺时针
    ANTICLOCK  // ANTICLOCK逆时针
};



@interface RootViewController ()
{
    NSTimer *_timer ;

    
    //counter-clock
    /*当前view的转动速度*/
    float currentSpeed;

    /*d当前转动的方向*/
    enum RotateDirection currentRotateDirection;
    
    
    CGPoint touchStartPoint;
    CGPoint touchEndPoint;
    
    NSDate *now;
    NSDate *toucheBeginTime;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    [self createUI];
    [self initRotation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.textFiled];
}


#pragma mark - 按钮响应事件

- (void)initRotation
{
    currentRotateDirection = CLOCK;
    currentSpeed = MIN_SPEED ;

//    [self startRotate];
}


- (void)startRotate
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INVAL target:self selector:@selector(timerThread) userInfo:nil repeats:YES] ;
}

- (void)stopRotate
{
    [_timer invalidate];
    _timer = nil;
}

- (void)timerThread
{
    if(currentSpeed > MIN_SPEED)
    {
        currentSpeed -= 0.05 ;
    }
    
    if(currentSpeed < MIN_SPEED)
    {
        currentSpeed = MIN_SPEED;
    }
    
    [self rotateWithSpeed:currentSpeed];
}

- (void)rotateWithSpeed:(float)speed
{
    CGFloat angle = speed*M_PI ;
    
    if(currentRotateDirection == ANTICLOCK) {
        angle = -angle;
    }
    
    [UIView animateWithDuration:SMALL_ROTATE_DURATION animations:^{
         [self rotateWithAngle:angle];
    }];
}


- (void)rotateWithAngle:(CGFloat)angle
{
    CGAffineTransform originTransform = self.imageView.transform ;
    self.imageView.transform = CGAffineTransformRotate(originTransform, angle);
}


#pragma mark - 网络请求


#pragma mark - 代理方法

/*覆盖touch event的事件处理*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopRotate];
    touchStartPoint = [self getLocationFromTouches:touches];
    
    toucheBeginTime = [NSDate date] ;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchEndPoint = [self getLocationFromTouches:touches];
    
    CGFloat distance = [self getDistance:touchStartPoint end:touchEndPoint];
    
    if(distance > 1.0)
    {
        [self dragRotate:touchStartPoint end:touchEndPoint];
        
        touchStartPoint = touchEndPoint ;
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    now = [NSDate date];
    
    [self touchesMoved:touches withEvent:nil];
    [self startRotate];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//    now = [NSDate date];
    
    [self touchesMoved:touches withEvent:nil];
    
    
    
//    [self startRotate];
}


- (CGFloat)calculateAngle:(CGPoint)begin endPoint:(CGPoint)end
{
    CGFloat k1,k2 ;
    CGPoint vCenter= [self.imageView center];
    
    if(begin.x-vCenter.x==0 ||end.x-vCenter.x == 0)
    {
        return 0.0;
    }
    
    k1= (begin.y-vCenter.y)/(begin.x-vCenter.x) ;
    k2= (end.y-vCenter.y)/(end.x-vCenter.x);
    
    CGFloat tan0= (k2-k1)/(1.0+k1*k2);
    
    if(tan0<0)
    {
        tan0=-tan0;
    }
    
    
    return atan(tan0) ;
}


- (enum RotateDirection)getRotateDirectionByPoints:(CGPoint)s end:(CGPoint)e
{
    CGFloat k1,k2 ;
    CGPoint vCenter= [self.imageView center];
    
    if(s.x-vCenter.x==0 || e.x-vCenter.x==0)
    {
        return CLOCK;
    }
    
    k1= (s.y-vCenter.y)/(s.x-vCenter.x) ;
    k2= (e.y-vCenter.y)/(e.x-vCenter.x);
    
    CGFloat tan0= (k2-k1)*(1.0+k1*k2);
    
    if(tan0>0.0)
    {
        return CLOCK;
    }
    else
    {
        return ANTICLOCK;
    }
    
}

- (float)calculateSpeedByPoints:(CGPoint)s end:(CGPoint)e
{
    NSTimeInterval timeInterval = [toucheBeginTime timeIntervalSinceNow] ;
    
    double seconds = timeInterval;
    
    if(seconds < 0)
    {
        seconds=-seconds;
    }
    
    double distance = [self getDistance:touchStartPoint end:touchEndPoint];
    double speed=distance/seconds;
    
    NSString *str1=[NSString stringWithFormat:@"speed:%lf",speed];
    [self.textFiled setText:str1];
    
    if(speed > 40.0)
    {
        speed = MAX_SPEED;
    }
    else
    {
        speed = MIN_SPEED;
    }
    return speed;
}

- (void)dragRotate:(CGPoint)s end:(CGPoint)e
{
    CGFloat angle = [self calculateAngle:touchStartPoint endPoint:touchEndPoint];
    
    currentRotateDirection=[self getRotateDirectionByPoints:s end:e];
    
    currentSpeed=[self calculateSpeedByPoints:s end:e];
    
    if(currentRotateDirection==ANTICLOCK)
    {
        angle=-angle ;
    }
    
    [self rotateWithAngle:angle];
}

- (CGFloat)getDistance:(CGPoint)s end:(CGPoint)e
{
    return sqrt((s.x-e.x)*(s.x-e.x) + (s.y-e.y)*(s.y-e.y));
}


- (CGPoint)getLocationFromTouches:(NSSet*)touches
{
    UITouch *touch;
    
    for(UITouch *t in touches)
    {
        touch=t;
    }
    return [touch locationInView:self.view];
}


#pragma mark - setter, getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        UIImage *image = [UIImage imageNamed:@"windmill"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - image.size.width) / 2, 60, image.size.width, image.size.height)];
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.image = [UIImage imageNamed:@"windmill"];
        
        NSLog(@"_imageView.frame==%@", NSStringFromCGRect(_imageView.frame));
    }
    return _imageView;
}

- (UITextField *)textFiled
{
    if (_textFiled == nil)
    {
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, _imageView.frame.origin.y + _imageView.frame.size.height + 60, [UIScreen mainScreen].bounds.size.width, 40)];
        _textFiled.borderStyle = UITextBorderStyleLine;
        _textFiled.font = [UIFont systemFontOfSize:14];
        _textFiled.textColor = [UIColor blackColor];
    }
    return _textFiled;
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
