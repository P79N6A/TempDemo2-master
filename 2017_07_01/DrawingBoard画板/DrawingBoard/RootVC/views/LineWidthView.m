//
//  LineWidthView.m
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "LineWidthView.h"

#define kTag_15000 (15000)

@interface LineWidthView ()

@property (nonatomic, strong) NSMutableArray *widthArray;

@end

@implementation LineWidthView

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
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width / self.widthArray.count;
    for (NSInteger i = 0; i < self.widthArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = kTag_15000+i;
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, LineWidthViewHeight);
        [btn setTitle:self.widthArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark - setter, getter

- (NSMutableArray *)widthArray
{
    if (_widthArray == nil)
    {
        NSArray *arr = @[@"1",@"3",@"5",@"8",@"10",@"15",@"20"];
        _widthArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < arr.count; i++)
        {
            [_widthArray addObject:arr[i]];
        }
    }
    return _widthArray;
}

#pragma mark - 按钮响应事件

- (void)btnClick:(UIButton *)sender
{
    NSInteger index = sender.tag-kTag_15000;
    NSLog(@"width\n%@", self.widthArray[index]);
    CGFloat width = [sender titleForState:UIControlStateNormal].floatValue;
    if (_selectLineWidthBlock)
    {
        _selectLineWidthBlock(width);
    }
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
