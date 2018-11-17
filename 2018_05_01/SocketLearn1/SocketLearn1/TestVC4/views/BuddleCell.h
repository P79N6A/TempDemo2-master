//
//  BuddleCell.h
//  BuddleChatDemo
//
//  Created by xiaoyulong on 14-1-7.
//  Copyright (c) 2014年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuddleCell : UITableViewCell

@property (nonatomic, retain) UIImageView * qfPhotoImg;// 头像
@property (nonatomic, retain) UIImageView * qfImgView;// 气泡
@property (nonatomic, retain) UILabel * qfLabel;
@property (nonatomic, retain) NSString * qfChatStr;
@property (nonatomic, assign) BOOL qfWho;

@end
