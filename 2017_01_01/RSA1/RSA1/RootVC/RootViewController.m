//
//  RootViewController.m
//  RSA1
//
//  Created by xiaoyulong on 16/7/13.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "RSAManager.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
    
    /**
     
     userId==1234556
     2016-07-13 14:02:36.843 RSA1[3011:839744] rsaUserId==uZGW+XYzn4cvH8H8l+kBGm5gk/vIxUpY9qmSbbjlAgPbwgVgv0HwcAqjGfn6xmUc0hcgCy4dGUlvGl+nKnNbRAeNZIeZZsVRDDhdblE5R+nz0HxZadqYQkjLm7PAtTslYL2d+i0udAkO3KqOFiSA+bAF+A5vxiLXeNk5AB64BGQ=
     
     userId==1234556
     2016-07-13 14:02:16.587 RSA1[2998:837872] rsaUserId==VatGBRy5ktyVdWKfqdftevEDiCQuIazdGIwnEUHytZrCHltM1IJNgqC0bSJRUrpBhIaQsZj8E+1gFpyjGqeQD2RUcMzLcnhNM/LUDaA5uR2bnT9ADkwm9MEnMzNOyC82Sq2z/duLX/L6Spembi+1r45G6m2+1xlrJYAeJvWNu7M=
     
     
    userId==1234556
     rsaUserId==W+LRmkLmKWfcj4QlRsoo58lEMDabmjcLeWxc672r6BzB3O4nj1wFroGJ0Vm2B3oyuLdgaxHoIi6FgSw/yVTdXrCFbdJGKScdDfXMNQuVYyq3uhH718HkI4DXwopT1fIAiD94hxZl3JO2zM7dqsAxJmOdabNa9hpIFrWujpwqwDg=
     */
    
    
    
    /**
     
     1)创建RSA私钥
      (生成私钥，java端使用的)
     openssl genrsa -out private_key.pem 1024
     
     2)创建RSA公钥
     openssl rsa -in private_key.pem -pubout -out public_key.pem
     
     2)创建证书请求（按照提示输入信息）
     openssl req -new -out cert.csr -key private_key.pem
     
     3)自签署根证书
     openssl x509 -req -in cert.csr -out public_key.der -outform der -signkey private_key.pem -days 3650
     4)用java代码要从这个文件中得到想要的priavtekey 可以先用命令（就被这东西卡住了）
     (私钥转格式，在ios端使用私钥解密时用这个私钥)
     openssl pkcs8 -topk8 -inform PEM -outform DER -in private_key.pem -out private_pkcs8_der.key -nocrypt
     
     
     5)将 public_key.der 文件转成 base64的字符串
     openssl base64 -in public_key.der
     
     就是 RSAManager中的 NSString *cert；
     
     MIICZzCCAdACCQDop1LFiuM/hTANBgkqhkiG9w0BAQUFADB4MQswCQYDVQQGEwJD
     aDELMAkGA1UECBMCR0QxCzAJBgNVBAcTAlNaMQ0wCwYDVQQKEwRRdWx2MQ0wCwYD
     VQQLEwRRdWx2MQ8wDQYDVQQDEwZ4aWFveXUxIDAeBgkqhkiG9w0BCQEWETExODI4
     NjkzNTNAcXEuY29tMB4XDTE2MDcxMzA4Mzg0NVoXDTI2MDcxMTA4Mzg0NVoweDEL
     MAkGA1UEBhMCQ2gxCzAJBgNVBAgTAkdEMQswCQYDVQQHEwJTWjENMAsGA1UEChME
     UXVsdjENMAsGA1UECxMEUXVsdjEPMA0GA1UEAxMGeGlhb3l1MSAwHgYJKoZIhvcN
     AQkBFhExMTgyODY5MzUzQHFxLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
     gYEAvN/YKLEmhPWLUEvyWS+jXQeXWVSmBiHfdFgkoSxaz84k1gssxk2spNj+e2l+
     J2gWi9phqB0wYjzJj4rm4Bi2E/LP5dG20IrJyem22KX4ENvOyMeRFECdPLhWQGxG
     tdWlYan+/hEZzqpXjixuDUFvmk0mf96f2Y/JTmiuB/naDKcCAwEAATANBgkqhkiG
     9w0BAQUFAAOBgQB0ERXAmXqXpXu8N/0w93IbxhHs1We5vbMYb0vIEPVQh4E2dXqf
     UNsU39l6Q5wZlmWG3g6vWqhVLQOf0vB44UacABMVVu+EjzJuTGaEfQbIlS6Xrz12
     VT5hFoSg+oi/vB2rX6ttJSN8WWaGJsa43lkNPfyGJnrgFsJhfqTAegv3gg==
     

     
     */
    

    [self demo1];
    [self demo2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demo2
{
    // 加密
    NSString *userId = @"1234556";
    RSAManager *manager = [[RSAManager alloc] init];
    NSString *rsaUserId = [manager encryptWithString:userId];
    
    /**
     openssl base64 -in public_key.der
     所得到的字符串就是
     
     就是 RSAManager中的 NSString *cert；
     */
    // 解密
    NSString *orginal2 = [RSAManager decryptString:rsaUserId privateKey:RSA_Privite_key];
    NSLog(@"orginal2==%@", orginal2);

}


- (void)demo1
{
    // 加密
    NSString *userId = @"1234556";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    RSAManager *manager = [[RSAManager alloc] initWithKeyPath:path];
    NSString *rsaUserId =  [manager encryptWithString:userId];
    NSLog(@"userId==%@", userId);
    NSLog(@"rsaUserId==%@", rsaUserId);
    
    
    // 解密
    NSString *orginal = [RSAManager decryptString:rsaUserId privateKey:RSA_Privite_key];
    NSLog(@"orginal==%@", orginal);

    
    // 解不出来
    NSString *orginal1 = [RSAManager decryptString:rsaUserId publicKey:RSA_Public_key];
    NSLog(@"orginal1==%@", orginal1);

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
