//
//  RootViewController.m
//  SSKeychainLearn1
//
//  Created by xiaoyulong on 16/9/9.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "DataHelper.h"
#import "IPhoneInfoHelper.h"

#import "SSKeychain.h"

@interface RootViewController ()

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UIButton *saveMoreBtn;

@property (nonatomic, strong) UIButton *queryBtn;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *str = [DataHelper getBundleIdentifier];
    DLog(@"app包名str==%@", str);

    // 通过 SSKeyChain 的方式获取到唯一标识符
    DLog(@"uuid==%@", [DataHelper getDeviceID]);
    /**
     4B1DD0BF-CF91-4699-9883-DE94AB0DD28E
     */
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 那么service保存的信息分别标识不同的论坛。
 由于包名通常具有一定的唯一性，通常在程序中可以用包的名称来作为service的标识
 
 根据需求，可以用在同一个service中保存多个用户名和密码，
 在需要提取的时候提取最后一个，或者根据用户名来提取特定密码。
 也可以在同一个service中只保存一个用户名和密码，在需要保存新的用户名和密码的时候将原来保存的密码删除
 */

- (void)click2
{
    /**
     因为ios应用可以写入一块内存 keychains，这块内存数据是不会因为app的删除而消失的。
     大部分应用不用你注册就可以使用，等你删除应用重新下载之后，他还是会记录你的账号密码。
     
     keychain保存更为安全，而且keychain里保存的信息不会因App被删除而丢失，所以在重装App后，keychain里的数据还能使用
     */
    
    
    
    
    //    NSError *error = nil;
    //    [SSKeychain deletePasswordForService:@"xiao" account:@"yuy" error:&error];
    //    NSString *str2 = [SSKeychain passwordForService:@"xiao" account:@"yuy"];
    //    NSLog(@"str2 is %@", str2);
    
    NSLog(@"NSHomeDirectory()==%@", NSHomeDirectory());
    
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.saveMoreBtn];
    [self.view addSubview:self.queryBtn];
    
}

#pragma mark - 按钮响应事件

- (void)saveBtnClick:(UIButton *)sender
{
    NSError *error = nil;
    BOOL success = [SSKeychain setPassword:@"a12345678" forService:[DataHelper getBundleIdentifier] account:@"18026915415" error:&error];
    
    if (success)
    {
        DLog(@"存储数据成功");
    }
    else
    {
        DLog(@"error==%@", error);
    }
}

- (void)saveMoreBtnClick:(UIButton *)sender
{
    NSError *error = nil;
    BOOL success = [SSKeychain setPassword:@"a12345679" forService:[DataHelper getBundleIdentifier] account:@"18026915414" error:&error];
    
    if (success)
    {
        DLog(@"存储数据成功");
    }
    else
    {
        DLog(@"error==%@", error);
    }
    
}

- (void)queryBtnClick:(UIButton *)sender
{
    // 存储了数据，从手机中删掉App，数据还在的啦
    
    NSError *error = nil;
    NSString *password = [SSKeychain passwordForService:[DataHelper getBundleIdentifier] account:@"18026915415" error:&error];
    
    if (error)
    {
        DLog(@"error==%@", error);
    }
    
    
    NSString *password2 = [SSKeychain passwordForService:[DataHelper getBundleIdentifier] account:@"18026915415" error:&error];
    DLog(@"password==%@", password);
    DLog(@"password2==%@", password2);
    
    
    if (error)
    {
        DLog(@"error==%@", error);
    }
    
    

}

#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIButton *)saveBtn
{
    if (_saveBtn == nil)
    {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = [UIColor yellowColor];
        _saveBtn.frame = CGRectMake(100, 70, 150, 40);
        [_saveBtn setTitle:@"存储一条数据" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}


- (UIButton *)saveMoreBtn
{
    if (_saveMoreBtn == nil)
    {
        _saveMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveMoreBtn.backgroundColor = [UIColor yellowColor];
        _saveMoreBtn.frame = CGRectMake(100, 130, 150, 40);
        [_saveMoreBtn setTitle:@"存储多条数据" forState:UIControlStateNormal];
        [_saveMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveMoreBtn addTarget:self action:@selector(saveMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveMoreBtn;
}


- (UIButton *)queryBtn
{
    if (_queryBtn == nil)
    {
        _queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _queryBtn.backgroundColor = [UIColor yellowColor];
        _queryBtn.frame = CGRectMake(100, 180, 150, 40);
        [_queryBtn setTitle:@"查询数据" forState:UIControlStateNormal];
        [_queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_queryBtn addTarget:self action:@selector(queryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queryBtn;
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
