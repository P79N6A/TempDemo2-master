//
//  TestVC4.m
//  zhifubaoLearn1
//
//  Created by xiaoyulong on 2017/6/2.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"
#import "RadarAnimationView.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    RadarAnimationView *rader = [[RadarAnimationView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    
    rader.center = self.view.center;
    
    rader.backgroundColor = [UIColor lightGrayColor];
    rader.image = [UIImage imageNamed:@"IMG_1314.JPG"];
    
    rader.block = ^{
        
        NSLog(@"1");
    };
    
    rader.selectBlock = ^{
        
        NSLog(@"2");
    };
    
    [self.view addSubview:rader];
    
    
    
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
