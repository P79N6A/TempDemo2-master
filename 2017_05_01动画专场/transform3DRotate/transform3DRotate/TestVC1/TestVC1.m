//
//  TestVC1.m
//  transform3DRotate
//
//  Created by xiaoyulong on 16/6/6.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *dateStr = @"2016-05-31 16:23:08";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    
    // 将dateStr转换为时间戳,加上 24小时，然后再将时间戳转换为时间格式的yyyy-MM-dd HH:mm:ss字符串
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    
    // 加上24小时
    timeInterval = timeInterval + 24 * 60 * 60;
    
    // 新的时间
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *newDateStr = [formatter stringFromDate:newDate];
    NSLog(@"newDateStr==%@", newDateStr);
    
    /**
     newDateStr==2016-06-01 16:23:08
     */
    
    
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
