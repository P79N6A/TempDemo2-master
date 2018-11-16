//
//  TestVC25.m
//  Animation
//
//  Created by yulong on 16/2/16.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC25.h"
#import "RippleView.h"
#import "DynamicView.h"
#import "DrawModel.h"

@interface TestVC25 ()
{
    NSTimer         *_timer;
    NSMutableArray  * _dataArr;
    NSInteger       _pointCount;
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) DynamicView *dynamicView;


@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) RippleView *rippleView;

@end

@implementation TestVC25

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
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.dynamicView];
    
    _dataArr = [NSMutableArray array];
    if (_dataArr.count != 0) {
        [_dataArr removeAllObjects];
    }
    
    NSArray *arr = @[@"100", @"38",@"19",@"47",@"77",@"42"];
    NSArray *arr2 = @[@"01/09", @"01/08", @"01/07", @"01/06", @"01/05", @"01/04"];
    for (NSInteger i = 0; i < 6; i++)
    {
        DrawModel *dMdoel = [[DrawModel alloc] init];
        dMdoel.score = arr[i];
        dMdoel.timetwo = arr2[i];
        [_dataArr addObject:dMdoel];
    }

    
    if (_dataArr.count != 0)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(sendNumber) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    //结果详情
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.frame = CGRectMake(10, 270, 100, 20);
    detailLabel.text = @"结果详情";
    detailLabel.textColor = UIColorRGB(130, 130, 130);
    // detailLabel.backgroundColor =  [UIColor blackColor];
    detailLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    [self.view addSubview:detailLabel];
    
    
    [self.view addSubview:self.blackView];
    [self.blackView addSubview:self.rippleView];
}

#pragma mark - setter, getter

- (UIScrollView *)mainScrollView
{
    if (_mainScrollView == nil)
    {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, DynamicViewHeight)];
        _mainScrollView.backgroundColor = [UIColor colorWithRed:241/255.0 green:212/255.0 blue:95/255.0 alpha:1.0];
        _mainScrollView.showsHorizontalScrollIndicator = YES;
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.bounces = YES;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.contentSize = CGSizeMake(0, 0);

    }
    return _mainScrollView;
}

- (DynamicView *)dynamicView
{
    if (_dynamicView == nil)
    {
        _dynamicView = [[DynamicView alloc] initWithFrame:self.mainScrollView.bounds];
        _dynamicView.backgroundColor = [UIColor clearColor];
    }
    return _dynamicView;
}

- (UIView *)blackView
{
    if (_blackView == nil)
    {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width-40, 250)];
        _blackView.backgroundColor = [UIColor blackColor];
    }
    return _blackView;
}

- (RippleView *)rippleView
{
    if (_rippleView == nil)
    {
        _rippleView = [[RippleView alloc] initWithFrame:CGRectMake(100, 100, RippleViewHeight, RippleViewHeight)];
        _rippleView.backgroundColor = [UIColor blueColor];
        
        __weak typeof(self) weakSelf = self;
        _rippleView.rippleBlock = ^(){
            [weakSelf testRippleAnimation];
        };
    }
    return _rippleView;
}

#pragma mark - 按钮响应事件


- (void)testRippleAnimation
{
    CGRect pathFrame = CGRectMake(-10, -10, 20, 20);
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:10.0];

    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = bezierPath.CGPath;
    circleShape.position = CGPointMake(50, 30);
    circleShape.fillColor = [UIColor yellowColor].CGColor;
    circleShape.opacity = 1.0;
    circleShape.strokeColor = [UIColor whiteColor].CGColor;
    circleShape.lineWidth = 2;
    [self.blackView.layer addSublayer:circleShape];

    
    
    // 放大
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
    
    // 不透明度 从1 到 0
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[scaleAnimation, alphaAnimation];
    groupAnimation.duration = 0.5f;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:groupAnimation forKey:nil];
}


#pragma mark - 网络请求

- (void)sendNumber
{
    NSLog(@"_point = %ld ++ ",_pointCount);
    
    //点转换的位置  纵坐标
    
    DrawModel *dModel = nil;
    if (_dataArr.count != 0)
    {
        dModel = _dataArr[_pointCount];
    }
    
    [self.dynamicView drawDynamicViewWith:dModel];
    [self.dynamicView drawDottedLineWith:_dataArr];
    
    _pointCount++;
    
    if (_pointCount >= _dataArr.count)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    
    NSLog(@"_point = %ld -- ",_pointCount);
}

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
