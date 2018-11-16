//
//  DuWanNoPicCell.m
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenNoPicCell.h"

@implementation DuWenNoPicCell
-(UILabel *)titileLabel{
    if (!_titileLabel) {
        _titileLabel = [UILabel new];
        _titileLabel.font = [UIFont boldSystemFontOfSize:17];
        _titileLabel.numberOfLines = 2;
    }
    return _titileLabel;
}
-(DuWenImageView *)hotImageView{
    if (!_hotImageView) {
        _hotImageView = [DuWenImageView new];
        [_hotImageView.imageView setImage:[UIImage imageNamed:@"thermometer_25x20"]];
    }
    return _hotImageView;
}


-(UILabel *)hotLabel{
    if (!_hotLabel) {
        _hotLabel = [UILabel new];
        _hotLabel.font = [UIFont systemFontOfSize:17];
        _hotLabel.textColor = [UIColor colorWithRed:245/255.0 green:133/255.0 blue:125/255.0 alpha:1];
    }
    return _hotLabel;
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
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titileLabel];
        [self.contentView addSubview:self.hotLabel];
        [self.contentView addSubview:self.hotImageView];
        [self.contentView addSubview:self.dateLabel];
        //标题 距离 左边 上边 10 右边25
        [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-25);
        }];
        
        //hot 距离左边10 标题10 宽50
        [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.titileLabel.mas_bottom).mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_greaterThanOrEqualTo(10);
        }];
        
        [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.hotLabel.mas_right).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(25, 20));
            make.bottomMargin.mas_equalTo(self.hotLabel.mas_bottomMargin).mas_equalTo(0);
        }];
        //date 距离 右边10 上边与hot对齐 宽50
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(self.hotLabel.mas_topMargin).mas_equalTo(0);
            make.right.mas_equalTo(-10);
        }];
    }
    return self;
}
@end
