//
//  RootViewController.m
//  DrawingBoard
//
//  Created by yulong on 16/1/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "TopView.h"
#import "ColorView.h"
#import "LineWidthView.h"
#import "DrawingView.h"

@interface RootViewController ()

@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) ColorView *colorView;
@property (nonatomic, strong) LineWidthView *lineWidthView;
@property (nonatomic, strong) DrawingView *drawingView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)setUI
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.colorView];
    
    
    [self.topView addSubview:self.lineWidthView];
    [self.view addSubview:self.drawingView];
    
    self.colorView.hidden = YES;
    self.lineWidthView.hidden = YES;
}

#pragma mark - setter, getter

- (TopView *)topView
{
    if (_topView == nil)
    {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, TopViewHeight)];
        _topView.backgroundColor = [UIColor lightGrayColor];

        kSelfWeak;
        _topView.topCLickBlock = ^(NSInteger index){
            kSelfStrong;
            [strongSelf handleTopClickAction:index];
        };
    }
    return _topView;
}

- (ColorView *)colorView
{
    if (_colorView == nil)
    {
        _colorView = [[ColorView alloc] initWithFrame:CGRectMake(0, btnHeight, [UIScreen mainScreen].bounds.size.width, ColorViewHeight)];
        _colorView.backgroundColor = [UIColor yellowColor];
        kSelfWeak;
        _colorView.selectColorBlock = ^(UIColor *color) {
            kSelfStrong;
            [strongSelf handleSelectColorAction:color];
        };
    }
    return _colorView;
}

- (LineWidthView *)lineWidthView
{
    if (_lineWidthView == nil)
    {
        _lineWidthView = [[LineWidthView alloc] initWithFrame:CGRectMake(0, btnHeight, [UIScreen mainScreen].bounds.size.width, LineWidthViewHeight)];
        _lineWidthView.backgroundColor = [UIColor clearColor];
        
        kSelfWeak;
        _lineWidthView.selectLineWidthBlock = ^(CGFloat width) {
            kSelfStrong;
            [strongSelf handleSelectLineWidthAction:width];
        };
    }
    return _lineWidthView;
}

- (DrawingView *)drawingView
{
    if (_drawingView == nil)
    {
        _drawingView = [[DrawingView alloc] initWithFrame:CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(_topView.frame.origin.y+_topView.frame.size.height))];
        _drawingView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    }
    return _drawingView;
}

#pragma mark - 按钮响应事件

- (void)handleSelectColorAction:(UIColor *)color
{
    self.drawingView.curLineColor = color;
}

- (void)handleSelectLineWidthAction:(CGFloat)width
{
    self.drawingView.curLineWidth = width;
}

- (void)handleTopClickAction:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"颜色");
            self.colorView.hidden = NO;
            self.lineWidthView.hidden = YES;
        }
            break;
        case 1:
        {
            NSLog(@"线宽");
            self.colorView.hidden = YES;
            self.lineWidthView.hidden = NO;
        }
            break;
        case 2:
        {
            NSLog(@"橡皮");
            self.colorView.hidden = YES;
            self.lineWidthView.hidden = YES;
            
            [self.drawingView rubberLine];
        }
            break;
        case 3:
        {
            NSLog(@"撤销");
            self.colorView.hidden = YES;
            self.lineWidthView.hidden = YES;
            
            [self.drawingView revoke];
        }
            break;
        case 4:
        {
            NSLog(@"清屏");
            self.colorView.hidden = YES;
            self.lineWidthView.hidden = YES;
            
//            [self.drawingView clearScreen];
            
            [self.drawingView removeFromSuperview];
            self.drawingView = nil;
            
            [self.view addSubview:self.drawingView];

            
        }
            break;
        default:
            break;
    }
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
