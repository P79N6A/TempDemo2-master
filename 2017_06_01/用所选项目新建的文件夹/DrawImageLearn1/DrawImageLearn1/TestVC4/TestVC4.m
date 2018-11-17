//
//  TestVC4.m
//  DrawImageLearn1
//
//  Created by xiaoyulong on 2017/6/6.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"
#import "MyView4.h"

@interface TestVC4 ()

@property (nonatomic, strong) MyView4 *drawView;

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.drawView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MyView4 *)drawView
{
    if (_drawView == nil)
    {
        _drawView = [[MyView4 alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
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
