//
//  RootViewController.m
//  FireballLearn1
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
    
    pos = CGPointMake(15.0, 7.5);
    self.view.backgroundColor = [UIColor blackColor];
    fireBall = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireball.png"]];
    fireBall.frame = CGRectMake(0, 0, 32, 32);
    [self.view addSubview:fireBall];
    [NSTimer scheduledTimerWithTimeInterval:(0.05) target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeSmoke:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
//    UIImageView *imageView = context;
//    [imageView removeFromSuperview];
}

-(void) onTimer {
    float x = fireBall.center.x;
    float y = fireBall.center.y;
    fireBall.center = CGPointMake(fireBall.center.x + pos.x, fireBall.center.y + pos.y);
    
    if (fireBall.center.x > 320 || fireBall.center.x < 0)
        pos.x = -pos.x;
    if (fireBall.center.y > 460 || fireBall.center.y < 0)
        pos.y = -pos.y;
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smokeball.png"]];
    imageView.frame = CGRectMake(x-16, y-16, 32, 32);
    [self.view addSubview:imageView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    imageView.frame = CGRectMake(x-6, y-6, 12, 12);
    [imageView setAlpha:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeSmoke:finished:context:)];
    [UIView commitAnimations];
//    [imageView release];
    
    [self.view bringSubviewToFront:fireBall];
    
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
