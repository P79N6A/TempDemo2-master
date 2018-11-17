//
//  MyhCell.m
//  SDAutolayouttableView练习
//
//  Created by myh on 16/5/14.
//  Copyright © 2016年 ltygs. All rights reserved.
//

#import "MyhCell.h"
#import <UIView+SDAutoLayout.h>
#import "MYHSliderChangeLabelFont/MYHSliderChangeLabelFont.h"

@interface MyhCell ()
@property(nonatomic,strong)MYHSliderChangeLabelFont *slider ;
@end

@implementation MyhCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        
        
    }
    return self;

}
- (void)layoutSubviews{
    [super layoutSubviews];
     NSLog(@"%s,line = %D",__FUNCTION__,__LINE__);


}
-(void)setupUI{
 
    self.imageViews = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageViews];
    self.imageViews.sd_layout
    .leftSpaceToView(self.contentView , 10)
    .widthIs(50)
    .heightIs(60)
    .topSpaceToView(self.contentView,10);

    
    self.NameLabel = [UILabel new];
//    [self.NameLabel sizeToFit];
    [self.contentView addSubview:self.NameLabel];
    self.NameLabel.sd_layout
    .topEqualToView(self.imageViews)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.imageViews,10)
    .autoHeightRatio(0);
    
    self.detailLabel  = [UILabel new];
//    [self.detailLabel sizeToFit];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.sd_layout
    .topSpaceToView(self.NameLabel,10)
    .leftEqualToView(self.NameLabel)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);

    [self setupAutoHeightWithBottomView:self.detailLabel bottomMargin:10];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
