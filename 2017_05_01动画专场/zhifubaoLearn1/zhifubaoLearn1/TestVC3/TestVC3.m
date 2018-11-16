//
//  TestVC3.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/4/21.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC3.h"
#import "ZLDashboardView.h"
#import "UIViewExt.h"

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define MinNumber (350)
#define MaxNumber (950)



@interface TestVC3 ()

@property (nonatomic, strong) ZLDashboardView *dashboardView;

//@property (nonatomic, strong) ZLGradientView * gradientView;

@property (nonatomic, strong) UIButton * clickBtn;

@property (nonatomic, strong) UISlider * slider;
@end

@implementation TestVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    //创建背景色
//    [self setupGradientView];
    
    //创建仪表盘
    [self setupCircleView];
    
    //添加触发动画的点击button
    [self addActionButton];
    
    //改变value
    [self addSlideChnageValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addActionButton {
    UIButton *stareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stareButton.frame = CGRectMake(10.f, self.dashboardView.bottom + 50.f, SCREEN_WIDTH - 20.f, 38.f);
    [stareButton addTarget:self action:@selector(onStareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [stareButton setTitle:@"Start Animation" forState:UIControlStateNormal];
    [stareButton setBackgroundColor:[UIColor lightGrayColor]];
    stareButton.layer.masksToBounds = YES;
    stareButton.layer.cornerRadius = 4.f;
    [self.view addSubview:stareButton];
    
    _clickBtn = stareButton;
}

- (void)addSlideChnageValue {
    
    CGFloat width = 280;
    CGFloat height = 40;
    CGFloat xPixel = (SCREEN_WIDTH - width) * 0.5;
    CGFloat yPixel = CGRectGetMaxY(_clickBtn.frame) + 20;
    CGRect slideFrame = CGRectMake(xPixel, yPixel, width, height);
    
    UISlider *slider = [[UISlider alloc] initWithFrame:slideFrame];
    
    slider.minimumValue = MinNumber;
    slider.maximumValue = MaxNumber;
    
    slider.minimumTrackTintColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.502 alpha:1.000];
    slider.maximumTrackTintColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    /**
     *  注意这个属性：如果你没有设置滑块的图片，那个这个属性将只会改变已划过一段线条的颜色，不会改变滑块的颜色，如果你设置了滑块的图片，又设置了这个属性，那么滑块的图片将不显示，滑块的颜色会改变（IOS7）
     */
    [slider setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    slider.thumbTintColor = [UIColor cyanColor];
    
    
    [slider setValue:0.5 animated:YES];
    
    [slider addTarget:self action:@selector(slideTap:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
    
    _slider = slider;
}

- (void)slideTap:(UISlider *)sender {
    CGFloat value = sender.value;
    NSLog(@"%.f",value);
}

//- (void)setupGradientView {
//    self.gradientView = [[ZLGradientView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:self.gradientView];
//}

- (void)setupCircleView {
    self.dashboardView = [[ZLDashboardView alloc] initWithFrame:CGRectMake(40.f, 70.f, SCREEN_WIDTH - 80.f, SCREEN_WIDTH - 80.f)];
    self.dashboardView.bgImage = [UIImage imageNamed:@"backgroundImage"];
    [self.view addSubview:self.dashboardView];
}

- (void)onStareButtonClick:(UIButton *)sender {
    
    if (sender.selected) {
        
//        [self.gradientView removeFromSuperview];
//        self.gradientView = nil;
        
        [self.dashboardView removeFromSuperview];
        self.dashboardView = nil;
        
//        [self setupGradientView];
        
        [self setupCircleView];
        
        [self.view bringSubviewToFront:self.clickBtn];
        [self.view bringSubviewToFront:_slider];
    }
    sender.selected = YES;
    
    CGFloat value = _slider.value;
    
    NSString *startNO = [NSString stringWithFormat:@"%d", MinNumber];
    NSString *toNO = [NSString stringWithFormat:@"%.f",value];//@"693"; 950
    NSLog(@"endNO:%@",toNO);
    [self.dashboardView refreshJumpNOFromNO:startNO toNO:toNO];
    
    __block typeof(self)blockSelf = self;
    self.dashboardView.TimerBlock = ^(NSInteger index) {
//        [blockSelf.gradientView setUpBackGroundColorWithColorArrayIndex:index];
    };
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
