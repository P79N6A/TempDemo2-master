//
//  FlipView.m
//  transform3DRotate
//
//  Created by xiaoyulong on 16/6/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "FlipView.h"

@interface FlipView ()

@property (nonatomic, strong) UILabel *pageLabel;

@end

@implementation FlipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.pageLabel];
    }
    return self;
}

- (UILabel *)pageLabel
{
    if (_pageLabel == nil)
    {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        _pageLabel.layer.borderColor = [UIColor clearColor].CGColor;
        _pageLabel.layer.borderWidth = 1.0;
        _pageLabel.layer.cornerRadius = _pageLabel.bounds.size.height / 2;
        _pageLabel.layer.masksToBounds = YES;
        
        _pageLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _pageLabel.text = @"1/5";
        _pageLabel.font = [UIFont systemFontOfSize:14];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pageLabel;
}

- (void)setAllPage:(NSInteger)allPage
{
    _allPage = allPage;
    
    self.pageLabel.text = [NSString stringWithFormat:@"1/%ld", _allPage];
}

- (void)setCurPage:(NSInteger)curPage
{
    _curPage = curPage;
    
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", _curPage, _allPage];
}

- (void)flipWithCATransform3D:(CATransform3D)transform3D Per:(CGFloat)per
{
    self.pageLabel.layer.transform = CATransform3DRotate(transform3D, per* 1*M_PI, 0, 1, 0);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
