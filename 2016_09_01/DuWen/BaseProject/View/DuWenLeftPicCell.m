//
//  DuWanLeftPicCell.m
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenLeftPicCell.h"


@implementation DuWenLeftPicCell

-(DuWenImageView *)picImageView{
    if (!_picImageView) {
        _picImageView = [DuWenImageView new];
        [_picImageView.imageView setImage:[UIImage imageNamed:@"loading"]];
    }
    return _picImageView;
}

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
        [_hotImageView.imageView setImage:[UIImage imageNamed:@"thermometer_25x20"]];
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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.hotLabel];
        [self.contentView addSubview:self.hotImageView];
        [self.contentView addSubview:self.titileLabel];
        [self.contentView addSubview:self.dateLabel];
        //图片 距离左边 上边 下边 10 宽度75 高度 60
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(kWindowW/4);
            make.height.mas_equalTo(kWindowW/5);
        }];
        //titile 距离图片右边10 上边10 右边10
        [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.picImageView.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        //hot 左边对齐title 上边距离title底部10 宽度50
        [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(10);
            make.bottomMargin.mas_equalTo(self.picImageView.mas_bottomMargin).mas_equalTo(0);
            make.left.mas_equalTo(self.picImageView.mas_right).mas_equalTo(10);
                    }];
        //hot图标
        [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.hotLabel.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(20);
            make.bottomMargin.mas_equalTo(self.hotLabel.mas_bottomMargin).mas_equalTo(0);
        }];
        //时间 左边距离hot右边10 上边距离title10 宽度50
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottomMargin.mas_equalTo(self.picImageView.mas_bottomMargin).mas_equalTo(0);
            make.width.mas_greaterThanOrEqualTo(10);
        }];
    }
    return self;
}

@end
