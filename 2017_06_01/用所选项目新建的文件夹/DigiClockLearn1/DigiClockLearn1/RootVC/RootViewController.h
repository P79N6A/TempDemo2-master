//
//  RootViewController.h
//  DigiClockLearn1
//
//  Created by xiaoyulong on 2017/5/22.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
{
    NSTimer *timer;
    UILabel *labels[7];
}
- (void)onTimer;
@end
