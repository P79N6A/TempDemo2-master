//
//  DuWenModel.m
//  BaseProject
//
//  Created by soft on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenModel.h"

@implementation DuWenModel
@end


@implementation DuWenDataModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"feedlist":[DuWenDataFeedlistModel class]};
}
@end

@implementation DuWenDataBannerModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[DuWenDataBannerItemsModel class]};
}
@end

@implementation DuWenDataBannerItemsModel
@end

@implementation DuWenDataFeedlistModel
+(NSDictionary *)objectClassInArray{
    return @{@"items":[DuWenDataFeedlistItemsModel class]};
}
@end

@implementation DuWenDataFeedlistItemsModel
@end



