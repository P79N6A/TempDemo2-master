//
//  UINavigationItem+correct_offset.m
//  iOS7UINavitionBar
//
//  Created by yulong on 15/7/24.
//  Copyright (c) 2015年 HuiXin. All rights reserved.
//

#import "UINavigationItem+correct_offset.h"

#define  ios7 ([[[UIDevice currentDevice] systemVersion] floatValue]>= 7.0 ?YES:NO)

@implementation UINavigationItem (correct_offset)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if (ios7)
    {
        // Add a spacer on when running lower than iOS 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = - 20 ;
        
        [self setLeftBarButtonItems:@[negativeSpacer, leftBarButtonItem]];
    }
    else
    {
        
        // Just set the UIBarButtonItem as you would normally
        [self setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if (ios7)
    {
        // Add a spacer on when running lower than iOS 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = 10 ;
        
        self.rightBarButtonItems = @[negativeSpacer, rightBarButtonItem];
    }
    else
    {
        // Just set the UIBarButtonItem as you would normally
        self.rightBarButtonItem = rightBarButtonItem;
    }
    
}
@end
