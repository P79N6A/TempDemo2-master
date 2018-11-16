//
//  RootViewController.m
//  PICircularProgressView
//
//  Created by xiaoyulong on 16/6/18.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "PICircularProgressView.h"

#define kPadding (20.0)


@interface RootViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) PICircularProgressView *circularProgressView;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UISlider *progressSlider;

@property (nonatomic, strong) UILabel *thicknessLabel;
@property (nonatomic, strong) UISlider *thicknessSlider;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UISwitch *textSwitch;


@property (nonatomic, strong) UILabel *roundedLabel;
@property (nonatomic, strong) UISwitch *roundedSwitch;


@property (nonatomic, strong) UILabel *shadowLabel;
@property (nonatomic, strong) UISwitch *shadowSwitch;


@property (nonatomic, strong) UILabel *innerColorLabel;
@property (nonatomic, strong) UISwitch *innerColorSwitch;


@property (nonatomic, strong) UILabel *outerColorLabel;
@property (nonatomic, strong) UISwitch *outerColorSwitch;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    if (ISIOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.circularProgressView];
    [self.mainScrollView addSubview:self.progressLabel];
    [self.mainScrollView addSubview:self.progressSlider];
    
    [self.mainScrollView addSubview:self.thicknessLabel];
    [self.mainScrollView addSubview:self.thicknessSlider];
    
    
    [self.mainScrollView addSubview:self.textLabel];
    [self.mainScrollView addSubview:self.textSwitch];
    
    [self.mainScrollView addSubview:self.roundedLabel];
    [self.mainScrollView addSubview:self.roundedSwitch];
    
    
    [self.mainScrollView addSubview:self.shadowLabel];
    [self.mainScrollView addSubview:self.shadowSwitch];
    
    [self.mainScrollView addSubview:self.innerColorLabel];
    [self.mainScrollView addSubview:self.innerColorSwitch];
    
    [self.mainScrollView addSubview:self.outerColorLabel];
    [self.mainScrollView addSubview:self.outerColorSwitch];

    [self.mainScrollView addSubview:self.segmentedControl];
}

#pragma mark - 按钮响应事件

- (void)progressSliderChange:(UISlider *)sender
{
    NSLog(@"sender.value==%f", sender.value);
    self.circularProgressView.progress = sender.value;
}

- (void)thicknessSliderChange:(UISlider *)sender
{
    NSLog(@"sender.value==%f", sender.value);
    self.circularProgressView.thicknessRatio = sender.value;

}

- (void)textSwitchChange:(UISwitch *)sender
{
    self.circularProgressView.showText = sender.on;
}

- (void)roundedSwitchChange:(UISwitch *)sender
{
    self.circularProgressView.roundedHead = sender.on;
}

- (void)shadowSwitchChange:(UISwitch *)sender
{
    self.circularProgressView.showShadow = sender.on;
}

- (void)innerColorSwitchChange:(UISwitch *)sender
{
    self.circularProgressView.innerBackgroundColor = sender.on ? [[UIColor redColor] colorWithAlphaComponent:0.5f] : nil;
}

- (void)outerColorSwitchChange:(UISwitch *)sender
{
    self.circularProgressView.outerBackgroundColor = sender.on ? [[UIColor greenColor] colorWithAlphaComponent:0.5f] : nil;
}

- (void)segChange:(UISegmentedControl *)sender
{
    self.circularProgressView.progressFillColor = self.segmentedControl.selectedSegmentIndex == 0 ? [UIColor blueColor] : nil;

}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIScrollView *)mainScrollView
{
    if (_mainScrollView == nil)
    {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAllHeight)];
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.scrollEnabled = YES;
        _mainScrollView.pagingEnabled = NO;
        _mainScrollView.showsHorizontalScrollIndicator = YES;
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.contentSize = CGSizeMake(0, 600);
    }
    return _mainScrollView;
}

- (PICircularProgressView *)circularProgressView
{
    if (_circularProgressView == nil)
    {
        _circularProgressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake(20, 30, [UIScreen mainScreen].bounds.size.width - 40, 220)];
        _circularProgressView.backgroundColor = [UIColor clearColor];
        //        _circularProgressView.frame = CGRectMake(0, 0, 90, 90);
        //        _circularProgressView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 120);
        /*
         0~1
         */
        _circularProgressView.progress = 0.4;
        
        
        /*
         0~1
         */
        _circularProgressView.thicknessRatio = 0.15;
        _circularProgressView.showText = NO;
        _circularProgressView.showShadow  = YES;
        
        
        
        _circularProgressView.outerBackgroundColor = UIColorRGB(94, 94, 94);
        
        _circularProgressView.innerBackgroundColor = [UIColor whiteColor];
        _circularProgressView.roundedHead = YES;
        
        
        /*
         圆环进度颜色
         */
        _circularProgressView.progressFillColor = UIColorRGB(27, 159, 175);
        
        
        
        /*
         环 中心字体颜色
         */
        _circularProgressView.textColor = UIColorRGB(27, 159, 175);
        
        
        
    }
    return _circularProgressView;
}


- (UILabel *)progressLabel
{
    if (_progressLabel == nil)
    {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _circularProgressView.frame.origin.y + _circularProgressView.frame.size.height+ 10, 80, 20)];
        _progressLabel.backgroundColor = [UIColor clearColor];
        _progressLabel.font = [UIFont systemFontOfSize:16];
        
        _progressLabel.textAlignment = NSTextAlignmentLeft;
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.text = @"Progress";
    }
    return _progressLabel;
}


- (UISlider *)progressSlider
{
    if (_progressSlider == nil)
    {
        _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(_progressLabel.frame.origin.x + _progressLabel.frame.size.width+ 5, _progressLabel.frame.origin.y, kScreenWidth - (_progressLabel.frame.origin.x + _progressLabel.frame.size.width + 20), 20)];
        _progressSlider.backgroundColor = [UIColor clearColor];
        
        // 设置滑块颜色，iOS 7.0以后 这个没用了,默认白色的
//        _progressSlider.thumbTintColor = [UIColor blackColor];
        
        //设置轨道颜色
        _progressSlider.minimumTrackTintColor = [UIColor redColor];
        _progressSlider.maximumTrackTintColor = [UIColor grayColor];
        
        // 设置轨道图片
//        [_progressSlider setMinimumTrackImage:[UIImage imageNamed:@"slider_green.png"] forState:UIControlStateNormal];
//        [_progressSlider setMaximumTrackImage:[UIImage imageNamed:@"slider_yellow.png"] forState:UIControlStateNormal];
        
        // 设置滑块图片
//        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider_n"] forState:UIControlStateNormal];
//        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider_h"] forState:UIControlStateHighlighted];
        
        // 设置最大值和最小值, 系统默认最大最小0~1
        //    _slider.minimumValue = 0.0;
        //    _slider.maximumValue = 200.0;
        
        //设置初始值
        _progressSlider.value = 0.2;
        [_progressSlider addTarget:self action:@selector(progressSliderChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressSlider;
}


- (UILabel *)thicknessLabel
{
    if (_thicknessLabel == nil)
    {
        _thicknessLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _progressLabel.frame.origin.y + _progressLabel.frame.size.height+ kPadding, 80, 20)];
        _thicknessLabel.backgroundColor = [UIColor clearColor];
        _thicknessLabel.font = [UIFont systemFontOfSize:16];
        
        _thicknessLabel.textAlignment = NSTextAlignmentLeft;
        _thicknessLabel.textColor = [UIColor blackColor];
        _thicknessLabel.text = @"Thickness";
    }
    return _thicknessLabel;
}

- (UISlider *)thicknessSlider
{
    if (_thicknessSlider == nil)
    {
        _thicknessSlider = [[UISlider alloc] initWithFrame:CGRectMake(_thicknessLabel.frame.origin.x + _thicknessLabel.frame.size.width+ 5, _thicknessLabel.frame.origin.y, kScreenWidth - (_thicknessLabel.frame.origin.x + _thicknessLabel.frame.size.width + 20), 20)];
        _thicknessSlider.backgroundColor = [UIColor clearColor];
        
        // 设置滑块颜色，iOS 7.0以后 这个没用了,默认白色的
        //        _progressSlider.thumbTintColor = [UIColor blackColor];
        
        //设置轨道颜色
        _thicknessSlider.minimumTrackTintColor = [UIColor redColor];
        _thicknessSlider.maximumTrackTintColor = [UIColor grayColor];
        
        // 设置轨道图片
        //        [_progressSlider setMinimumTrackImage:[UIImage imageNamed:@"slider_green.png"] forState:UIControlStateNormal];
        //        [_progressSlider setMaximumTrackImage:[UIImage imageNamed:@"slider_yellow.png"] forState:UIControlStateNormal];
        
        // 设置滑块图片
        //        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider_n"] forState:UIControlStateNormal];
        //        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider_h"] forState:UIControlStateHighlighted];
        
        // 设置最大值和最小值, 系统默认最大最小0~1
        //    _slider.minimumValue = 0.0;
        //    _slider.maximumValue = 200.0;
        
        //设置初始值
        _thicknessSlider.value = 0.2;
        [_thicknessSlider addTarget:self action:@selector(thicknessSliderChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _thicknessSlider;
}

- (UILabel *)textLabel
{
    if (_textLabel == nil)
    {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _thicknessLabel.frame.origin.y + _thicknessLabel.frame.size.height+ kPadding, 80, 20)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont systemFontOfSize:16];
        
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.text = @"Text";
    }
    return _textLabel;
}

- (UISwitch *)textSwitch
{
    if (_textSwitch == nil)
    {
        // 开关控件
        _textSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_textLabel.frame.origin.x + _textLabel.frame.size.width, _textLabel.frame.origin.y, 100, 30)];
        _textSwitch.backgroundColor = [UIColor clearColor];
        _textSwitch.on = YES;
        // 设置滑块颜色
        //        _mySwitch.thumbTintColor = [UIColor brownColor];
        
        // 设置开一侧颜色
        // 设置关一侧颜色
        //        _mySwitch.onTintColor = [UIColor redColor];
        //        _mySwitch.tintColor = [UIColor greenColor];
        
        // 设置开一侧 图片
        // 设置关一侧 图片
        //        _mySwitch.onImage = [UIImage imageNamed:@"3.png"];
        //        _mySwitch.offImage = [UIImage imageNamed:@"on.png"];
        [_textSwitch addTarget:self action:@selector(textSwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _textSwitch;
}



- (UILabel *)roundedLabel
{
    if (_roundedLabel == nil)
    {
        _roundedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _textLabel.frame.origin.y + _textLabel.frame.size.height+ kPadding, 80, 20)];
        _roundedLabel.backgroundColor = [UIColor clearColor];
        _roundedLabel.font = [UIFont systemFontOfSize:16];
        
        _roundedLabel.textAlignment = NSTextAlignmentLeft;
        _roundedLabel.textColor = [UIColor blackColor];
        _roundedLabel.text = @"Rounded";
    }
    return _roundedLabel;
}


- (UISwitch *)roundedSwitch
{
    if (_roundedSwitch == nil)
    {
        // 开关控件
        _roundedSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_roundedLabel.frame.origin.x + _roundedLabel.frame.size.width, _roundedLabel.frame.origin.y, 100, 30)];
        _roundedSwitch.backgroundColor = [UIColor clearColor];
        _roundedSwitch.on = YES;
        // 设置滑块颜色
        //        _mySwitch.thumbTintColor = [UIColor brownColor];
        
        // 设置开一侧颜色
        // 设置关一侧颜色
        //        _mySwitch.onTintColor = [UIColor redColor];
        //        _mySwitch.tintColor = [UIColor greenColor];
        
        // 设置开一侧 图片
        // 设置关一侧 图片
        //        _mySwitch.onImage = [UIImage imageNamed:@"3.png"];
        //        _mySwitch.offImage = [UIImage imageNamed:@"on.png"];
        [_roundedSwitch addTarget:self action:@selector(roundedSwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _roundedSwitch;
}


- (UILabel *)shadowLabel
{
    if (_shadowLabel == nil)
    {
        _shadowLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _roundedLabel.frame.origin.y + _roundedLabel.frame.size.height+ kPadding, 80, 20)];
        _shadowLabel.backgroundColor = [UIColor clearColor];
        _shadowLabel.font = [UIFont systemFontOfSize:16];
        
        _shadowLabel.textAlignment = NSTextAlignmentLeft;
        _shadowLabel.textColor = [UIColor blackColor];
        _shadowLabel.text = @"Shadow";
    }
    return _shadowLabel;
}

- (UISwitch *)shadowSwitch
{
    if (_shadowSwitch == nil)
    {
        // 开关控件
        _shadowSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_shadowLabel.frame.origin.x + _shadowLabel.frame.size.width, _shadowLabel.frame.origin.y, 100, 30)];
        _shadowSwitch.backgroundColor = [UIColor clearColor];
        _shadowSwitch.on = YES;
        // 设置滑块颜色
        //        _mySwitch.thumbTintColor = [UIColor brownColor];
        
        // 设置开一侧颜色
        // 设置关一侧颜色
        //        _mySwitch.onTintColor = [UIColor redColor];
        //        _mySwitch.tintColor = [UIColor greenColor];
        
        // 设置开一侧 图片
        // 设置关一侧 图片
        //        _mySwitch.onImage = [UIImage imageNamed:@"3.png"];
        //        _mySwitch.offImage = [UIImage imageNamed:@"on.png"];
        [_shadowSwitch addTarget:self action:@selector(shadowSwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _shadowSwitch;
}


- (UILabel *)innerColorLabel
{
    if (_innerColorLabel == nil)
    {
        _innerColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _shadowLabel.frame.origin.y + _shadowLabel.frame.size.height+ kPadding, 80, 20)];
        _innerColorLabel.backgroundColor = [UIColor clearColor];
        _innerColorLabel.font = [UIFont systemFontOfSize:16];
        
        _innerColorLabel.textAlignment = NSTextAlignmentLeft;
        _innerColorLabel.textColor = [UIColor blackColor];
        _innerColorLabel.text = @"InnerColor";
    }
    return _innerColorLabel;
}

- (UISwitch *)innerColorSwitch
{
    if (_innerColorSwitch == nil)
    {
        // 开关控件
        _innerColorSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_innerColorLabel.frame.origin.x + _innerColorLabel.frame.size.width, _innerColorLabel.frame.origin.y, 100, 30)];
        _innerColorSwitch.backgroundColor = [UIColor clearColor];
        _innerColorSwitch.on = YES;
        // 设置滑块颜色
        //        _mySwitch.thumbTintColor = [UIColor brownColor];
        
        // 设置开一侧颜色
        // 设置关一侧颜色
        //        _mySwitch.onTintColor = [UIColor redColor];
        //        _mySwitch.tintColor = [UIColor greenColor];
        
        // 设置开一侧 图片
        // 设置关一侧 图片
        //        _mySwitch.onImage = [UIImage imageNamed:@"3.png"];
        //        _mySwitch.offImage = [UIImage imageNamed:@"on.png"];
        [_innerColorSwitch addTarget:self action:@selector(innerColorSwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _innerColorSwitch;
}

- (UILabel *)outerColorLabel
{
    if (_outerColorLabel == nil)
    {
        _outerColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _innerColorLabel.frame.origin.y + _innerColorLabel.frame.size.height+ kPadding, 80, 20)];
        _outerColorLabel.backgroundColor = [UIColor clearColor];
        _outerColorLabel.font = [UIFont systemFontOfSize:16];
        
        _outerColorLabel.textAlignment = NSTextAlignmentLeft;
        _outerColorLabel.textColor = [UIColor blackColor];
        _outerColorLabel.text = @"OuterColor";
    }
    return _outerColorLabel;
}

- (UISwitch *)outerColorSwitch
{
    if (_outerColorSwitch == nil)
    {
        // 开关控件
        _outerColorSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_outerColorLabel.frame.origin.x + _outerColorLabel.frame.size.width, _outerColorLabel.frame.origin.y, 100, 30)];
        _outerColorSwitch.backgroundColor = [UIColor clearColor];
        _outerColorSwitch.on = YES;
        // 设置滑块颜色
        //        _mySwitch.thumbTintColor = [UIColor brownColor];
        
        // 设置开一侧颜色
        // 设置关一侧颜色
        //        _mySwitch.onTintColor = [UIColor redColor];
        //        _mySwitch.tintColor = [UIColor greenColor];
        
        // 设置开一侧 图片
        // 设置关一侧 图片
        //        _mySwitch.onImage = [UIImage imageNamed:@"3.png"];
        //        _mySwitch.offImage = [UIImage imageNamed:@"on.png"];
        [_outerColorSwitch addTarget:self action:@selector(outerColorSwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _outerColorSwitch;
}

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil)
    {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Flat",@"Gradient", nil]];
        _segmentedControl.frame = CGRectMake(10, _outerColorSwitch.frame.origin.y + _outerColorSwitch.frame.size.height + 10, 260, 40);
        // 设置风格, iOS 7以后不管用了
        //        _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered;
        
        //设置初始选中项
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
