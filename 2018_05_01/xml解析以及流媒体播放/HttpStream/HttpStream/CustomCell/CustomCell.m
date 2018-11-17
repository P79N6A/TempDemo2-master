//
//  ImageTableViewCell.m
//  NSOperationTest
//
//  Created by jhwang on 11-10-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import "CustomCell.h"


@implementation CustomCell
@synthesize iconImage;
@synthesize titleLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [[[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil] lastObject];
    return self;
}

- (void)setVideoInfo:(VideoInfo*)object
{
    [iconImage setImage:[UIImage imageNamed:object.videoIcon]];
    [titleLabel setText:object.videoTitle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
