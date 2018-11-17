//
//  LRPerceivedErrorCell.h
//  LRPerceivedErrorEffectLearn1
//
//  Created by xiaoyulong on 2017/7/10.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const LRPerceivedErrorCellHeight = 200.0;

@interface LRPerceivedErrorCell : UITableViewCell

- (void)refreshLRPerceivedErrorCell:(NSString *)imageName;
- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view;

@end
