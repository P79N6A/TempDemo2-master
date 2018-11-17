//
//  ViewController.h
//  reserveDream
//
//  Created by Mac on 14-11-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Toast+UIView.h"

@interface HttpKit: NSObject

+ (void)HttpConnectionKit:(NSString*)action x:(NSString*)contentType  dataStr:(NSString*)dataStr succeed:(void(^)(NSArray*))myarray  err:(void(^)(NSArray*))err;
+ (NSArray*)GetArray;

@end

