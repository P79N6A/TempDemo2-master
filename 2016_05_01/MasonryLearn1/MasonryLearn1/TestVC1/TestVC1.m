//
//  TestVC1.m
//  MasonryLearn1
//
//  Created by xiaoyulong on 16/7/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"第2页";
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blackBtn.backgroundColor = [UIColor blackColor];
    // 给btn添加一个点击事件 跳转到第三个页面看效果
//    [blackBtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:blackBtn];
    
    [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 添加大小约束
        //        make.size.mas_equalTo(CGSizeMake(100, 100));
        
        // 添加左边、上边距约束 (左、上约束都是20)
        //        make.left.and.top.mas_equalTo(100);
        
        // 上面这个也可以分开写 和下面价值是一样的
        
        //        // 在主视图基础上 下移100
        make.top.equalTo(@100);
        // 在主视图的基础上左移 50
        make.left.equalTo(@50);
        
        // 当前视图的高度
        make.height.equalTo(@100);
        // 当前视图的宽度
        make.width.equalTo(@100);
        
    }];
    
    
    // 初始化红色按钮
    UIButton * redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redBtn.backgroundColor = [UIColor redColor];
//    [redBtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redBtn];
    
    [redBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.and.top.equalTo(blackBtn);
        
        make.right.mas_equalTo(-50);
        make.rightMargin.mas_equalTo(-50);
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
