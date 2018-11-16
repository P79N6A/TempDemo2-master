//
//  TestVC6.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC6.h"

@interface TestVC6 ()

@end

@implementation TestVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBarButtonItemClick)];

    self.navigationItem.title = [NSString stringWithFormat:@"第%@层", @(self.navigationController.viewControllers.count)];
    
    NSLog(@"self.navigationController.viewControllers.count==%@", @(self.navigationController.viewControllers.count));
    
    NSLog(@"self.navigationController.childViewControllers.count==%@", @(self.navigationController.childViewControllers.count));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onRightBarButtonItemClick
{
    TestVC6 *root = [[TestVC6 alloc] init];
    root.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    [self.navigationController pushViewController:root animated:YES];
    
    /*
     总是显示第0层
     
     root.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
     这个东西放在上面  与 放在这里截然不同，
     放在上面导致 总是显示第0层   因为还没有push  XYLRootViewController就被改变，
     被动用。
     
     如果放在下面，则不会出现这样的问题。
     */
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
