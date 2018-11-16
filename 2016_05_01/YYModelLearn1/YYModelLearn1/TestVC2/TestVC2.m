//
//  TestVC2.m
//  YYModelLearn1
//
//  Created by xiaoyulong on 2018/4/10.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"
#import "UserModel.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self demo1];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demo1
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    UserModel *userModel = [[UserModel alloc] init];
    [userModel setValuesForKeysWithDictionary:jsonDict];
    
    NSLog(@"userModel.avatarURL==%@", userModel.avatarURL);
    NSLog(@"userModel.gravatarID==%@", userModel.gravatarID);
    
    
    // 也不崩
    if ([userModel.email isEqualToString:@""])
    {
        NSLog(@"dada");
    }
    
    // 也不崩
    NSLog(@"userModel.PicList.count==%d", userModel.PicList.count);
    
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
