//
//  GoodCell.m
//  cart
//
//  Created by yulong on 16/2/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "GoodCell.h"

@interface GoodCell ()

@property (nonatomic, strong) UILabel *goodNameLabel;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation GoodCell

- (void)awakeFromNib {
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
        [self setUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)setUI
{
    [self.contentView addSubview:self.goodNameLabel];
    [self.contentView addSubview:self.addBtn];
}

#pragma mark - setter, getter

- (UILabel *)goodNameLabel
{
    if (_goodNameLabel == nil)
    {
        _goodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 20)];
        _goodNameLabel.backgroundColor = [UIColor yellowColor];
        _goodNameLabel.text = @"清蒸鳗鱼饭";
        _goodNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodNameLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _goodNameLabel;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil)
    {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = [UIColor yellowColor];
        _addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80, 0, 60, 20);
        [_addBtn setTitleColor:[UIColor colorWithRed:85 / 255.0 green:169 / 255.0 blue:253 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_addBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_addBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

#pragma mark - 按钮响应事件

- (void)addBtnClick:(UIButton *)sender
{
    if (self.addBtnCLickBlock)
    {
        self.addBtnCLickBlock(sender);
    }
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -


@end
