//
//  MLNavigationController.m
//  SlideBack2
//
//  Created by yulong on 15/3/11.
//  Copyright (c) 2015年 yulong. All rights reserved.
//

#import "MLNavigationController.h"
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define TOP_VIEW  [[UIApplication sharedApplication]keyWindow].rootViewController.view
/**
 屏幕宽度，屏幕高度
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



@interface MLNavigationController () <UIGestureRecognizerDelegate>
{
    CGPoint _startTouch;
    UIView  *blackMask;
    
    UIImageView *lastScreenShotView;


}

@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) NSMutableArray *screenShotsList;


@end

@implementation MLNavigationController

- (void)dealloc
{
    self.screenShotsList = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
//    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _canDragBack = YES;
        _screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     // draw a shadow for navigation view to differ the layers obviously.
     // using this way to draw shadow will lead to the low performace
     // the best alternative way is making a shadow image.
     画一个不同于导航视图不同的层的明显的阴影
     用这种方法会导致低性能
     
     最好的选择是用一张阴影图片
     */
    
//    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.view.layer.shadowOffset = CGSizeMake(5, 5);
//    self.view.layer.shadowRadius = 5;
//    self.view.layer.shadowOpacity = 1;
    
    UIImageView *shadowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 10, TOP_VIEW.frame.size.height)];
    shadowImgView.image = [UIImage imageNamed:@"leftside_shadow_bg"];
    [TOP_VIEW addSubview:shadowImgView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paningGestureReceive:)];
    pan.delegate = self;
    [pan delaysTouchesBegan];
    [self.view addGestureRecognizer:pan];
    
    
    
}

// get the current view screen shot
- (UIImage *)captureScreen
{
    UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_screenShotsList.count == 0) {
        UIImage *capturedImg = [self captureScreen];
        if (capturedImg) {
            [_screenShotsList addObject:capturedImg];
        }
    }
    
}

// override the push method
//重写PUSH方法
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImage *capturedImg = [self captureScreen];
    if (capturedImg) {
        [_screenShotsList addObject:capturedImg];
    }
    
    [super pushViewController:viewController animated:animated];
}

// override the pop method
//重写pop方法
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [_screenShotsList removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveViewWithX:(CGFloat)x
{
    NSLog(@"Move to:%f", x);
    
    //移动的横坐标x大于横屏宽，就是横屏宽度，否则是x
    x = x > SCREEN_WIDTH ? SCREEN_WIDTH : x;
    x = x < 0 ? 0 : x;
    
    CGRect  frame = TOP_VIEW.frame;
    frame.origin.x = x;
    TOP_VIEW.frame = frame;
    
    CGFloat scale = (x / 6400)+0.95;
    CGFloat alpha = 0.4 - (x / 800);
    
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
    
}


- (void) paningGestureReceive:(UIPanGestureRecognizer *) recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) {
        return;
    }
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan)
    {
        _isMoving = YES;
        _startTouch = touchPoint;
        //开始滑动，展现出最后一次的截屏，如果没有就创建
        if (!self.backgroundView) {
            CGRect frame = TOP_VIEW.frame;
            self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [TOP_VIEW.superview insertSubview:self.backgroundView belowSubview:TOP_VIEW];

            //淡淡的黑色
            blackMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        if (lastScreenShotView)
        {
            [lastScreenShotView removeFromSuperview];
        }
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        
    }
    else if (recoginzer.state == UIGestureRecognizerStateEnded)
    {
        //结束点横坐标 - 开始点横坐标
        if (touchPoint.x - _startTouch.x > 50) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:SCREEN_WIDTH];
            } completion:^(BOOL finished) {
                
                //动画完成之后，在出栈
                [self popViewControllerAnimated:NO];

                //重设
                CGRect frame = TOP_VIEW.frame;
                frame.origin.x = 0;
                TOP_VIEW.frame = frame;
                
                _isMoving = NO;
                self.backgroundView.hidden = YES;
                
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
        }
        return;
        
    }
    else if (recoginzer.state == UIGestureRecognizerStateCancelled)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        return;
    }
    
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x-_startTouch.x];
    }
    
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) {
        return NO;
    }
    return YES;
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
