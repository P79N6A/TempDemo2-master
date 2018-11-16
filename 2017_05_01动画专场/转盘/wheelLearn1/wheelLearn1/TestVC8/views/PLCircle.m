//
//  PLCircle.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "PLCircle.h"


#define ToRad(deg)      ( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)      ( (180.0 * (rad)) / M_PI )
#define SQR(x)          ( (x) * (x) )




@interface PLCircle()

// 黑色的圆的半径
@property (nonatomic, assign) CGFloat radius;

@end

@implementation PLCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.radius = self.frame.size.width / 2 - PL_SLIDER_BG_LINE_WIDTH - 10;
        self.angle = 20;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 1. 绘制制背景
    //（x，y）是弧的中心
    // self.radius 半径
    // startAngle 起始角度   endAngle 终止角度
    // clockwise 1 表示顺时针，0表示逆时针
    CGContextAddArc(ctx, self.frame.size.width / 2, self.frame.size.height / 2, self.radius, 0, M_PI*2, 1);
    
    [[UIColor blackColor] setStroke];
    CGContextSetLineWidth(ctx, PL_SLIDER_BG_LINE_WIDTH);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    

    
    // 2. 绘制Mask 遮掩层 用于获取圆环选区
    UIGraphicsBeginImageContext(CGSizeMake(PL_SLIDER_WIDTH, PL_SLIDER_WIDTH));
    CGContextRef imgCtx = UIGraphicsGetCurrentContext();
    CGContextAddArc(imgCtx, PL_SLIDER_WIDTH/2, PL_SLIDER_WIDTH/2, _radius, 0, ToRad(self.angle), 0);
    
    
    //The clockwise parameter determines the direction in which the arc is created; the actual direction of the final path is dependent on the current transformation matrix of the graphics context. For example, on iOS, a UIView flips the Y-coordinate by scaling the Y values by -1. In a flipped coordinate system, specifying a clockwise arc results in a counterclockwise arc after the transformation is applied.
    
    
    //这是说，方向实际由graphics context的变换矩阵决定。比如在UIView中，Y轴被翻转之后，顺时针的将会变成逆时针的。所以你需要检查你实验用的环境中具体采取了什么变换。
    
    //1与0 默认1 是顺时针 但是用到UIView之中后 1是逆时针
    
    //绘制角为逆时针的
    //界面角为顺时针的所以 绘制角度=360-界面(计算)角
    
    //为什么不使用顺时针绘制
    //不论顺时针逆时针 都可以得出 360-计算角=绘制角
    //如果用顺时针，则绘制角与实际大小成反比 既 计算角270度时，绘制角为90 实际绘制270度。此时成反比不利于计算
    //如果用逆时针，则绘制角与实际大小成正比 既 计算角270度时，绘制角为90 实际绘制90度。利于计算
    
    
    CGContextSetShadowWithColor(imgCtx, CGSizeMake(0, 0), self.angle/20, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(imgCtx, PL_SLIDER_LINE_WIDTH);
    CGContextDrawPath(imgCtx, kCGPathStroke);
    
    
    
    //保存context到图片掩盖层
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    //获得切割后的Context
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, self.bounds, mask);
    CGImageRelease(mask);
    
    
    
    //绘制渐变
    CGFloat components[8] = {
        0.78, 0.80, 0.82, 1.0,     // 开始色
        0.05, 0.05, 0.05, 1.0 };   // 结束色
    //可配置4的倍数 配置改变时需要修改CGGradientCreateWithColorComponents最后的参数
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, components, NULL, 2);
    CGColorSpaceRelease(baseSpace);
    baseSpace=NULL;
    
    //绘制渐变
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    //绘制渐变
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient),
    gradient = NULL;
    CGContextRestoreGState(ctx);
    
    // 3. handle 圆圈上的白色旋钮
    [self drawTheHandle:ctx];
}


#pragma mark - 创建UI

- (void)createUI
{
    
}


#pragma mark - 按钮响应事件

/** Draw a white knob over the circle **/
- (void)drawTheHandle:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    
    //I Love shadows
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 3, [UIColor blackColor].CGColor);
    
    //Get the handle position
    CGPoint handleCenter =  [self pointFromAngle: self.angle];
    
    //Draw It!
    [[UIColor colorWithWhite:1.0 alpha:0.7]set];
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x, handleCenter.y, PL_SLIDER_LINE_WIDTH, PL_SLIDER_LINE_WIDTH));
    
    CGContextRestoreGState(ctx);
}


/** Move the Handle **/
- (void)movehandle:(CGPoint)lastPoint
{
    //Get the center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    //Calculate the direction from a center point and a arbitrary position.
    float currentAngle = AngleFromNorth(centerPoint, lastPoint, NO);
    NSLog(@"currentAngle:%f ToRad(self.angle):%f",currentAngle,ToRad(self.angle));
    int angleInt = floor(currentAngle);
    
    //Store the new angle
    self.angle = 360 - angleInt;
    
    
    //      self.angle = angleInt;
    //Update the textfield
    //    int result=self.angle*size/360;
    //    _textField.text =  [NSString stringWithFormat:@"%d", result];
    
    //Redraw
    [self setNeedsDisplay];
}



/** Given the angle, get the point position on circumference **/
- (CGPoint)pointFromAngle:(int)angleInt
{
    //Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - PL_SLIDER_LINE_WIDTH/2, self.frame.size.height/2 - PL_SLIDER_LINE_WIDTH/2);
    
    //The point position on the circumference
    CGPoint result;
    result.y = round(centerPoint.y + _radius * sin(ToRad(-angleInt))) ;
    result.x = round(centerPoint.x + _radius * cos(ToRad(-angleInt)));
    
    return result;
}

//Sourcecode from Apple example clockControl
//Calculate the direction in degrees from a center point to an arbitrary position.
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped)
{
    CGPoint v = CGPointMake(p2.x - p1.x, p2.y - p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    return (result >=0  ? result : result + 360.0);
}



#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - UIControl Override -


/** Tracking is started **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    //We need to track continuously
    return YES;
}

/** Track continuos touch event (like drag) **/
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    //Get touch location
    CGPoint lastPoint = [touch locationInView:self];
    
    //Use the location to design the Handle
    [self movehandle:lastPoint];
    
    //Control value has changed, let's notify that
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

/** Track is finished **/
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
}


#pragma mark - setter, getter



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
