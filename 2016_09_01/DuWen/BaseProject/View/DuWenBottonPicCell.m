//
//  DuWanBottonPicCell.m
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenBottonPicCell.h"

@implementation DuWenBottonPicCell
-(UILabel *)titileLabel{
    if (!_titileLabel) {
        _titileLabel = [UILabel new];
        _titileLabel.font = [UIFont boldSystemFontOfSize:17];
        _titileLabel.numberOfLines = 2;
    }
    return _titileLabel;
}
-(UILabel *)hotLabel{
    if (!_hotLabel) {
        _hotLabel = [UILabel new];
        _hotLabel.font = [UIFont systemFontOfSize:17];
        _hotLabel.textColor = [UIColor colorWithRed:245/255.0 green:133/255.0 blue:125/255.0 alpha:1];

    }
    return _hotLabel;
}

-(DuWenImageView *)hotImageView{
    if (!_hotImageView) {
        _hotImageView = [DuWenImageView new];
    }
    return _hotImageView;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = [UIColor lightGrayColor];
    }
    return _dateLabel;
}
-(DuWenImageView *)picImageView{
    if (!_picImageView) {
        _picImageView = [DuWenImageView new];

    }
    return _picImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.titileLabel];
        [self.contentView addSubview:self.hotLabel];
        [self.contentView addSubview:self.hotImageView];
        [self.contentView addSubview:self.dateLabel];
        //标题距离左边 上边 右边 都为10
        [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        //hot 距离左边10 上边距离标题10 宽度为30
        [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.titileLabel.mas_bottom).mas_equalTo(10);
            make.width.mas_greaterThanOrEqualTo(10);
        }];
        //hot图标
        [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.hotLabel.mas_right).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(25, 20));
            make.bottomMargin.mas_equalTo(self.hotLabel.mas_bottomMargin).mas_equalTo(0);
        }];
        //时间 距离hot右边10 高度对齐 宽度30
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.titileLabel.mas_bottom).mas_equalTo(10);
            make.width.mas_greaterThanOrEqualTo(50);
        }];
        //图片 距离 hot底部10 左边 右边 下边 距离10
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(200);
        }];
    }
    return self;
}

@end
