//
//  TestVC4.m
//  MasonryLearn1
//
//  Created by xiaoyulong on 16/7/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()

@property (nonatomic, strong)UITextField * textField;

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第5页";
    
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
    
    
    _textField = [UITextField new];
    _textField.layer.cornerRadius = 4;
    _textField.layer.masksToBounds = YES;
    _textField.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    _textField.layer.borderWidth = 1;
    [self.view addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.centerX.equalTo(weakSelf.view);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [super dealloc];
}

// 点击页面空白出 收取键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notefication
{
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [notefication userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-keyboardHeight);
        
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        //
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    // 获得键盘动画时长
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    //
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
