//
//  FreshlightManager.m
//  DataHelper
//
//  Created by yulong on 15/12/16.
//  Copyright © 2015年 xiaoyulong. All rights reserved.
//  功能描述：用于调用设备闪光灯（打开或关闭）

#import "FreshlightManager.h"
#import <AVFoundation/AVFoundation.h>

static AVCaptureDevice *captureDevice;

@implementation FreshlightManager

+ (void)showFreshlight
{
    captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([captureDevice hasTorch] && [captureDevice hasFlash])
    {
        if (captureDevice.torchMode == AVCaptureTorchModeOff)
        {
            [captureDevice lockForConfiguration:nil];
            [captureDevice setTorchMode: AVCaptureTorchModeOn];
            [captureDevice unlockForConfiguration];
        }
        else
        {
            [captureDevice lockForConfiguration:nil];
            [captureDevice setTorchMode: AVCaptureTorchModeOff];
            [captureDevice unlockForConfiguration];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"温馨提醒"
                                    message:@"抱歉，该设备没有闪光灯功能！"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
    }
}

@end
