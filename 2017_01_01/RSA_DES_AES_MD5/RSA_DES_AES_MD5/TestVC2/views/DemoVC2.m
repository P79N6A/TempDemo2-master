//
//  DemoVC2.m
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DemoVC2.h"
#import "AES.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface DemoVC2 ()

@property (nonatomic, strong) UILabel     *originLabel;//原始数据标题
@property (nonatomic, strong) UITextField *originTexfield;//原始数据
@property (nonatomic, strong) UILabel     *encryLabelTitle;//加密标题
@property (nonatomic, strong) UILabel     *dencryLabelTitle;//解密标题
@property (nonatomic, strong) UITextView  *encryWithPublicKeyTextview;//加密后密文
@property (nonatomic, strong) UITextView  *dencryWithPriviteKeyTextview;//解密后密文
@property (nonatomic, strong) UIButton    *encryWithPublicKeyBtn;//加密按钮
@property (nonatomic, strong) UIButton    *dencryWithPriviteKeyBtn;//解密按钮
@property (nonatomic, strong) UILabel     *randomLabel;//随机l字符串

@end

@implementation DemoVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"AES加密";
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    //创建输入源
    [self.view addSubview:self.originLabel];
    
    [self.view addSubview:self.originTexfield];
    
    
    //创建title
    [self.view addSubview:self.dencryLabelTitle];
    [self.view addSubview:self.encryLabelTitle];

    
    [self.view addSubview:self.encryWithPublicKeyTextview];

    [self.view addSubview:self.dencryWithPriviteKeyTextview];

    //创建button
    [self.view addSubview:self.encryWithPublicKeyBtn];
    [self.view addSubview:self.dencryWithPriviteKeyBtn];

    
    //随机字符串label
    [self.view addSubview:self.randomLabel];

}


#pragma mark - 按钮响应事件

//生成八位随机字符串
- (NSString *)shuffledAlphabet {
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:8];
    free(characters);
    return result;
}

//公钥加密数据
- (void)encryWithPublicKeyBtnClick:(UIButton *)sender
{
    //生成一个随机的8位字符串，作为des加密数据的key,对数据进行des加密，对加密后的数据用公钥再进行一次rsa加密
    _randomLabel.text = [self shuffledAlphabet];
    _encryWithPublicKeyTextview.text = [AES encrypt:_originTexfield.text password:_randomLabel.text];
}


//私钥解密数据
- (void)dencryWithPriviteKeyBtnClick:(UIButton *)sender
{
    _dencryWithPriviteKeyTextview.text = [AES decrypt:_encryWithPublicKeyTextview.text password:_randomLabel.text];
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

//原始数据懒加载
- (UILabel *)originLabel
{
    if (!_originLabel)
    {
        _originLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 100, 30)];
        _originLabel.font = [UIFont systemFontOfSize:13];
        _originLabel.text = @"原始数据:";
    }
    return _originLabel;
}

//初始数据UITextField输入
- (UITextField *)originTexfield
{
    if (!_originTexfield)
    {
        _originTexfield = [[UITextField alloc]initWithFrame:CGRectMake(120, 80, 200, 30)];
        _originTexfield.font = [UIFont systemFontOfSize:13];
        _originTexfield.borderStyle = UITextBorderStyleRoundedRect;
        _originTexfield.placeholder = @"请输入原始数据";
    }
    return _originTexfield ;
}

//加密标题
- (UILabel *)encryLabelTitle
{
    if (!_encryLabelTitle)
    {
        _encryLabelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 100, 30)];
        _encryLabelTitle.font = [UIFont systemFontOfSize:13];
        _encryLabelTitle.text = @"加密数据";
    }
    return  _encryLabelTitle;
}

//解密标题
- (UILabel *)dencryLabelTitle
{
    if (!_dencryLabelTitle)
    {
        _dencryLabelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 320, 100, 30)];
        _dencryLabelTitle.font = [UIFont systemFontOfSize:13];
        _dencryLabelTitle.text = @"解密数据:";
    }
    return _dencryLabelTitle;
}


//加密密文显示UITextView
- (UITextView *)encryWithPublicKeyTextview
{
    if (!_encryWithPublicKeyTextview)
    {
        _encryWithPublicKeyTextview= [[UITextView alloc]initWithFrame:CGRectMake(10, 160, kScreenWidth-20, 150)];
        _encryWithPublicKeyTextview.font = [UIFont systemFontOfSize:13];
        _encryWithPublicKeyTextview.backgroundColor = [UIColor cyanColor];
        _encryWithPublicKeyTextview.text = @"用随机生成8位key ，加密数据";
    }
    return _encryWithPublicKeyTextview;
}


//加密密文显示UITextView
- (UITextView *)dencryWithPriviteKeyTextview
{
    if (!_dencryWithPriviteKeyTextview)
    {
        _dencryWithPriviteKeyTextview = [[UITextView alloc]initWithFrame:CGRectMake(10, 350, kScreenWidth-20, 150)];
        _dencryWithPriviteKeyTextview.font = [UIFont systemFontOfSize:13];
        _dencryWithPriviteKeyTextview.backgroundColor = [UIColor cyanColor];
        _dencryWithPriviteKeyTextview.text = @"点击生成随机8位key btn后，生成密文，点击解密数据btn解密:";
    }
    return _dencryWithPriviteKeyTextview;
}

//加密数据btn
- (UIButton *)encryWithPublicKeyBtn
{
    if (!_encryWithPublicKeyBtn)
    {
        _encryWithPublicKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _encryWithPublicKeyBtn.frame = CGRectMake((kScreenWidth-100)/2-150, kScreenHeight-150, 150, 30);
        _encryWithPublicKeyBtn.backgroundColor = [UIColor redColor];
        [_encryWithPublicKeyBtn setTitle:@"生成密文" forState:UIControlStateNormal];
        [_encryWithPublicKeyBtn addTarget:self action:@selector(encryWithPublicKeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _encryWithPublicKeyBtn;
}

//解密数据btn
- (UIButton *)dencryWithPriviteKeyBtn
{
    if (!_dencryWithPriviteKeyBtn)
    {
        _dencryWithPriviteKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dencryWithPriviteKeyBtn.frame = CGRectMake((kScreenWidth-100)/2+100, kScreenHeight-150, 150, 30);
        _dencryWithPriviteKeyBtn.backgroundColor = [UIColor redColor];
        [_dencryWithPriviteKeyBtn setTitle:@"解密密文" forState:UIControlStateNormal];
        [_dencryWithPriviteKeyBtn addTarget:self action:@selector(dencryWithPriviteKeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dencryWithPriviteKeyBtn;
}

//随机生成8位字符串
- (UILabel *)randomLabel
{
    if (!_randomLabel)
    {
        _randomLabel= [[UILabel alloc]initWithFrame:CGRectMake(150, 120, 100, 30)];
        _randomLabel.font = [UIFont systemFontOfSize:13];
        _randomLabel.text = @"随机密码";
    }
    return _randomLabel;
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
