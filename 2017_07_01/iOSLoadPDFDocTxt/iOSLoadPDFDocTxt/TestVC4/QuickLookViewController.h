//
//  QuickLookViewController.h
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface QuickLookViewController : UIViewController

@property (nonatomic,strong) QLPreviewController *previewController;
@property (nonatomic,retain) NSURL *fileURL;

@end
