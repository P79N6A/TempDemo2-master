//
//  TestVC1.m
//  PopoverViewLearn1
//
//  Created by xiaoyulong on 2017/6/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "PopoverView.h"

@interface TestVC1 ()

@property (nonatomic, strong) UILabel *noticeLabel;

@property (nonatomic, strong) UIButton *leftBtn;;

@property (nonatomic, strong) UIButton *rightBtn;;


@property (nonatomic, strong) UIButton *showBtn1;
@property (nonatomic, strong) UIButton *showBtn2;
@property (nonatomic, strong) UIButton *showBtn3;
@property (nonatomic, strong) UIButton *showBtn4;

@end

@implementation TestVC1

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
    [self.view addSubview:self.noticeLabel];
    

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:26 / 255.0 green:185 / 255.0 blue:244 / 255.0 alpha:1];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    [self.view addSubview:self.showBtn1];
 
    [self.view addSubview:self.showBtn2];
    
    [self.view addSubview:self.showBtn3];
    
    [self.view addSubview:self.showBtn4];
}


#pragma mark - 按钮响应事件

- (void)leftBtnClick:(UIButton *)sender
{
    PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_newmessage"] title:@"发起群聊" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_friend"] title:@"添加朋友" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_scan"] title:@"扫一扫" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_money"] title:@"收付款" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    // 在没有系统控件的情况下调用可以使用显示在指定的点坐标的方法弹出菜单控件.
    [popoverView showToPoint:CGPointMake(20, 64) withActions:@[action1, action2, action3, action4]];
}

- (void)rightBtnClick:(UIButton *)sender
{
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    [popoverView showToView:sender withActions:[self QQActions]];
}

- (void)showBtn1Click:(UIButton *)sender
{
    PopoverView *popoverView = [PopoverView popoverView];
    [popoverView showToView:sender withActions:[self QQActions]];
}


- (void)showBtn3Click:(UIButton *)sender
{
    
    // 不带图片
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"加好友" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"扫一扫" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"发起聊天" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"发起群聊" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action5 = [PopoverAction actionWithTitle:@"查找群聊" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    PopoverAction *action6 = [PopoverAction actionWithTitle:@"我的群聊" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:@[action1, action2, action3, action4, action5, action6]];
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UILabel *)noticeLabel
{
    if (_noticeLabel == nil)
    {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2, 30, 100, 20)];
        _noticeLabel.backgroundColor = [UIColor redColor];
        _noticeLabel.font = [UIFont systemFontOfSize:14];
        
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
        _noticeLabel.textColor = [UIColor blackColor];
//        _noticeLabel.text = @"<##>";
    }
    return _noticeLabel;
}

- (NSArray <PopoverAction *> *)QQActions {
    // 发起多人聊天 action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        _noticeLabel.text = action.title;
    }];
    // 加好友 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    // 面对面快传 action
    PopoverAction *facetofaceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"面对面快传" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    // 付款 action
    PopoverAction *payMoneyAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" handler:^(PopoverAction *action) {
        _noticeLabel.text = action.title;
    }];
    
    return @[multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction];
}


- (UIButton *)leftBtn
{
    if (_leftBtn == nil)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor clearColor];
        _leftBtn.frame = CGRectMake(0, 0, 40, 40);

        [_leftBtn setImage:[UIImage imageNamed:@"navigationItem_menu"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (_rightBtn == nil)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.frame = CGRectMake(0, 0, 40, 40);
        
        [_rightBtn setImage:[UIImage imageNamed:@"navigationItem_menu"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}


- (UIButton *)showBtn1
{
    if (_showBtn1 == nil)
    {
        _showBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn1.backgroundColor = [UIColor blueColor];
        _showBtn1.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 80) / 2, 80, 80, 40);
        [_showBtn1 setTitle:@"showPopover" forState:UIControlStateNormal];
        _showBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
        [_showBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn1 addTarget:self action:@selector(showBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn1;
}

- (UIButton *)showBtn2
{
    if (_showBtn2 == nil)
    {
        _showBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn2.backgroundColor = [UIColor brownColor];
        _showBtn2.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 140, 80, 40);
        [_showBtn2 setTitle:@"showPopover" forState:UIControlStateNormal];
        _showBtn2.titleLabel.font = [UIFont systemFontOfSize:12];
        [_showBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn2 addTarget:self action:@selector(showBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn2;
}


- (UIButton *)showBtn3
{
    if (_showBtn3 == nil)
    {
        _showBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn3.backgroundColor = [UIColor purpleColor];
        _showBtn3.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 80) / 2, [UIScreen mainScreen].bounds.size.height - 140, 80, 40);
        [_showBtn3 setTitle:@"showPopover" forState:UIControlStateNormal];
        _showBtn3.titleLabel.font = [UIFont systemFontOfSize:12];
        [_showBtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn3 addTarget:self action:@selector(showBtn3Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn3;
}

- (UIButton *)showBtn4
{
    if (_showBtn4 == nil)
    {
        _showBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn4.backgroundColor = [UIColor brownColor];
        _showBtn4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80 - 20, [UIScreen mainScreen].bounds.size.height - 140, 80, 40);
        _showBtn4.titleLabel.font = [UIFont systemFontOfSize:12];
        [_showBtn4 setTitle:@"showPopover" forState:UIControlStateNormal];
        [_showBtn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn4 addTarget:self action:@selector(showBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn4;
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
