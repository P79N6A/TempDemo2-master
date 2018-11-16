//
//  DetailVC3.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC3.h"

@interface DetailVC3 ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *btn;


@end

@implementation DetailVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    //测试自定义头部内容
    UILabel *label = [[UILabel alloc]init];
    label.text = @"ML_VC";
    [label sizeToFit];
    label.backgroundColor = [UIColor yellowColor];
    self.navigationItem.titleView = label;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 第偶数个就隐藏导航栏
    if ([self.navigationController.viewControllers indexOfObject:self] % 2 == 0)
    {
        self.navigationController.navigationBarHidden = YES;
    }
    else
    {
        self.navigationController.navigationBarHidden = NO;
    }

    
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.btn] ;
}


#pragma mark - 按钮响应事件

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)click:(UIButton *)sender
{
    DetailVC3 *detail = [[DetailVC3 alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] init];
        
        if ([self.navigationController.viewControllers indexOfObject:self]%2 == 0)
        {
            _imageView.image = [UIImage imageNamed:@"IMG_2079.jpg"];
        }
        else
        {
            _imageView.image = [UIImage imageNamed:@"IMG_2078.jpg"];
        }
        

        _imageView.contentMode = UIViewContentModeScaleToFill;
        
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(100, 100, 100, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.btn.frame = CGRectMake(0, 0, 100, 40);
    self.btn.center = self.view.center;

    self.imageView.frame = self.view.bounds;

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
