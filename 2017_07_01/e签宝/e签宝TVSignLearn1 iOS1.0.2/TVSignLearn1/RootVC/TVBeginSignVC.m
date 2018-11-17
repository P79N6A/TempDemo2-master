//
//  TVBeginSignVC.m
//  TVSignFrameworkDemo
//
//  Created by wz on 16/5/11.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#import "TVBeginSignVC.h"
#import <TVSignFramework/TVSignFramework.h>
#import "CommonUtil.h"

@interface TVBeginSignVC () <TVSignProtocol>

@property (nonatomic, strong) UIButton *btn;
@property (strong, nonatomic) UIImageView *sealImageView;
@property (strong, nonatomic) UISwitch *needPortrait;


@end

@implementation TVBeginSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.sealImageView];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.needPortrait];
}


#pragma mark - 按钮响应事件

#pragma mark - 点击开始签署
- (void)beginSign:(id)sender {
    
    self.accountUid = @"xxxxx";
    if(_needPortrait.isOn)
    {
        // 竖屏
        [TVSignFramework tvSignCtrlWithType:TVSignCtrlTypePortraitFirst ctrl:self accountUid:self.accountUid signProtocol:self];
    }
    else
    {
        [TVSignFramework tvSignCtrlWithType:TVSignCtrlTypeDefault ctrl:self accountUid:self.accountUid signProtocol:self];
    }
}

#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - TVSignProtocol
- (void)didSignCancel:(NSString*)_accountUid {
    NSLog(@"cancel sign");
}

- (void)didSignBackImage:(NSString*)_accountUid sealImage:(UIImage*)_sealImage
{
    self.sealImageView.image = _sealImage;
    NSLog(@"back images==%@, (%f, %f)", _sealImage, _sealImage.size.width, _sealImage.size.height);
 
    UIImage *finallyImage = [CommonUtil scaleImage:_sealImage toMinSize:960.0];

    
    NSString *imageName = [CommonUtil getRandomFileName];
    NSString *imageChangePath = [CommonUtil cachesFolderPathWithName:[NSString stringWithFormat:@"%@.jpg", imageName]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", imageName];
    [CommonUtil saveImage:finallyImage WithPath:imageChangePath];
    NSLog(@"fileName==%@", fileName);
    NSLog(@"imageChangePath==%@", imageChangePath);

    
}

#pragma mark - setter, getter

- (UIImageView *)sealImageView
{
    if (_sealImageView == nil)
    {
        _sealImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 70, [UIScreen mainScreen].bounds.size.width - 60, 200)];
        _sealImageView.backgroundColor = [UIColor redColor];
    }
    return _sealImageView;
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(40, _sealImageView.frame.origin.y + _sealImageView.frame.size.height + 30, 240, 40);
        [_btn setTitle:@"开始签署" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(beginSign:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UISwitch *)needPortrait
{
    if (_needPortrait == nil)
    {
        // 开关控件
        _needPortrait = [[UISwitch alloc] initWithFrame:CGRectMake(100, _btn.frame.origin.y + _btn.frame.size.height + 30, 100, 30)];
        _needPortrait.backgroundColor = [UIColor yellowColor];
        _needPortrait.on = YES;
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
//        [_needPortrait addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    }
    return _needPortrait;
}





@end
