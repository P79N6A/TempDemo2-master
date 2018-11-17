//
//  ViewController.h
//  reserveDream
//
//  Created by Mac on 14-11-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootController : UIViewController
- (void)setTitle:(NSString *)title;

- (void)setBackground;

- (void)setBackButton;

- (void)setRightButton:(UIButton*)button;

- (void)setRightButtons:(NSArray*)buttons;

- (void)backToPrevious;

@end

