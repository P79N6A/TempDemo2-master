//
//  TestVC12.m
//  UINavigationLearn1
//
//  Created by xiaoyulong on 2017/6/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC12.h"

@interface TestVC12 () <UIActionSheetDelegate>

@end

@implementation TestVC12

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255 alpha:1.0];

    //第一层不需要 leftBarButtonItem, 大于或等于2的时候才有
    if (self.navigationController.viewControllers.count >= 2)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一层" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];


    self.navigationItem.title = [NSString stringWithFormat:@"第%@层",@(self.navigationController.viewControllers.count)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClick
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"快捷方式:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"回到上一层" otherButtonTitles:@"回到顶层",@"回到第三层",@"进入第三层", @"回到第五层", @"进入第五层", nil];
    [actionSheet showInView:self.view];
}

- (void)rightClick
{
    TestVC12 *root = [[TestVC12 alloc] init];
    [self.navigationController pushViewController:root animated:YES];
}

#pragma mark - 创建UI

- (void)createUI
{
    
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%@", actionSheet.subviews);
    NSLog(@"buttonIndex==%@", @(buttonIndex));

    NSString *buttonTitleStr = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"buttonTitleStr==%@", buttonTitleStr);
    
    
    /*
     
     cancelButtonTitle:@"取消" destructiveButtonTitle:@"回到上一层" otherButtonTitles:@"回到顶层",@"回到第三层",@"进入第三层", @"回到第五层", @"进入第五层", nil];
     
     @"取消"  buttonIndex 6
     
     @"回到上一层" buttonIndex 0
     
     @"回到顶层", buttonIndex 1
     
     @"回到第三层", buttonIndex 2
     
     @"进入第三层",  buttonIndex 3
     
     @"回到第五层", buttonIndex 4
     
     @"进入第五层", buttonIndex 5
     
     ((UIAlertView 与 UIActionSheet 不一样的地方))
     
     */
    
    
    switch (buttonIndex)
    {
        case 0:
        {
            //回到上一层
            [self.navigationController popViewControllerAnimated:YES];
            
        }
            break;
        case 1:
        {
            //回到顶层
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
            break;
        case 2:
        {
            //回到第三层
            if (self.navigationController.viewControllers.count >= 4)
            {
                [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
            }
            else
            {
                return;
            }
        }
            break;
            
            
        case 3:
        {
            //进入第三层
            if (self.navigationController.viewControllers.count <= 2)
            {
                NSArray *arr = self.navigationController.viewControllers;
                NSMutableArray *ctlArr = [NSMutableArray arrayWithArray:arr];
                NSInteger num = 3 - arr.count;
                for (NSInteger i = 0; i < num; i++)
                {
                    TestVC12 *root = [[TestVC12 alloc] init];
                    [ctlArr addObject:root];
                }
                
                [self.navigationController setViewControllers:ctlArr animated:YES];
            }
            else
            {
                return;
            }
        }
            break;
            
        case 4:
        {
            //回到第五层
            if (self.navigationController.viewControllers.count >= 6)
            {
                [self.navigationController popToViewController:self.navigationController.viewControllers[4] animated:YES];
            }
            else
            {
                return;
            }
        }
            break;
            
        case 5:
        {
            //进入第五层
            if (self.navigationController.viewControllers.count <= 4)
            {
                NSArray *arr = self.navigationController.viewControllers;
                NSMutableArray *ctlArr = [NSMutableArray arrayWithArray:arr];
                NSInteger num = 5 - arr.count;
                for (NSInteger i = 0; i < num; i++)
                {
                    TestVC12 *root = [[TestVC12 alloc] init];
                    [ctlArr addObject:root];
                }
                [self.navigationController setViewControllers:ctlArr animated:YES];
            }
            else
            {
                return;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - setter, getter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
