//
//  YLWheelView.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/5/31.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "YLWheelView.h"
#import "YLWheelHelper.h"



@interface YLWheelView ()
{
    CADisplayLink *_displayLink;

//    NSTimer *_timer ;

    CGPoint _touchStartPoint;
    CGPoint _touchEndPoint;
    
    NSDate *_toucheBeginTime;

}

@property (nonatomic, strong) UIImageView *imageView;

// 当前转动的速度
@property (nonatomic, assign) CGFloat currentSpeed;

// 当前转动的方向
@property (nonatomic, assign) RotateDirection currentDirection;


@end

@implementation YLWheelView

- (void)dealloc
{
    [_displayLink invalidate];
    _displayLink = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}


#pragma mark - 创建UI

- (void)createUI
{
    [self addSubview:self.imageView];
    
    _currentSpeed = MIN_SPEED;
    _currentDirection = RotateDirectionClockwise;
    
    
    [self startRotate];
}


#pragma mark - 按钮响应事件

- (void)stopRotate
{
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)startRotate
{
    if (!_displayLink) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerUpdateAction) userInfo:nil repeats:YES] ;
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
//        _displayLink.frameInterval = 60;
        _displayLink.preferredFramesPerSecond = 20;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)handleDisplayLink:(CADisplayLink *)disPlay
{
//    NSLog(@"timerUpdateAction");
    
    if(_currentSpeed > MIN_SPEED)
    {
        _currentSpeed -= 0.05 ;
    }
    
    if(_currentSpeed < MIN_SPEED)
    {
        _currentSpeed = MIN_SPEED;
    }

    // 意思是如果_currentSpeed 速度小于最小值，就让_currentSpeed 等于最小值，
    // 如果速度 _currentSpeed 大于最小值，就让它 _currentSpeed 通过这个方法不断减小到最小值
    
    [self rotateWithSpeed:_currentSpeed];
}


- (void)rotateWithSpeed:(CGFloat)speed
{
    CGFloat angle = speed * ( M_PI);
//    NSLog(@"angle==%f", angle);
    
    // 如果是逆时针方向，则旋转角度设置取反
    if(_currentDirection == RotateDirectionAnticlockwise) {
        angle = -angle;
    }
    
    [UIView animateWithDuration: (1.0 / 20.0) animations:^{
        [self rotateWithAngle:angle];
    }];
}

- (void)rotateWithAngle:(CGFloat)angle
{
    CGAffineTransform originTransform = self.imageView.transform;
    self.imageView.transform = CGAffineTransformRotate(originTransform, angle);
}

#pragma mark - 网络请求


#pragma mark - 代理方法

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *myTouch = [touches anyObject];
    _touchStartPoint = [myTouch locationInView:self];

    
    [self stopRotate];
//    _touchStartPoint = [self getLocationFromTouches:touches];
    _toucheBeginTime = [NSDate date];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
 
    UITouch *myTouch = [touches anyObject];
    _touchEndPoint = [myTouch locationInView:self];

    CGFloat distance = [YLWheelHelper getDistanceWithStartPoint:_touchStartPoint
                                                       endPoint:_touchEndPoint];
    
    if(distance > 1.0) {

        // 让它跟随旋转
        [self dragRotate:_touchStartPoint
                endPoint:_touchEndPoint];
        
        _touchStartPoint = _touchEndPoint;
    }
}


// 拖动滑动转盘旋转
- (void)dragRotate:(CGPoint)startPoint
          endPoint:(CGPoint)endPoint
{
    CGFloat angle = [YLWheelHelper calculateAngle:startPoint
                                         endPoint:endPoint
                                      centerPoint:self.center];
    
    _currentDirection = [YLWheelHelper getRotateDirection:startPoint
                                                 endPoint:endPoint
                                              centerPoint:self.center];
    
    NSTimeInterval timeInterval = [_toucheBeginTime timeIntervalSinceNow];
    _currentSpeed = [YLWheelHelper calculateSpeed:startPoint
                                         endPoint:endPoint
                                     timeInterval:timeInterval];
    
    NSString *str1 = [NSString stringWithFormat:@"speed:%lf",_currentSpeed];
    //    [self.textFiled setText:str1];
    NSLog(@"str1==%@", str1);

    
    if(_currentDirection == RotateDirectionAnticlockwise) {
        angle = -angle;
    }

    [self rotateWithAngle:angle];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self startRotate];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
}


#pragma mark - setter, getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        UIImage *image = [UIImage imageNamed:@"windmill"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width - image.size.width) / 2, (self.bounds.size.height - image.size.height) / 2, image.size.width, image.size.height)];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.image = [UIImage imageNamed:@"windmill"];
        
        NSLog(@"_imageView.frame==%@", NSStringFromCGRect(_imageView.frame));
    }
    return _imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
