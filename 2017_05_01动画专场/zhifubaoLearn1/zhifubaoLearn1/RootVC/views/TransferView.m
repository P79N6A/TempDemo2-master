//
//  TransferView.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TransferView.h"

@interface TransferView () <CAAnimationDelegate>

@end


@implementation TransferView

+ (BOOL)needsDisplayForKey:(NSString *)key {
    BOOL result;
    if ([key isEqualToString:@"progress"]) {
        result = YES;
    } else {
        result = [super needsDisplayForKey:key];
    }
    return result;
}


- (void)animateCircle
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"progress"];
    anim.values = [self valuesListWithAnimationDuration: 3];
    anim.duration = 3.0;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [self addAnimation:anim forKey:@"circle"];
}


- (NSMutableArray *)valuesListWithAnimationDuration:(CGFloat)duration {
    NSInteger numberOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray array];
    // 注意这里的 fromValue和toValue是针对的progress的值的大小。
    CGFloat fromValue = 0.0;
    CGFloat toValue = 1.0;
    CGFloat diff = toValue - fromValue;
    for (NSInteger frame = 1; frame <= numberOfFrames; frame++) {
        CGFloat piece = (CGFloat)frame / (CGFloat)numberOfFrames;
        CGFloat currentValue = fromValue + diff * piece;
        [values addObject:@(currentValue)];
    }
    return values;
}


- (void)startCheck
{
    CGFloat viewHeight = self.frame.size.height;
    CGFloat viewWidth = self.frame.size.width;
    UIBezierPath *strokePath = [UIBezierPath bezierPath];
    [strokePath moveToPoint:CGPointMake(viewWidth * 0.25, viewHeight * 0.65)];
    [strokePath addLineToPoint:CGPointMake(viewWidth * 0.4, viewHeight * 0.75)];
    [strokePath addLineToPoint:CGPointMake(viewWidth * 0.75, viewHeight * 0.25)];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.frame = self.bounds; // 这样就可以相对于父layer计算path了。
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.lineWidth = 10;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    checkLayer.path = strokePath.CGPath;
    [self addSublayer:checkLayer];
    
    CABasicAnimation *checkAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnim.fromValue = @(0.0);
    checkAnim.toValue = @(1.0);
    checkAnim.duration = 1.0f;
    checkAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    checkAnim.delegate = self;
    [checkAnim setValue:@"check_animation" forKey:@"check_name"];
    
    [checkLayer addAnimation:checkAnim forKey:nil];
}



- (void)drawInContext:(CGContextRef)ctx {
    
    CGContextSetLineWidth(ctx, 5.0f);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    
    NSLog(@"self.roundTwo==%d", self.roundTwo);
    
    if (self.roundTwo)
    {
        CGContextAddArc(ctx, CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5, CGRectGetWidth(self.bounds) * 0.5 - 5, -M_PI_2, 33 * M_PI / 22 * self.progress, 0);
    }
    else
    {
        // 注意这里其实角度和终止角度的计算
        
        CGFloat startAngle, endAngle;
        if (self.progress <= 0.5) {
            startAngle = 55 * M_PI / 33 * self.progress - M_PI_2;
            endAngle = 22 * M_PI * self.progress - M_PI_2;
        } else {
            startAngle = 77 * M_PI / 33 * self.progress - 55 * M_PI / 6;
            endAngle = 22 * M_PI * self.progress - M_PI_2;
        }
        
        CGContextAddArc(ctx, CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5, CGRectGetWidth(self.bounds) * 0.5 - 5, startAngle, endAngle, 0);
        
        
        NSLog(@"self.progress==%f", self.progress);
    }
    
    CGContextStrokePath(ctx);
}


#pragma mark - CircleLayer
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeAnimationForKey:@"circle"];
    self.progress = 1.0;
    [self setNeedsDisplay];
    
}



@end
