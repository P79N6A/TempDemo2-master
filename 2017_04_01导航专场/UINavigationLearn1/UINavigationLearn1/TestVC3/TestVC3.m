//
//  TestVC3.m
//  UINavigation
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//

#import "TestVC3.h"

@interface TestVC3 ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *navLabel;
@property (nonatomic, strong) UIView *customView;

@end

@implementation TestVC3

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
    // 定制 self.navigationItem.titleView
    self.navigationItem.titleView = self.imageView;
    
    // 也可以定制成 UILabel
//    self.navigationItem.titleView = self.navLabel;
    
    
    // 透明度影响整个UI布局
    [self.view addSubview:self.customView];
    
    
}


#pragma mark - 按钮响应事件


- (void)onMyTap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.customView.frame.origin.y < 0)
        {
            tap.view.transform = CGAffineTransformMakeRotation(90 * M_PI/180);
            _customView.frame = CGRectMake(0, 0, 320, 30);
        }
        else
        {
            tap.view.transform = CGAffineTransformIdentity;
            _customView.frame = CGRectMake(0, -30, 320, 30);
        }

    } completion:^(BOOL finished) {
    }];
    
}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _imageView.image = [UIImage imageNamed:@"1"];
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMyTap:)];
        [_imageView addGestureRecognizer:myTap];
    }
    return _imageView;
}

- (UILabel *)navLabel
{
    if (_navLabel == nil)
    {
        _navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _navLabel.backgroundColor = [UIColor yellowColor];
        _navLabel.text = @"啦啦啦";
    }
    return _navLabel;
}

- (UIView *)customView
{
    if (_customView == nil)
    {
        _customView = [[UIView alloc] initWithFrame:CGRectMake(0, -30, [UIScreen mainScreen].bounds.size.width, 30)];
        _customView.layer.cornerRadius = 5.0;
        _customView.layer.borderColor = [UIColor blueColor].CGColor;
        _customView.layer.borderWidth = 3.0;
    }
    return _customView;
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
