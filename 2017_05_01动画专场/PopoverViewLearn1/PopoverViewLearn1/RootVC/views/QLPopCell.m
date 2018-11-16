//
//  QLPopCell.m
//  趣旅网
//
//  Created by xiaoyulong on 16/5/27.
//  Copyright © 2016年 junjun. All rights reserved.
//

#import "QLPopCell.h"

@interface QLPopCell ()

@property(nonatomic, strong) UIImageView    *iconImgView;
@property(nonatomic, strong) UILabel        *titleLabel;
//@property(nonatomic, strong) UIImageView*    dotImgView;
@property(nonatomic, strong) UIView         *line;

@end

@implementation QLPopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
}

- (UIImageView *)iconImgView
{
    if (_iconImgView == nil)
    {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (QLPopCellHeight - 20)/2, 20, 20)];
        _iconImgView.backgroundColor = [UIColor clearColor];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImgView.frame.origin.x + _iconImgView.frame.size.width + 10, (QLPopCellHeight - 20)/2, 100, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)line
{
    if (_line == nil)
    {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, QLPopCellHeight - 0.5, 100, 0.5)];
        _line.backgroundColor = [UIColor whiteColor];
        _line.alpha = 0.7;
    }
    return _line;
}

- (void)refreshQLPopCellWithTitle:(NSString *)titleStr imageName:(NSString *)imageName bgImageViewFrame:(CGRect)bgImageViewFrame
{
    self.titleLabel.text = titleStr;
    self.iconImgView.image = [UIImage imageNamed:imageName];
    
    self.line.frame = CGRectMake(10, QLPopCellHeight - 0.5, bgImageViewFrame.size.width - 20, 0.5);
}

@end


