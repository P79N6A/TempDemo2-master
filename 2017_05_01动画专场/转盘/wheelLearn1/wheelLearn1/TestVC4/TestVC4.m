//
//  TestVC4.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/5.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"
#import "DemoVC4.h"
#import "DetailVC4.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 50)];
    [button1 setTitle:@"一键点击转盘" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor cyanColor];
    [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 120, 50)];
    [button2 setTitle:@"手动转动转盘" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor magentaColor];
    [button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button1Click
{
    DetailVC4 * vc = [[DetailVC4 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)button2Click
{
    DemoVC4 * vc = [[DemoVC4 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
