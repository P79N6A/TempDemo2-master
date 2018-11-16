//
//  MainView.h
//  Fighting
//
//  Created by kangqijun on 14-10-16.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonView.h"
#import "WeaponView.h"

//控制方向
typedef enum
{
    Direction_LeftUp = 0,
    Direction_LeftDown ,
    Direction_RightUp ,
    Direction_RightDown
    
}Direction;

//移动速度
#define move_speed   30

@interface MainView : UIView
{
    PersonView *leftPersonView;
    PersonView *rightPersonView;
    
    NSTimer *weaponTimer;
}

@end
