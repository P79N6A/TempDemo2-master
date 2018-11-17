//
//  MYHSliderChangeLabelFont.h
//  sliderToChangeLabelFont
//
//  Created by myh on 16/7/10.
//  Copyright © 2016年 myh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MYHSliderChangeLabelFont : NSObject

/**
 *  单例模式创建对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)shareInsance;
/**
 *  对象方法设置slider来改变项目的字体大小
 *
 *  @param rect         slider的frame
 *  @param view         slider要添加在哪个view
 *  @param minValue     slider的最小值
 *  @param maxValue      slider的最大值
 *  @param currentValue slider的当前值
 *
 *  @return slider
 */
- (UISlider *)setupSliderWithFrame:(CGRect )rect addView:(UIView *)view minValue:(CGFloat )minValue maxValue:(CGFloat )maxValue currentValue:(CGFloat )currentValue ;
/**
 *  在appdelegate里面需要调用的方法  记住:接收通知  一定要注销通知
 */
- (void)listenNotify;


@end
