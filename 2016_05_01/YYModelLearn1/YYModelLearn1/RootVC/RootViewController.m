//
//  RootViewController.m
//  YYModleLearn1
//
//  Created by xiaoyulong on 16/8/4.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "YYGHUser.h"
#import "CommonUserModel.h"

@interface RootViewController ()

@property (nonatomic, strong) NSDictionary *jsonDict;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"jsonDict==%@", _jsonDict);
    
    
    
    
//    [self demo1];
//    [self demo2];
    [self demo3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: - 手动解析字符串为 null 时，isEqualToString 做判断时会崩溃
- (void)demo1
{
    CommonUserModel *commonModel = [[CommonUserModel alloc] initWithAttributes:self.jsonDict];
    NSLog(@"commonModel.email==%@", commonModel.email);
    // commonModel.email==<null>
    NSLog(@"commonModel.PicList==%@", commonModel.PicList);
    // commonModel.PicList==<null>

    
    /**
     1. "email": null  ,判断的时候会崩掉
     -[NSNull isEqualToString:]: unrecognized selector sent to instance 0x1084fcfc0
     */
//    if ([commonModel.email isEqualToString:@""])
//    {
//        NSLog(@"emial/////");
//    }
    
    
    // 可以这样子判断
    if ([commonModel.email isEqual:[NSNull null]])
    {
        NSLog(@"emial/////");
    }
    
    
    // 所以如果这样判断的话， isEqual 要最先判断
    if (![commonModel.email isEqual:[NSNull null]]
        && commonModel.email != nil
        && ![commonModel.email isEqualToString:@""])
    {
        NSLog(@"emial/////");
    }
}


// MARK: - 手动解析数组为 null 时，commonModel.PicList.count 时会崩溃
- (void)demo2
{
      CommonUserModel *commonModel = [[CommonUserModel alloc] initWithAttributes:self.jsonDict];
    
    // 2. 取数组的count的时候会崩掉，因为 "PicList": null,
    //    这里就崩掉了
    //    报错  [NSNull count]: unrecognized selector
    //    NSLog(@"commonModel.PicList.count==%d", commonModel.PicList.count);
    
    
    
    // 可以这样子判断
    if (![commonModel.PicList isEqual:[NSNull null]])
    {
        NSLog(@"判断是null");
        NSLog(@"commonModel.PicList.count==%lu", (unsigned long)commonModel.PicList.count);
    }
}



// MARK: - 用YYModel 解析则不会出现上面两种情况
- (void)demo3
{
    // YYModel
    YYGHUser *userModel = [YYGHUser yy_modelWithJSON:self.jsonDict];
    NSLog(@"userModel==%@", userModel);
    

    
    NSLog(@"model.email==%@", userModel.email);
    // userModel.email==(null)
    
    // 使用 YYModel解析出来的是 userModel.email==(null),不是<null>
    // 后台返回commonModel.email==<null>
    
    // 这样子判断也不会崩掉
    if ([userModel.email isEqualToString:@""]) {
        NSLog(@"是%s", "");
    } else {
        NSLog(@"不是%s", "");
    }
    
    
    // 正确判断
    if (userModel.email == nil) {
        NSLog(@"userModel.email是nil");
    } else {
        NSLog(@"userModel.email不是nil");
    }
    
    // 注意如果 userModel.email 是 nil，不代表是 null
    if ([userModel.email isEqual:[NSNull null]]) {
        NSLog(@"是<null>");
    } else {
        NSLog(@"不是<null>");
    }
    

    
    
    // 使用 不会崩掉
    NSLog(@"userModel.PicList.count==%lu", (unsigned long)userModel.PicList.count);
    

    
    // 所以用这个判断就可以了吧, 这样子写就可以了
    if (![userModel.hireable isEqual:[NSNull null]] &&
        userModel.hireable != nil &&
        ![userModel.hireable isEqualToString:@""])
    {
//        self.hireable.text = [NSString stringWithFormat:@"%@", userModel.hireable];
    }

}



@end
