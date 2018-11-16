//
//  CollectViewCell.m
//  BaseProject
//
//  Created by tarena on 15/11/18.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CollectViewCell.h"

@implementation CollectViewCell

-(UILabel *)titileLabel{
    if (!_titileLabel) {
        _titileLabel = [UILabel new];
        _titileLabel.font = [UIFont boldSystemFontOfSize:17];
        _titileLabel.numberOfLines = 2;
    }
    return _titileLabel;
}
-(DuWenImageView *)picImageView{
    if (!_picImageView) {
        _picImageView = [DuWenImageView new];
        [_picImageView.imageView setImage:[UIImage imageNamed:@"loading"]];
    }
    return _picImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titileLabel];
        [self.contentView addSubview:self.picImageView];
        [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titileLabel.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(200);
        }];
    }
    return self;
}
@end
