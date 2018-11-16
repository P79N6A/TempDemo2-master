//
//  NavigationInteractiveTransition.m
//  slidePop
//
//  Created by yulong on 15/5/8.
//  Copyright (c) 2015年 HuiXin. All rights reserved.
//

#import "NavigationInteractiveTransition.h"
#import "PopAnimation.h"

@interface NavigationInteractiveTransition ()

@property (nonatomic, weak) UINavigationController *vc;

/// 百分比 驱动 交互式的 过渡
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation NavigationInteractiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        self.vc = (UINavigationController *)vc;
        self.vc.delegate = self;

    }
    return self;
}


/**
 *  我们把用户的每次Pan手势操作为一次pop动画的执行
 */
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer
{
    /**
     * interactivePopTransition就是我们说的方法2返回的对象,我们需要更新它的进度来控制Pop动画的流程,我们用手指在视图中的位置与视图宽度比例作为它的进度。
     */
    
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    
    /**
     * 稳定进度区间，让它在0.0 （未完成）～1.0（已完成）之间
     */
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        /**
         * 手势开始，新建一个监控对象
         */
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        /**
         *  告诉控制器开始执行pop的动画
         */
        [self.vc popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        /**
         * 更新手势的完成进度
         */
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        /**
         * 手势结束时如果进度大于一半，那么就完成pop操作，否则重新来过
         */
        if (progress > 0.5)
        {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    /**
     *  方法1中判断如果当前执行的是Pop操作，就返回我们自定义的Pop动画对象。
     */
    if (operation == UINavigationControllerOperationPop)
        return [[PopAnimation alloc] init];
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    /**
     *  方法2会传给你当前的动画对象animationController，判断如果是我们自定义的Pop动画对象，那么就返回interactivePopTransition来监控动画完成度。
     */
    if ([animationController isKindOfClass:[PopAnimation class]])
        return self.interactivePopTransition;
    
    return nil;
}

//你可以这样理解，苹果让我们返回一个交互的对象，用来实时管理控制器之间转场动画的完成度，通过它我们可以让控制器的转场动画与用户交互（注意一点，如果方法1返回是nil，方法2是不会调用的，也就是说，只有我们自定义的动画才可以与控制器交互）。





@end
