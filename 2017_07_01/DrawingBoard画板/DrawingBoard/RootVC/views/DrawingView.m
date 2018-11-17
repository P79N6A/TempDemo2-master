//
//  DrawingView.m
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DrawingView.h"
#import "LineModel.h"

@interface DrawingView ()

/// 存放所有移动过程中的点(包括起始点)
@property (nonatomic, strong) NSMutableArray *movePoints;

/// 存放所有已绘制路径
@property (nonatomic, strong) NSMutableArray *allPointsArr;

/// 存放所有之前绘制好的线模型
@property (nonatomic, strong) NSMutableArray *oldLineArr;



@end

@implementation DrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)setUI
{
    _curLineColor = [UIColor blackColor];
    _curLineWidth = 3;
}

#pragma mark - setter, getter

- (NSMutableArray *)movePoints
{
    if (_movePoints == nil)
    {
        _movePoints = [[NSMutableArray alloc] init];
    }
    return _movePoints;
}

- (NSMutableArray *)oldLineArr
{
    if (_oldLineArr == nil)
    {
        _oldLineArr = [[NSMutableArray alloc] init];
    }
    return _oldLineArr;
}

- (NSMutableArray *)allPointsArr
{
    if (_allPointsArr == nil)
    {
        _allPointsArr = [[NSMutableArray alloc] init];
    }
    return _allPointsArr;
}

- (void)setCurLineColor:(UIColor *)curLineColor
{
    _curLineColor = curLineColor;
    [self setNeedsDisplay];
}

- (void)setCurLineWidth:(CGFloat)curLineWidth
{
    _curLineWidth = curLineWidth;
    [self setNeedsDisplay];
}

#pragma mark - 按钮响应事件

- (void)rubberLine
{
    // 设置橡皮擦 线条的 颜色 宽度
    _curLineColor = self.backgroundColor;
    _curLineWidth = 10.0;
}

- (void)revoke
{
    [self.allPointsArr removeLastObject];
    [self.oldLineArr removeLastObject];
    
    [self setNeedsDisplay];
}

- (void)clearScreen
{
    LineModel *model = [self.oldLineArr lastObject];
    if (model)
    {
        _curLineColor = model.lineColor;
        _curLineWidth = model.lineWidth;
    }
    else
    {
        _curLineColor = [UIColor blackColor];
        _curLineWidth = 3.0;
    }
    
    [self.allPointsArr removeAllObjects];
    self.allPointsArr = nil;
    [self.oldLineArr removeLastObject];
    self.oldLineArr = nil;
    
    // 调用drawRect
    [self setNeedsDisplay];
}

- (void)fromPointToLineWithContext:(CGContextRef)context withPoingArr:(NSArray *)arr
{
    for (NSInteger i = 0; i < arr.count - 1; i++)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPoint point1 = [arr[i] CGPointValue];
        
        CGPathMoveToPoint(path, nil, point1.x, point1.y);
        
        
        CGContextSetLineCap(context, kCGLineCapRound);
        
        CGPoint point2 = [arr[i + 1] CGPointValue];
        CGPathAddLineToPoint(path, nil, point2.x, point2.y);
        
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathStroke);
        
        //----------------保存以前样式--------------------
        //        UIColor *color = _colorLine;
        //        NSInteger width = _widthLine;
    }

}


#pragma mark - 重写drawRect方法
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSInteger i = 0; i < self.allPointsArr.count; i++)
    {
        LineModel *model = self.oldLineArr[i];
        CGContextSetLineWidth(context, model.lineWidth);
        [model.lineColor setStroke];
        NSArray *arr = self.allPointsArr[i];
        //调用划线方法
        [self fromPointToLineWithContext:context withPoingArr:arr];
    }
    
    
    if (self.movePoints == nil || self.movePoints.count < 2)
    {
        return;
    }
    [_curLineColor setStroke];
    CGContextSetLineWidth(context, _curLineWidth);
    //调用划线方法
    [self fromPointToLineWithContext:context withPoingArr:self.movePoints];

}

#pragma mark - touches 事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    // 取得手指的起始点
    CGPoint point = [touch locationInView:self];
    [self.movePoints addObject:[NSValue valueWithCGPoint:point]];
    
    
    LineModel *model = [[LineModel alloc] init];
    model.lineColor = _curLineColor;
    model.lineWidth = _curLineWidth;
    [self.oldLineArr addObject:model];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.movePoints addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.allPointsArr addObject:self.movePoints];
    self.movePoints = nil;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.allPointsArr addObject:self.movePoints];
    self.movePoints = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
