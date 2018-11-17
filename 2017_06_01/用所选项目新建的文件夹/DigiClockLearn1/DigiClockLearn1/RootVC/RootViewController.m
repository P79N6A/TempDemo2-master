//
//  RootViewController.m
//  DigiClockLearn1
//
//  Created by xiaoyulong on 2017/5/22.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/CAAnimation.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int x = 65;
    int y = 170;
    labels[0] = [self createLabelWithBackgroundInRect:CGRectMake(x, y, 40, 80) withStartText:@"8"];
    labels[1] = [self createLabelWithBackgroundInRect:CGRectMake(x+=35, y, 40, 80) withStartText:@"8"];
    labels[2] = [self createLabelWithBackgroundInRect:CGRectMake(x+=35, y-7, 22, 80) withStartText:@":"];
    labels[3] = [self createLabelWithBackgroundInRect:CGRectMake(x+=20, y, 40, 80) withStartText:@"8"];
    labels[4] = [self createLabelWithBackgroundInRect:CGRectMake(x+=35, y, 40, 80) withStartText:@"8"];
    
    labels[5] = [self createLabelWithBackgroundInRect:CGRectMake(40, y-26, 32, 80) withStartText:@"."];
    labels[6] = [self createLabelWithBackgroundInRect:CGRectMake(40, y-12, 32, 80) withStartText:@"."];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.50];
    [UIView setAnimationDelay:0.50];
    [UIView setAnimationRepeatCount:99999999.0];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    labels[2].alpha = 0.0;
    [UIView commitAnimations];
    
    [self onTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)createLabelWithBackgroundInRect:(CGRect)rect withStartText:(NSString *)startText
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:55.0]];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    label.text = startText;
    label.textAlignment = NSTextAlignmentRight;
    label.alpha = 0.15;
    
    label = [[UILabel alloc] initWithFrame:rect];
    [label setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:55.0]];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor greenColor];
    [self.view addSubview:label];
    label.text = startText;
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

- (void)onTimer
{
    NSDate *nowDate = [NSDate date];
//    NSLog(@"nowDate==%@", nowDate);
    
    int dig[5];
//    int hourOfDay = [[nowDate dateWithCalendarFormat:nil timeZone:nil] hourOfDay];
//    int minuteOfHour = [[nowDate dateWithCalendarFormat:nil timeZone:nil] minuteOfHour];
    
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss eee";
//    NSString *dateStr = [formater stringFromDate:nowDate];
//    NSLog(@"dateStr==%@", dateStr);

    formater.dateFormat = @"mm";
    NSString *minuteStr = [formater stringFromDate:nowDate];
//    NSLog(@"minuteStr==%@", minuteStr);

    
    formater.dateFormat = @"ss";
    NSString *secondStr = [formater stringFromDate:nowDate];
//    NSLog(@"secondStr==%@", secondStr);

    
    NSInteger hourOfDay = minuteStr.integerValue;
    NSInteger minuteOfHour = secondStr.integerValue;
    
    labels[5].alpha = hourOfDay > 11 ? 0.0 : 1.0;
    labels[6].alpha = hourOfDay > 11 ? 1.0 : 0.0;
    
    if (hourOfDay > 12)
    {
        hourOfDay -= 12;
    }
    
    
    
    dig[0] = hourOfDay / 10;
    dig[1] = hourOfDay % 10;
    dig[2] = 0;
    dig[3] = minuteOfHour / 10;
    dig[4] = minuteOfHour % 10;;
    
    labels[0].text = [NSString stringWithFormat:@"%d", dig[0]];
    labels[1].text = [NSString stringWithFormat:@"%d", dig[1]];
    labels[3].text = [NSString stringWithFormat:@"%d", dig[3]];
    labels[4].text = [NSString stringWithFormat:@"%d", dig[4]];
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
