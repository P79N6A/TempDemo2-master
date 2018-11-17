//
//  TVSignProtocol.h
//  TVSignFramework
//
//  Created by wz on 16/5/11.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TVSignProtocol <NSObject>

@optional
- (void)didSignBackImage:(NSString*)_accountUid sealImage:(UIImage*)_sealImage;
- (void)didSignCancel:(NSString*)_accountUid;

@end
