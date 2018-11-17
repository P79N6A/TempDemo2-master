//
//  TestVC1.m
//  DrawingBoard
//
//  Created by xiaoyulong on 17/3/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "SmoothLineView.h"

@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SmoothLineView *smoothLineView = [[SmoothLineView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:smoothLineView];

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
