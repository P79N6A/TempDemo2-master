//
//  VideoBackBtn.m
//  AnimationLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "VideoBackBtn.h"

@implementation VideoBackBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _cusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 17) / 2, 10, 17, 17)];
        _cusImageView.contentMode = UIViewContentModeScaleAspectFit;
        _cusImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_cusImageView];
        
        _cusTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, self.bounds.size.width, self.bounds.size.width - 23)];
        _cusTitleLabel.backgroundColor = [UIColor clearColor];
        _cusTitleLabel.textAlignment = NSTextAlignmentCenter;
        _cusTitleLabel.font = [UIFont systemFontOfSize:11];
        _cusTitleLabel.textColor = UIColorHex(0x666666);
        [self addSubview:_cusTitleLabel];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
