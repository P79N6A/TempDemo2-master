//
//  MYHSliderChangeLabelFont.m
//  sliderToChangeLabelFont
//
//  Created by myh on 16/7/10.
//  Copyright © 2016年 myh. All rights reserved.
//

#import "MYHSliderChangeLabelFont.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface MYHSliderChangeLabelFont (){
    
    
    UIView *_Fatherview;//  等价于要传进来的self.view
    int _value;  // 记录当前label的font
    
}


@end



@implementation MYHSliderChangeLabelFont

static MYHSliderChangeLabelFont *sliderChangeLabel;

+ (instancetype)shareInsance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sliderChangeLabel == nil) {
            sliderChangeLabel = [[MYHSliderChangeLabelFont alloc]init];
        }
    });
    
    return sliderChangeLabel;
}

//  实例化slider对象
- (UISlider *)setupSliderWithFrame:(CGRect)rect addView:(UIView *)view minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue currentValue:(CGFloat)currentValue  {
    
    UISlider *slider    = [[UISlider alloc]init];
    slider.frame        = rect;
    slider.value        = currentValue;
    slider.minimumValue = minValue;
    slider.maximumValue = maxValue;
    
    [slider addTarget:self action:@selector(changeSize:) forControlEvents:UIControlEventValueChanged];
    _Fatherview = view;
    
    [view addSubview:slider];
    [view bringSubviewToFront:slider];
    return slider;
    
}
- (void)changeSize:(UISlider *)slider{
    
    NSString *sizeStr =[NSString stringWithFormat:@"%lf",slider.value];
    NSDictionary *dict = @{@"labelSize":sizeStr};
    
    [self searchLabelInView:_Fatherview slider:slider];
    
    // 创建一个通知来让window的subview的子视图对应的label 改变大小
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changesize" object:nil userInfo:dict];
    // 黑魔法交换这两个方法   原因:避免他们两个方法重复报错
    Method method1 = class_getClassMethod([[NSNotificationCenter defaultCenter] class], @selector(changeSize:));
    Method method2 = class_getClassMethod([[NSNotificationCenter defaultCenter] class], @selector(sizeChange:));
    method_exchangeImplementations(method1, method2);
    
}
- (void)listenNotify{
    
    /**n
     *  在appdelegate里面要实现的方法 接收通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sizeChange:) name:@"changesize" object:nil];
    
    
}
- (void)searchLabelInView:(UIView *)View slider:(UISlider *)slider{

    for (UIView  * view in View.subviews  ) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            [label sizeToFit];
            _value =(int)label.font;
            [UIView animateWithDuration:0.5 animations:^{
                label.font = [UIFont systemFontOfSize:slider.value];
                 
            }];
        }
        [self searchLabelInView:view slider:slider];// 递归的思想不停的向下遍历
    }
}
- (void)sizeChange:(NSNotification *)note{
    
    
    UIViewController *ViewController = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    for (UIViewController *VC in ViewController.childViewControllers) {
        
        UIView *VCview = VC.view;
        for (UIView *view in VCview.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)view ;
                [label sizeToFit];
                _value = (int)label.font ;
                [UIView animateWithDuration:0.5 animations:^{
                    label.font = [UIFont systemFontOfSize:[note.userInfo[@"labelSize"]integerValue]];
                      [label sizeToFit];
                }];
            }
        }
    }
    
}

@end
