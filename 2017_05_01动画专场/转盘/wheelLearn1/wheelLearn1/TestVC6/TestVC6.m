//
//  TestVC6.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC6.h"
#import "CircleLHQView.h"

@interface TestVC6 ()

@end

@implementation TestVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CircleLHQView *LHQView = [[CircleLHQView alloc] initWithFrame:CGRectMake(10, 100, 300, 300) andImage:nil];
    [LHQView addSubViewWithSubView:nil andTitle:@[@"第一个",@"第二个",@"第三个",@"第四个",@"第五个",@"第六个"] andSize:CGSizeMake(60, 60) andcenterImage:nil];
    [self.view addSubview:LHQView];
    
    
    LHQView.clickSomeOne=^(NSString *str){
        NSLog(@"%@被点击了",str);
    };

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
