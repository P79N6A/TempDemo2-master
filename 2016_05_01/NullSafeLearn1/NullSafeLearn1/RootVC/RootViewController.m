//
//  RootViewController.m
//  NullSafeLearn1
//
//  Created by xiaoyulong on 16/12/9.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "CommonUserModel.h"

@interface RootViewController ()

@property (nonatomic, strong) NSDictionary *jsonDict;

@property (nonatomic, strong) UILabel *label;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    
    [self.view addSubview:self.label];
    
    
    [self click1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 手动解析
- (void)click1
{
    CommonUserModel *commonModel = [[CommonUserModel alloc] initWithAttributes:self.jsonDict];
    NSLog(@"commonModel.email==%@", commonModel.email);
    NSLog(@"commonModel.PicList==%@", commonModel.PicList);
    
    
    self.label.text = [NSString stringWithFormat:@"%@", commonModel.email];
    
    
    /**
     "email": null,
     
     这里就崩掉了
     报错  [NSNull count]: unrecognized selector
     [NSNull isEqualToString:]: unrecognized
     NSLog(@"%d", commonModel.PicList.count);
     */
    
    
    
    
    // 1. 判断的时候会崩掉
    if ([commonModel.email isEqualToString:@""])
    {
        NSLog(@"emial/////");
    }
    
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
    
    
    // 2. 取数组的count的时候会崩掉
    NSLog(@"commonModel.PicList.count==%d", commonModel.PicList.count);
    
    if (![commonModel.PicList isEqual:[NSNull null]])
    {
        NSLog(@"判断是null");
        NSLog(@"commonModel.PicList.count==%d", commonModel.PicList.count);
    }
    
}


- (UILabel *)label
{
    if (_label == nil)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 100, 20)];
        _label.backgroundColor = [UIColor yellowColor];
        _label.font = [UIFont systemFontOfSize:14];
        
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor blackColor];
        
    }
    return _label;
}

@end
