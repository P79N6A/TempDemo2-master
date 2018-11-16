//
//  DynamicView.m
//  Animation
//
//  Created by yulong on 16/2/16.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DynamicView.h"
#import "RippleView.h"

static CGFloat const leftVerticalViewWidth = 35.0;

@implementation DynamicView
{
    //实线的点
    CGPoint         _sPoint[10000];
    NSMutableArray  *_lineArray;
    int             _i;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineArray= [NSMutableArray array];
        _i = 1;
        self.backgroundColor = [UIColor clearColor];
        
        [self createVerticalLabels];

    }
    return self;
}

//左侧的点
- (void)createVerticalLabels
{
    UIView *verticalView = [[UIView alloc] init];
    verticalView.frame = CGRectMake(0, 0, leftVerticalViewWidth, 200 - 6);
//    vertView.backgroundColor = [UIColor redColor];
    verticalView.backgroundColor = UIColorRGB(240, 183, 95);
    [self addSubview:verticalView];
    
    
    NSInteger j = 0;
    for (NSInteger i = 5; i >= 0; i--)
    {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5,10 + j * 30, 25, 25)];
        label.text = [NSString stringWithFormat:@"%ld",i*20];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = UIColorHex(0xffffff);
        label.backgroundColor = [UIColor clearColor];
        label.alpha = 0.5f;
        
        NSLog(@"label.center.y is %f", label.center.y);
        
        j++;
        [verticalView addSubview:label];
    }
    
//    UIView *vertLine = [[UIView alloc] init];
//    vertLine.frame = CGRectMake(0, CGRectGetMaxY(verticalView.frame), verticalView.frame.size.width, 3);
////    vertLine.backgroundColor = UIColorHex(0xc28b4b);
//    [self addSubview:vertLine];
//    
//    
//    UIView *rightLine = [[UIView alloc] init];
//    rightLine.frame = CGRectMake(CGRectGetMaxX(vertLine.frame), vertLine.frame.origin.y, self.bounds.size.width - vertLine.frame.size.width, vertLine.frame.size.height);
////    rightLine.backgroundColor = UIColorHex(0xf4af5e);
//    [self addSubview:rightLine];
    
}

- (void)drawDottedLineWith:(NSMutableArray *)dataArr
{
    _lineArray = dataArr;
}

- (void)drawDynamicViewWith:(DrawModel *)dModel
{
    int number = dModel.score.intValue;
    NSLog(@"number = %d",dModel.score.intValue);
    
    CGFloat space = ([UIScreen mainScreen].bounds.size.width - leftVerticalViewWidth) / 7;

    _sPoint[_i-1] = CGPointMake(_i * space + leftVerticalViewWidth,172.5 - number * 1.5);
    NSLog(@"number = %d",number);
    
    
    
    //创建按钮
    RippleView *ripple = [[RippleView alloc] initWithFrame:CGRectMake(_i * space+leftVerticalViewWidth, 172.5 - number * 1.5, 40, 40)];
    ripple.center = CGPointMake(_i * space+leftVerticalViewWidth, 172.5 - number * 1.5);
    ripple.backgroundColor  = [UIColor clearColor];
    [self addSubview:ripple];
    
    
    //下面的日期label
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(CGRectGetMinX(ripple.frame)- 5, self.frame.size.height - 25, 30, 20);
    label.center = CGPointMake(ripple.center.x, self.frame.size.height - 15);
    label.text = [NSString stringWithFormat:@"%@",dModel.timetwo];
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = UIColorHex(0xffffff);
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    
    _i++;
    
    
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
    //画实线
    CGContextRef context = UIGraphicsGetCurrentContext();
    //线的颜色
    CGContextSetStrokeColorWithColor(context, UIColorHex(0xffffff).CGColor);
    CGContextAddLines(context, _sPoint, _i-1);
    //线的大小
    CGContextSetLineWidth(context, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    for (int i = 0; i < _lineArray.count; i++)
    {
        CGPoint point = _sPoint[i];
        
        //水平线
        CGContextRef horizontalContext = UIGraphicsGetCurrentContext();
        CGFloat lengths1[] = {5,5};
        CGContextSetStrokeColorWithColor(horizontalContext, UIColorHex(0xffffff).CGColor);
        CGContextSetLineDash(horizontalContext, 0, lengths1, 2);
        CGContextSetLineWidth(horizontalContext, 2);
        CGContextMoveToPoint(horizontalContext,point.x, point.y);
        CGContextAddLineToPoint(horizontalContext, 15, point.y);
        CGContextStrokePath(horizontalContext);
        
        
        //垂直线
        CGContextRef verticalContext = UIGraphicsGetCurrentContext();
        //        CGFloat lengths1[] = {5,5};
        CGContextSetStrokeColorWithColor(verticalContext, UIColorHex(0xffffff).CGColor);
        CGContextSetLineDash(verticalContext, 0, lengths1, 2);
        CGContextSetLineWidth(verticalContext, 2);
        CGContextMoveToPoint(verticalContext,point.x, point.y);
        //        CGContextAddLineToPoint(verticalContext, 15, point.y);
        CGContextAddLineToPoint(verticalContext, point.x, 172.5);
        CGContextStrokePath(verticalContext);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
