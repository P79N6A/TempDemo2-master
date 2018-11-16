//
//  RootViewController.m
//  RSALearn2
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "NSString+Convertion.h"
#import "NSObject+BasicEncodingRules.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     //公钥初始化
    NSData *module = [@"B5CE747C46781C81488F169C72828B72233E6E3B70525D2CE088665EC1B61F3F5FC7FE96CFB8BFFA699D61D0316ACC8C021A03ABF703C75510990F95008E4A3303ACF424B3E7EFEA001D0499CE00EB293A79B2054D11852E66D81EABF9B714A0013611059810C4CD670B50AC5D2E6B743049A5297AD38690C25BB3BBF95A331D" hexData];
    
    NSLog(@"module==%@", module);
    
    
    // 字符串必须是16进制描述也就是必须是0-9,A-F,这里不做检查，我们假设他是按照要求来的
    // 字符串表示的字节转化为字节数据
    NSData *exponent = [@"010001" hexData];
    NSLog(@"exponent==%@", exponent);
    

    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    [testArray addObject:module];
    [testArray addObject:exponent];
    
    NSData *publicKeyData = [testArray berData];
    
    
    NSLog(@"publicKeyData==%@", publicKeyData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
