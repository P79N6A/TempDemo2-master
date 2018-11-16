//
//  QLPopCell.h
//  趣旅网
//
//  Created by xiaoyulong on 16/5/27.
//  Copyright © 2016年 junjun. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const QLPopCellHeight = 50.0;

@interface QLPopCell : UITableViewCell

- (void)refreshQLPopCellWithTitle:(NSString *)titleStr imageName:(NSString *)imageName bgImageViewFrame:(CGRect)bgImageViewFrame;

@end
