//
//  DuWenDetailViewController.h
//  BaseProject
//
//  Created by tarena on 15/11/17.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuWenDetailViewController : UIViewController
@property (nonatomic,strong) NSString *newstitle;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSURL *picURL;
-(instancetype)initWithPicURL:(NSURL *)picURL URL:(NSURL *)url newsTitle:(NSString *)newstitle;
@end
