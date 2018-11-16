//
//  DemoVC4.m
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DemoVC4.h"
#import "RSAUtil.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 测试
#define RSA_Public_key         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDB0zMFedOZ4961mXJCco+BrXFFEZagmcjKRiph2H4KKN2N14At+ZjfoPDQcov6FFX+FB5jjIsypfxM6RmZyl9U+shFG1DgH4jBSLK3COYuThuPB0o/GirWmcU+aaLWVHzQP/wrSd+JVoBiugo2MpWgoEi6Et6qyz4PprS9LyJSMQIDAQAB"
//私钥
#define RSA_Privite_key        @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMHTMwV505nj3rWZckJyj4GtcUURlqCZyMpGKmHYfgoo3Y3XgC35mN+g8NByi/oUVf4UHmOMizKl/EzpGZnKX1T6yEUbUOAfiMFIsrcI5i5OG48HSj8aKtaZxT5potZUfNA//CtJ34lWgGK6CjYylaCgSLoS3qrLPg+mtL0vIlIxAgMBAAECgYBarrtiRntPtqMOB7rDh+HIZCNokzAL96dPq8BMgwOFMVVm9XpNCEgT6LKCc/U1jaol87e8D5dYnPwL58tIfrxWrZvTzwSlNLjeDZM6rM/0sNszIGNS/k8JSLDLMtNCAaBLL5y5H8o1pp5OpJEawlfVDogfR/aqjL83qbQHltdbuQJBAP8T1c2JTu77tm3WIx6inAqqzDtf9I+GarpTpdHG+Jkt0GOnDsYDDTewgPcS5o3qELv2IcRVvSYhO1MLYgEklwMCQQDChqc4EXAmMoxlVDwmJ7TJ3KGjKvfsBqB5c1VnITTwX3lKbKZSLEpJOc4AFWPi1SVFWJMQFYXWUvpspQVCmwG7AkEAqArCNJj7xldPlMaY9mq8EA77YzZQ4Gj2UPAgcrX5OrjC65O4GN0TzRdbrunlt6J3Cc0Z68VsSf1kns4F76jSTwJAPveTXWTXpqWqKIqxxbAIp2cRs12PTwl+HJImzPFEz6I4As1UsTjA+x8I/aHu6VgRbncTc5tj7VKC2XQ5VawTTQJAWZ0Wk/0hp+4RktNcbuGejFTJZnJdTtyaiC3L34zuP7M5vcVCAWZeKXMTMJmW3EsZ8eF3v1VqHBFwgV/HPKpnuQ=="


@interface DemoVC4 ()

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

@implementation DemoVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"RSA加密";
    self.view.backgroundColor = [UIColor yellowColor];
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
    self.randomLabel.text = @"随机密码";

}


#pragma mark - 按钮响应事件

//公钥加密数据
- (void)encryWithPublicKeyBtnClick:(UIButton *)sender
{
    //生成一个随机的8位字符串，作为des加密数据的key,对数据进行des加密，对加密后的数据用公钥再进行一次rsa加密
    
    _encryWithPublicKeyTextview.text = [RSAUtil encryptString: _originTexfield.text publicKey:RSA_Public_key];
    NSLog(@"%@",_encryWithPublicKeyTextview.text);
    //_encryWithPublicKeyTextview.text = [RSA encryptString: _originTexfield.text privateKey:RSA_Privite_key];
}


//私钥解密数据
- (void)dencryWithPriviteKeyBtnClick:(UIButton *)sender
{
    _dencryWithPriviteKeyTextview.text = [RSAUtil decryptString:_encryWithPublicKeyTextview.text privateKey:RSA_Privite_key];
    // _dencryWithPriviteKeyTextview.text = [RSA decryptString:RSA_Test_secret publicKey:RSA_Public_key];
    
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

//原始数据懒加载
-(UILabel *)originLabel
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
-(UITextField *)originTexfield
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
-(UILabel *)encryLabelTitle
{
    if (!_encryLabelTitle)
    {
        _encryLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 100, 30)];
        _encryLabelTitle.font = [UIFont systemFontOfSize:13];
        _encryLabelTitle.text = @"加密数据";
    }
    return  _encryLabelTitle;
}


//解密标题
-(UILabel *)dencryLabelTitle
{
    if (!_dencryLabelTitle)
    {
        _dencryLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 100, 30)];
        _dencryLabelTitle.font = [UIFont systemFontOfSize:13];
        _dencryLabelTitle.text = @"解密数据:";
    }
    return _dencryLabelTitle;
}




//加密密文显示UITextView
-(UITextView *)encryWithPublicKeyTextview
{
    if (!_encryWithPublicKeyTextview)
    {
        _encryWithPublicKeyTextview= [[UITextView alloc]initWithFrame:CGRectMake(10, 160, kScreenWidth-20, 150)];
        _encryWithPublicKeyTextview.font = [UIFont systemFontOfSize:13];
        _encryWithPublicKeyTextview.backgroundColor = [UIColor cyanColor];
    }
    return _encryWithPublicKeyTextview;
}


//加密密文显示UITextView
-(UITextView *)dencryWithPriviteKeyTextview
{
    if (!_dencryWithPriviteKeyTextview)
    {
        _dencryWithPriviteKeyTextview = [[UITextView alloc]initWithFrame:CGRectMake(10, 350, kScreenWidth-20, 150)];
        _dencryWithPriviteKeyTextview.font = [UIFont systemFontOfSize:13];
        _dencryWithPriviteKeyTextview.backgroundColor = [UIColor cyanColor];
    }
    return _dencryWithPriviteKeyTextview;
}

//加密数据btn
-(UIButton *)encryWithPublicKeyBtn
{
    if (!_encryWithPublicKeyBtn)
    {
        _encryWithPublicKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _encryWithPublicKeyBtn.frame = CGRectMake((kScreenWidth-100)/2-150, kScreenHeight-100, 150, 30);
        _encryWithPublicKeyBtn.backgroundColor = [UIColor redColor];
        [_encryWithPublicKeyBtn setTitle:@"生成密文" forState:UIControlStateNormal];
        [_encryWithPublicKeyBtn addTarget:self action:@selector(encryWithPublicKeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _encryWithPublicKeyBtn;
}

//解密数据btn
-(UIButton *)dencryWithPriviteKeyBtn
{
    if (!_dencryWithPriviteKeyBtn)
    {
        _dencryWithPriviteKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dencryWithPriviteKeyBtn.frame = CGRectMake((kScreenWidth-100)/2+100, kScreenHeight-100, 150, 30);
        _dencryWithPriviteKeyBtn.backgroundColor = [UIColor redColor];
        [_dencryWithPriviteKeyBtn setTitle:@"解密密文" forState:UIControlStateNormal];
        [_dencryWithPriviteKeyBtn addTarget:self action:@selector(dencryWithPriviteKeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dencryWithPriviteKeyBtn;
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
