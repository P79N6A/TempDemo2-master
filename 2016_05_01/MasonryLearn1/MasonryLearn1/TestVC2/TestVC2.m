//
//  TestVC2.m
//  MasonryLearn1
//
//  Created by xiaoyulong on 16/7/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"第3页";
    self.navigationController.navigationBar.translucent = NO;
    
    // 防止block中的循环引用
    __weak typeof(self) weakSelf = self;
    
    UIButton * redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:redBtn];
    
    
    [redBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        // 添加左、上边距约束
        //        make.left.and.top.mas_equalTo(100);
        
        // 添加上边距约束
        make.top.mas_equalTo(100);
        // 添加左边距约束
        make.left.mas_equalTo(20);
        // 添加右边距约束
        make.right.mas_equalTo(-20);
        
    }];
    
    
    UIButton *blueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blueBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueBtn];
    
    [blueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        // 添加右、下边距约束
        //        make.bottom.and.right.mas_equalTo(-20);
        
        // 添加下边距约束
        make.bottom.mas_equalTo(-20);
        // 添加右距约束
        make.right.mas_equalTo(-20);
        // 添加高度约束，让高度等于红色Btn
        make.height.equalTo(redBtn);
        
        // 添加上边距约束（上边距 ＝ 红色Btn下边框＋偏移量20）
        make.top.equalTo(redBtn.mas_bottom).offset(20);
        // 添加左边距（左边距＝父容器纵轴中心＋偏移量0）
        make.left.equalTo(weakSelf.view.mas_centerX).offset(0);
        
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
