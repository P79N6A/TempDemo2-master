//
//  TestVC18.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2018/5/23.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC18.h"
#import "AVC.h"

@interface TestVC18 ()

@property (nonatomic, strong) UIButton *btn;


@end

@implementation TestVC18

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"TestVC18";
    
    [self.view addSubview:self.btn];
    
    NSString *str1 = @"abc";
    NSLog(@"str1==%p", str1);
    //str1==0x101b68458  和下个页面的一样
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(40, 100, 240, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick:(UIButton *)sender
{
    AVC *controller = [[AVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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
