//
//  DynamicView.h
//  Animation
//
//  Created by yulong on 16/2/16.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawModel.h"

static CGFloat const DynamicViewHeight = 200.0 - 6;

@interface DynamicView : UIView

- (void)drawDottedLineWith:(NSMutableArray *)dataArr;
- (void)drawDynamicViewWith:(DrawModel *)dModel;

@end
