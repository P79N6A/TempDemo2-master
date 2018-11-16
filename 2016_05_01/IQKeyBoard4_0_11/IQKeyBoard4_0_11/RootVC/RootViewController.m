//
//  RootViewController.m
//  IQKeyBoard
//
//  Created by xiaoyulong on 16/3/31.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "IQKeyboardManager.h"

@interface RootViewController ()


@property (nonatomic, strong) UITextField *textField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.placeholder = @"请输入姓名";
    [self.view addSubview:_textField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    
//    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[self class]];


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
