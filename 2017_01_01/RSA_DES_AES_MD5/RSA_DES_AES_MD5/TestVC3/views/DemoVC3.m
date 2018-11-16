//
//  DemoVC3.m
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DemoVC3.h"

#import "NSString+MD5Encrypt.h"
#import "MD5Util.h"

@interface DemoVC3 ()

@end

@implementation DemoVC3

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSString *str = @"swifter.tips";
        NSString *str2 = [str md5Encrypt];

        NSLog(@"str2==%@", str2);
        
        
        
        NSString *str11 = @"swifter.tips";
        NSString *str22 = [MD5Util md5:str11];
        NSLog(@"str22==%@", str22);

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
