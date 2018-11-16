//
//  TestVC1.m
//  PICircularProgressView
//
//  Created by xiaoyulong on 2017/8/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

#import "QLCirclePercentView.h"


@interface TestVC1 ()

@property (nonatomic, strong) QLCirclePercentView *circlePercentView;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = UIColorRGB(61, 157, 234);
    
    [self.view addSubview:self.circlePercentView];
    self.circlePercentView.percent = 0.46;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (QLCirclePercentView *)circlePercentView
{
    if (_circlePercentView == nil)
    {
        _circlePercentView = [[QLCirclePercentView alloc] initWithFrame:CGRectMake(5, 100, QLCirclePercentViewHeight, QLCirclePercentViewHeight)];
        _circlePercentView.backgroundColor = [UIColor clearColor];
    }
    return _circlePercentView;
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
