//
//  RootViewController.m
//  SpeedDialLearn1
//
//  Created by xiaoyulong on 2017/5/22.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];

    
    BOOL flag = tryDial();
    
    NSLog(@"flag==%d", flag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 这是 C 语言的函数写法
BOOL doesStringContain(NSString* string, NSString* charcter)
{
    for (NSInteger i = 0; i < [string length]; i++)
    {
        NSString* chr = [string substringWithRange:NSMakeRange(i, 1)];
        if([chr isEqualToString:charcter])
        {
            return TRUE;
        }
    }
    return FALSE;
}

BOOL tryDial()
{
    NSString* rawNumber = [[NSUserDefaults standardUserDefaults] stringForKey: @"phonenumber_preference"];
    if(rawNumber && ![rawNumber isEqualToString:@""])
    {
        NSString *telNumber = @"";
        for (int i = 0; i < [rawNumber length]; i++)
        {
            NSString *chr = [rawNumber substringWithRange:NSMakeRange(i, 1)];
            if(doesStringContain(@"0123456789", chr))
            {
                telNumber = [telNumber stringByAppendingFormat:@"%@", chr];
            }
        }
        
        telNumber = [NSString stringWithFormat:@"tel:%@", telNumber];
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:telNumber]];
        return TRUE;
    }
    return FALSE;
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
