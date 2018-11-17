//
//  BuddleCell.m
//  BuddleChatDemo
//
//  Created by xiaoyulong on 14-1-7.
//  Copyright (c) 2014年 xiaoyulong. All rights reserved.
//

#import "BuddleCell.h"

@implementation BuddleCell

- (void)dealloc
{
    self.qfChatStr = nil;
    self.qfImgView = nil;
    self.qfLabel = nil;
    self.qfPhotoImg = nil;
//    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // CGRectZero 0 0 0 0
        _qfImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _qfPhotoImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _qfLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _qfLabel.numberOfLines = 0;
        [self.contentView addSubview:_qfImgView];
        [self.contentView addSubview:_qfPhotoImg];
        [_qfImgView addSubview:_qfLabel];
    }
    return self;
}

// 重写setter方法 求frame
- (void)setQfChatStr:(NSString *)qfChatStr
{
    if (_qfChatStr != qfChatStr) {
//        [_qfChatStr release];
//        _qfChatStr = [qfChatStr retain];
        
        // 计算frame
        CGSize size = [qfChatStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(250, 2000)];
        // 拉伸气泡
        UIImage * oldImg = nil;
        // 气泡图片
        if (_qfWho) {
            oldImg = [UIImage imageNamed:@"1.png"];
            _qfPhotoImg.image = [UIImage imageNamed:@"3"];
        }else{
            oldImg = [UIImage imageNamed:@"2.png"];
            _qfPhotoImg.image = [UIImage imageNamed:@"4"];
        }
        
        // 拉伸图片方法  上左下右边距  中心点附近22 15
        UIImage * newImg = [oldImg resizableImageWithCapInsets:UIEdgeInsetsMake(15, 22, 15, 22)];
        
        _qfImgView.image = newImg;
        _qfLabel.text = _qfChatStr;
        
        // 修改frame
        _qfLabel.frame = CGRectMake(0, 0, size.width, size.height);
        // 气泡的位置
        if (_qfWho) {
            _qfPhotoImg.frame = CGRectMake(0, (size.height+20)/2, 30, 30);
            _qfImgView.frame = CGRectMake(30, 0, size.width+20, size.height+20);
        }else{
            _qfPhotoImg.frame = CGRectMake(290, (size.height+20)/2, 30, 30);
            _qfImgView.frame = CGRectMake(300-size.width-30, 0, size.width+20, size.height+20);
        }
        
        _qfLabel.center = CGPointMake(_qfImgView.frame.size.width/2, _qfImgView.frame.size.height/2);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
