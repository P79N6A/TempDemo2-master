//
//  RootViewController.m
//  MasonryLearn1
//
//  Created by xiaoyulong on 16/7/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"第1页";
//    self.navigationController.navigationBar.translucent = NO;
    
    if ([[UIDevice currentDevice].systemVersion compare:@"7.0"] == NSOrderedDescending)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    
    
    
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
//    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 添加大小约束
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
        
        /**
         // 上面这句等价于下面这两句
         make.height.mas_equalTo(100);
         make.width.mas_equalTo(150);
         
         // 也等同于这个两句
         make.height.equalTo(@100);
         make.width.equalTo(@50);
         
         */
        
        
   
        
        // 这个是居中的约束（居中方式与self相同）
        make.center.equalTo(weakSelf.view);
        // 这句等于
        //        make.center.mas_equalTo(weakSelf.view);
        
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageView];
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view).with.offset(20);
        make.left.mas_equalTo(self.view).with.offset(10);
        
//        make.height.mas_equalTo(190);
//        make.width.mas_equalTo(100);
//        make.right.mas_equalTo(self.view).with.offset(20);
//        make.bottom.mas_equalTo(self.view).with.offset(20);
        make.center.mas_equalTo(self.view);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
