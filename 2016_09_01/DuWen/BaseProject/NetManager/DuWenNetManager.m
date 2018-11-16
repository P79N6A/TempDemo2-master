//
//  DuWenNetManager.m
//  BaseProject
//
//  Created by soft on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenNetManager.h"



@implementation DuWenNetManager

+(id)getNewDataWithType:(NSInteger)type OldTimestamp:(NSInteger)oldTimestamp completionHandle:(void(^)(id model, NSError *error))completionHandle{
    NSString *ID = nil;
    switch (type) {
            //时事
        case 0:
            ID = @"-1";
            break;
            //旅游
        case 1:
            ID = @"9";
            break;
            //旅游
        case 2:
            ID = @"7";
            break;
            //互联网
        case 3:
            ID = @"8";
            break;
        case 4:
            //健康
            ID = @"46";
            break;
        default:
            break;
    }
    NSString *path = [NSString stringWithFormat:@"http://interfacev5.vivame.cn/x1-interface-v5/json/newdatalist.json?type=1&id=%@&ot=%ld&nt=0",ID,(long)oldTimestamp];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([DuWenModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
