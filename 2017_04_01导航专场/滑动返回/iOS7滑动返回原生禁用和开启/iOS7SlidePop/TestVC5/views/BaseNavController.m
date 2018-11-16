//
//  BaseNavController.m
//  iOS7SlidePop
//
//  Created by xiaoyulong on 16/7/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "BaseNavController.h"
#import <objc/runtime.h>

@interface BaseNavController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isCanSlideBack = YES;
    
    unsigned int count = 0;
    Ivar *var = class_copyIvarList([UIGestureRecognizer class],  &count);
    for (int i = 0; i < count; i++)
    {
        Ivar _var = *(var+i);
        NSLog(@"%s", ivar_getTypeEncoding(_var));
        NSLog(@"%s", ivar_getName(_var));
    }
    
    
    
    /**
     * 获取系统手势的target数组
     */
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    NSLog(@"gesture is %@", gesture);
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    
    
    
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    NSLog(@"_targets is %@", _targets);
    
    
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    NSLog(@"gestureRecognizerTarget is %@", gestureRecognizerTarget);
    
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    NSLog(@"navigationInteractiveTransition is %@", navigationInteractiveTransition);
    
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click1
{
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    /**
     * 这里有两个条件不允许手势执行，
     1.当前控制器为根控制器；
     2.如果这个push、pop动画正在执行（私有属性）
     */
    if (self.viewControllers.count != 1 &&
        ![[self valueForKey:@"_isTransitioning"] boolValue] &&
        _isCanSlideBack)
    {
        return YES;
    }
    return NO;
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
