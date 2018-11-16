//
//  RootViewController.m
//  transform3DRotate
//
//  Created by xiaoyulong on 16/6/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "QLProductAdView.h"

#define ADImageViewHeight 200

#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width
#define kScreenHeight       [UIScreen mainScreen].applicationFrame.size.height
#define kAllHeight          ([UIScreen mainScreen].applicationFrame.size.height + 20.0)
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)
#define kTabbarHeight       49
#define kSearchBarHeight    45
#define kStatusBarHeight    20
#define kNavigationHeight   44
#define ScreenMutiple (iPhone6?1.171875:(iPhone6plus?1.29375:1))


@interface RootViewController ()

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) QLProductAdView *productAdView;
@property (nonatomic, strong) UILabel *pageLabel;


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
    [self.view addSubview:self.productAdView];
    
    NSMutableArray *adImageArray = [[NSMutableArray alloc] init];
    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160520103910429_32.jpg"];
    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160518155732370_85.jpg"];
    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160518160008092_31.jpg"];
    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160518160008092_31.jpg"];

    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160518160008092_31.jpg"];
    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160518160008092_31.jpg"];

    [adImageArray addObject:@"http://wapic1.qulv.com/bigpic/2016-05/20160518160008092_31.jpg"];

    [self.productAdView refreshQLProductAdViewWithImageUrlArr:adImageArray];
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.pageLabel];
}

#pragma mark - 按钮响应事件

- (void)click:(UIButton *)sender
{
    CATransform3D transform3D = self.pageLabel.layer.transform;
//    CATransform3DIdentity;
    
    
    
    self.pageLabel.layer.transform = CATransform3DRotate(transform3D, M_PI/2, 0, 1, 0);

}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(100, 400, 100, 40);
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (QLProductAdView *)productAdView
{
    if (_productAdView == nil)
    {
        _productAdView = [[QLProductAdView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ADImageViewHeight)];
        _productAdView.backgroundColor = [UIColor yellowColor];
    }
    return _productAdView;
}

- (UILabel *)pageLabel
{
    if (_pageLabel == nil)
    {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, _productAdView.frame.origin.y + _productAdView.frame.size.height + 20, 30, 30)];
//        _pageLabel.backgroundColor = [UIColor clearColor];
        
        _pageLabel.layer.borderColor = [UIColor clearColor].CGColor;
        _pageLabel.layer.borderWidth = 1.0;
        _pageLabel.layer.cornerRadius = _pageLabel.bounds.size.height / 2;
        _pageLabel.layer.masksToBounds = YES;
        
        _pageLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _pageLabel.text = @"1/5";
        _pageLabel.font = [UIFont systemFontOfSize:14];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pageLabel;
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
