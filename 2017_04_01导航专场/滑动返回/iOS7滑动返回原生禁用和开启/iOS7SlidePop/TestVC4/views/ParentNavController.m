//
//  ParentNavController.m
//  slidePop
//
//  Created by yulong on 15/5/8.
//  Copyright (c) 2015年 HuiXin. All rights reserved.
//

#import "ParentNavController.h"
#import "NavigationInteractiveTransition.h"

@interface ParentNavController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NavigationInteractiveTransition *navT;

@end

@implementation ParentNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isCanSlideBack = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIsCanSlideBack:(BOOL)isCanSlideBack
{
    _isCanSlideBack = isCanSlideBack;
    
    if (_isCanSlideBack)
    {
        UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
        gesture.enabled = NO;
        UIView *gestureView = gesture.view;
        
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
        popRecognizer.delegate = self;
        popRecognizer.maximumNumberOfTouches = 1;
        [gestureView addGestureRecognizer:popRecognizer];
        
        _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
        [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    }
    else
    {
        _navT = nil;
    }
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
        ![[self valueForKey:@"_isTransitioning"] boolValue])
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
