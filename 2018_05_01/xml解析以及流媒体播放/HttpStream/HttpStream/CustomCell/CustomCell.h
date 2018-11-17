//
//  ImageTableViewCell.h
//  NSOperationTest
//
//  Created by jhwang on 11-10-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "VideoInfo.h"

@interface  CustomCell : UITableViewCell
{
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setVideoInfo:(VideoInfo*)object;

@end
