//
//  Factory.m
//  BaseProject
//
//  Created by tarena on 15/11/17.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+(void)addMenuItemToVC:(UIViewController *)vc{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"windows_32px"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn bk_addEventHandler:^(id sender) {
        [vc.sideMenuViewController presentLeftMenuViewController];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,menuItem];
}

+(void)addCollectItemToVC:(UIViewController *)vc newsPicURL:(NSURL *)picURL newsURL:(NSURL *)url newsTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"Vote_32px"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn bk_addEventHandler:^(id sender) {
        if (btn.selected == NO) {
            [btn setImage:[UIImage imageNamed:@"heart_32px"] forState:UIControlStateNormal];
            btn.selected = YES;
            [self saveDataWithPicURL:[picURL absoluteString] Title:title URL:[url absoluteString]];
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 10;
    vc.navigationItem.rightBarButtonItems = @[menuItem,spaceItem];
}

+(void)addBackItemToVc:(UIViewController *)vc{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"outgoing_32px"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn bk_addEventHandler:^(id sender) {
        [vc.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //使用小弹簧控制缩小菜单按钮和边缘距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,menuItem];
}

+(void)saveDataWithPicURL:(NSString *)picURL Title:(NSString *)title URL:(NSString *)url{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [path stringByAppendingPathComponent:@"collect.plist"];
    NSMutableArray *arr = [NSMutableArray new];
//    BOOL isexist = [[NSBundle mainBundle] pathForResource:@"collect" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        arr = [[NSMutableArray arrayWithContentsOfFile:plistPath] mutableCopy];
    }
    NSDictionary *newInfo = @{@"newsPicURL":picURL,@"newsTitle":title,@"newsURL":url};
    [arr addObject:newInfo];
    [arr writeToFile:plistPath atomically:YES];
//    NSLog(@"%@",plistPath);
}

@end
