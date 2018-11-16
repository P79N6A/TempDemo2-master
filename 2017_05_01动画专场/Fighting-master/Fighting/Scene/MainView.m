//
//  MainView.m
//  Fighting
//
//  Created by kangqijun on 14-10-16.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor grayColor];
        
        UILabel *revierLab = [[UILabel alloc] initWithFrame:CGRectMake((1024-200)/2, 0, 200, 768)];
        revierLab.backgroundColor = [UIColor greenColor];
        revierLab.text = @"  热\n  血\n  战\n  场";
        revierLab.numberOfLines = [revierLab.text length];
        revierLab.font = [UIFont boldSystemFontOfSize:100];
        [self addSubview:revierLab];
        
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        leftLab.textColor = [UIColor redColor];
        leftLab.font = [UIFont boldSystemFontOfSize:40];
        leftLab.text = @"甲";
        [self addSubview:leftLab];
        leftLab.transform = CGAffineTransformMakeRotation(M_PI_2);
        leftLab.center = CGPointMake(50, 768/2+25);
        
        UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(924, 0, 100, 100)];
        rightLab.textColor = [UIColor blueColor];
        rightLab.font = [UIFont boldSystemFontOfSize:40];
        rightLab.text = @"乙";
        [self addSubview:rightLab];
        rightLab.transform = CGAffineTransformMakeRotation(-M_PI_2);
        rightLab.center = CGPointMake(974, 768/2-25);
        
        //左上操作按钮
        UIButton *leftUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftUpBtn setFrame:CGRectMake(50,100, 50, 100)];
        leftUpBtn.backgroundColor = [UIColor brownColor];
        [leftUpBtn addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
        leftUpBtn.tag = Direction_LeftUp;
        [self addSubview:leftUpBtn];
        
        //左下操作按钮
        UIButton *leftDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftDownBtn setFrame:CGRectMake(50,768-200, 50, 100)];
        leftDownBtn.backgroundColor = [UIColor brownColor];
        [leftDownBtn addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
        leftDownBtn.tag = Direction_LeftDown;
        [self addSubview:leftDownBtn];
        
        //右上操作按钮
        UIButton *rightUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightUpBtn setFrame:CGRectMake(1024-100,100, 50, 100)];
        rightUpBtn.backgroundColor = [UIColor brownColor];
        [rightUpBtn addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchDown];
        rightUpBtn.tag = Direction_RightUp;
        [self addSubview:rightUpBtn];
        
        //又下操作按钮
        UIButton *rightDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightDownBtn setFrame:CGRectMake(1024-100,768-200, 50, 100)];
        rightDownBtn.backgroundColor = [UIColor brownColor];
        [rightDownBtn addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchDown];
        rightDownBtn.tag = Direction_RightDown;
        [self addSubview:rightDownBtn];
        
        //左侧人物
        leftPersonView = [[PersonView alloc] initWithFrame:CGRectMake(150, 768/2-25, 50, 50)];
        leftPersonView.backgroundColor = [UIColor redColor];
        [self addSubview:leftPersonView];
        
        //右侧侧人物
        rightPersonView = [[PersonView alloc] initWithFrame:CGRectMake(1024-200, 768/2-25, 50, 50)];
        rightPersonView.backgroundColor = [UIColor blueColor];
        [self addSubview:rightPersonView];
    }
    return self;
}

- (void)controlEvent:(UIButton *)btn
{
    switch (btn.tag)
    {
        case Direction_LeftUp:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = leftPersonView.frame;
                if (rect.origin.y - move_speed >0)
                {
                    rect.origin.y = rect.origin.y - move_speed;
                    leftPersonView.frame = rect;
                }
                
            }];
            
            [self leftFire];
            
            break;
        }
        case Direction_LeftDown:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = leftPersonView.frame;
                if (rect.origin.y + move_speed + leftPersonView.frame.size.height < 768)
                {
                    rect.origin.y = rect.origin.y + move_speed;
                    leftPersonView.frame = rect;
                }
                
            }];
            
            [self leftFire];
            
            break;
        }
        case Direction_RightUp:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = rightPersonView.frame;
                if (rect.origin.y - move_speed >0)
                {
                    rect.origin.y = rect.origin.y - move_speed;
                    rightPersonView.frame = rect;
                }
                
            }];
            
            [self rightFire];
            
            break;
        }
        case Direction_RightDown:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = rightPersonView.frame;
                if (rect.origin.y + move_speed + leftPersonView.frame.size.height < 768)
                {
                    rect.origin.y = rect.origin.y + move_speed;
                    rightPersonView.frame = rect;
                }
                
            }];
            
            [self rightFire];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)leftFire
{
    if (!leftWeaponTimer)
    {
        leftWeaponTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(leftWeaponFly) userInfo:nil repeats:YES];
        [leftWeaponTimer fire];
    }
    
}

- (void)rightFire
{
    if (!rightWeaponTimer)
    {
        rightWeaponTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(rightWeaponFly) userInfo:nil repeats:YES];
        [rightWeaponTimer fire];
    }
}

- (void)leftWeaponFly
{
    float xOffsetLeft = leftPersonView.frame.size.width + leftPersonView.frame.origin.x;
    float yOffsetLeft = leftPersonView.frame.size.height/2 + leftPersonView.frame.origin.y - 10;
    
    WeaponView *weaponLeftView = [[WeaponView alloc] initWithFrame:CGRectMake(xOffsetLeft, yOffsetLeft, 50, 20)];
    weaponLeftView.backgroundColor = [UIColor magentaColor];
    [self addSubview:weaponLeftView];
    
    [UIView animateWithDuration:2 animations:^{
        
        CGRect rect = weaponLeftView.frame;
        rect.origin.x = rightPersonView.frame.origin.x;
        weaponLeftView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [weaponLeftView removeFromSuperview];
        
    }];
}

- (void)rightWeaponFly
{
    float xOffsetRight = rightPersonView.frame.origin.x-50;
    float yOffsetRight = rightPersonView.frame.size.height/2 + rightPersonView.frame.origin.y - 10;
    
    WeaponView *weaponRightView = [[WeaponView alloc] initWithFrame:CGRectMake(xOffsetRight, yOffsetRight, 50, 20)];
    weaponRightView.backgroundColor = [UIColor purpleColor];
    [self addSubview:weaponRightView];
    
    [UIView animateWithDuration:2 animations:^{
        
        CGRect rect = weaponRightView.frame;
        rect.origin.x = leftPersonView.frame.origin.x;
        weaponRightView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [weaponRightView removeFromSuperview];
        
    }];
}

@end
