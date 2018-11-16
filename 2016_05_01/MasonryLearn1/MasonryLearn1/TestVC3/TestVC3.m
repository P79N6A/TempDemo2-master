//
//  TestVC3.m
//  MasonryLearn1
//
//  Created by xiaoyulong on 16/7/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC3.h"

@interface TestVC3 ()

@end

@implementation TestVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第4页";
    
    
    //本页的效果是达到两个视图一样大
    
    // 左边的按键
    UIButton * firstBtn = [[UIButton alloc]init];
    firstBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:firstBtn];
    
    // 右边的按键
    UIButton * secondBtn = [[UIButton alloc]init];
    secondBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:secondBtn];
    
    int padding1 = 10;
    // 给左边视图添加约束
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 在主视图基础上下移100
        make.top.mas_equalTo(100);
        // 添加左边距约束（距离当前主视图左边的距离）
        make.left.equalTo(self.view.mas_left).with.offset(padding1);
        // 添加右边距约束（距离第二个按键左边的距离）
        make.right.equalTo(secondBtn.mas_left).with.offset(-padding1);
        // 添加当前按钮的高度
        make.height.mas_equalTo(40);
        // 添加宽度（宽度跟右边按键一样）
        make.width.equalTo(secondBtn);
    }];
    
    // 给右边视图添加约束
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 在主视图基础上下移100
        make.top.mas_equalTo(100);
        // 添加左边距约束（距离左边按键的距离）
        make.left.equalTo(firstBtn.mas_right).with.offset(padding1);
        // 添加右边距约束（距离当前主视图右边的距离）
        make.right.equalTo(self.view.mas_right).with.offset(-padding1);
        // 添加当前按钮的高度
        make.height.mas_equalTo(40);
        // 添加宽度（宽度跟左边按键一样）
        make.width.equalTo(firstBtn);
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
