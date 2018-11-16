//
//  DuWanBottonPicCell.h
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuWenImageView.h"

@interface DuWenBottonPicCell : UITableViewCell
@property(nonatomic,strong)UILabel *titileLabel;
@property(nonatomic,strong)UILabel *hotLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)DuWenImageView *picImageView;
@property(nonatomic,strong)DuWenImageView *hotImageView;
@end
