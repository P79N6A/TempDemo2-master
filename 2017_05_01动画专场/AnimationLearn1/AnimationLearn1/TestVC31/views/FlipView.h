//
//  FlipView.h
//  transform3DRotate
//
//  Created by xiaoyulong on 16/6/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipView : UIView
@property (nonatomic, assign) NSInteger allPage;
@property (nonatomic, assign) NSInteger curPage;

- (void)flipWithCATransform3D:(CATransform3D)transform3D Per:(CGFloat)per;

@end
