//
//  ViewController.m
//  reserveDream
//
//  Created by Mac on 14-11-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "RootController.h"

@interface RootController ()
@end


@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];

}

- (void)setBackground
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"naviColor.png"]]];
}


- (void)setTitle:(NSString *)title
{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    t.font = [UIFont systemFontOfSize:21];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.text = title;
    self.navigationItem.titleView = t;

}

- (void)setBackButton
{
    UIButton *backButton = [UIButton buttonWithType:101];
    
    [backButton addTarget:self action:@selector(backToPrevious) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"后退" forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backToPrevious
{
    [self.navigationController  popViewControllerAnimated:NO];
}

- (void)setRightButton:(UIButton*)button
{
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= rightItem;
}

- (void)setRightButtons:(NSArray*)buttons
{
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    for(UIButton* btn  in buttons)
    {
        UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [tempArray addObject:rightItem];
    }
    NSArray* array = [NSArray arrayWithArray:tempArray];
    self.navigationItem.rightBarButtonItems= array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
