//
//  GoodCell.h
//  cart
//
//  Created by yulong on 16/2/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat GoodCellHeight = 60.0;

@interface GoodCell : UITableViewCell

@property (nonatomic, strong) void (^ addBtnCLickBlock)(UIButton *sender);

@end
