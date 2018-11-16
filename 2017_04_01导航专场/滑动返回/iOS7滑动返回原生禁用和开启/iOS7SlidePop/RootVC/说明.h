

（1）

Xcode 5.0以上创建的工程，
iOS 7 以上 都支持滑动pop手势返回功能。


如果导航栏的返回按钮是自定义的那么则会失效，
导航栏单纯隐藏的话那么则会失效；

（2）
禁用和开启滑动返回功能

#pragma mark - 方法一：

/**
 如果是针对这个controller禁用右滑动返回手势
 */
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //禁用 iOS 7 滑动返回手势
    if (SYSTEM_VERSION >= 7.0)
    {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //这个Controller消失后就开启滑动返回功能
    if (SYSTEM_VERSION >= 7.0)
    {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}


#pragma mark - 方法二：

这个设置代理的容易崩，也没有报错什么原因，不要用

遵循代理  UIGestureRecognizerDelegate


在 代理方法中设置


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"gestureRecognizerShouldBegin");
    
    if (self.navigationController.interactivePopGestureRecognizer == gestureRecognizer)
    {
        return NO;
    }
    return YES;
}



