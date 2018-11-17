//
//  DocumentInteractionViewController.h
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentInteractionViewController : UIViewController <UIDocumentInteractionControllerDelegate, UIAlertViewDelegate>

@property(nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

- (void)openFileWithURL:(NSURL *)URL;

@end
