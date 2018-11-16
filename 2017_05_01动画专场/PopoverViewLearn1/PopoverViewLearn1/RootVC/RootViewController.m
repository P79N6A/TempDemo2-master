//
//  RootViewController.m
//  PopoverViewLearn1
//
//  Created by xiaoyulong on 2017/6/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "QLPopView.h"

@interface RootViewController ()

/// 导航栏上更多按钮 弹出pop
@property (nonatomic, strong) QLPopView *popView;

/// 首页按钮
@property (nonatomic, strong) UIButton *moreBtn;

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
//    if (ISIOS7)
//    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.automaticallyAdjustsScrollViewInsets = NO;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//    }
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"da" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
    
}


#pragma mark - 按钮响应事件

- (void)moreBtnCLick:(UIButton *)sender
{
    if (_popView)
    {
        [_popView makePopViewDisappear];
    }
    else
    {
        [GetAPPDelegate.window addSubview:self.popView];
        self.popView.alpha = 1.0;
    }
}

- (void)handleSelectPopItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            //            [GetAPPDelegate.tabBarController setSelectedIndex:0];
        }
            break;
        case 1:
        {
            //            QLSearchViewController * searchVC=[[QLSearchViewController alloc]init];
            //            searchVC.hidesBottomBarWhenPushed=YES;
            //            [self.navigationController pushViewController:searchVC animated:YES];
            
        }
            break;
        case 2:
        {
            // 我关注的产品
            //            QLBrowseRecordVC *controller = [[QLBrowseRecordVC alloc] init];
            //            controller.hidesBottomBarWhenPushed = YES;
            //            controller.productListType = productListBrowseRecord;
            //            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (QLPopView *)popView
{
    if (_popView == nil)
    {
        _popView = [[QLPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAllHeight) andPopViewFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-119.0, kStatusBarHeight + kNavigationHeight, 112.0, QLPopCellHeight*3)];
        _popView.backgroundColor = [UIColor clearColor];
        
        kSelfWeak;
        _popView.popViewDisappearBlock = ^(){
            weakSelf.popView = nil;
        };
        _popView.selectPopItemAtIndexBlock = ^(NSInteger Index){
            kSelfStrong;
            [strongSelf handleSelectPopItemAtIndex:Index];
        };
        
    }
    return _popView;
}

- (UIButton *)moreBtn
{
    if (_moreBtn == nil)
    {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.backgroundColor = [UIColor clearColor];
        _moreBtn.frame = CGRectMake(0, 0, 30, kNavigationHeight);
        [_moreBtn setImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

@end
