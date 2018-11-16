//
//  UserModel.m
//  YYModleLearn1
//
//  Created by xiaoyulong on 16/8/4.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if ([key isEqualToString:@"description"])
//    {
//        self.descriptionDe = value;
//    }
    
    // 不一样的这样子写， 一样的不用写，
    if ([key isEqualToString:@"avatar_url"])
    {
        self.avatarURL = value;
    }
    
    if ([key isEqualToString:@"gravatar_id"])
    {
        self.gravatarID = value;
    }
    
    
}

@end
