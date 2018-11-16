//
//  DuWenNetManager.h
//  BaseProject
//
//  Created by soft on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "DuWenModel.h"

typedef NS_ENUM(NSInteger,DuWenType){
    DuWenTypeShiShi,
    DuWenTypeLvYou,
    DuWenTypeGaoXiao,
    DuWenTypeHuLianWang,
    DuWenTypeJianKang,
};
@interface DuWenNetManager : BaseNetManager

+(id)getNewDataWithType:(NSInteger)type OldTimestamp:(NSInteger)oldTimestamp completionHandle:(void(^)(id model, NSError *error))completionHandle;

@end
