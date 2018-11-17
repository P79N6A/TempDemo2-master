//
//  TestVC2.m
//  DrawImageLearn1
//
//  Created by xiaoyulong on 2017/6/6.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"
#import "DrawView.h"

@interface TestVC2 ()

@property (nonatomic, strong) DrawView *drawView;

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DrawView *)drawView
{
    if (_drawView == nil)
    {
        _drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
        _drawView.backgroundColor = [UIColor yellowColor];

    }
    return _drawView;
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
