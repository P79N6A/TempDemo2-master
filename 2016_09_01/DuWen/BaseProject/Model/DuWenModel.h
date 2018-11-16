//
//  DuWenModel.h
//  BaseProject
//
//  Created by soft on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class DuWenDataModel,DuWenDataBannerModel,DuWenDataFeedlistModel,DuWenDataBannerItemsModel,DuWenDataFeedlistItemsModel;

@interface DuWenModel : BaseModel

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) DuWenDataModel *data;
@property (nonatomic, assign) NSInteger code;

@end

@interface DuWenDataModel : BaseModel

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *ItypeName;
@property (nonatomic, assign) NSInteger oldTimestamp;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, strong) NSArray *newlist;
@property (nonatomic, strong) NSArray *adlist;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) DuWenDataBannerModel *banner;
@property (nonatomic, strong) NSArray<DuWenDataFeedlistModel *> *feedlist;
@property (nonatomic, assign) NSInteger newTimestamp;
@property (nonatomic, strong) NSArray *headerlist;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger status;
@end


@interface DuWenDataBannerModel : BaseModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger isOptimize;
@property (nonatomic, assign) NSInteger templet;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger stypeID;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, assign) NSInteger updatecount;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, strong) NSArray<DuWenDataBannerItemsModel *> *items;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *more;
@end


@interface DuWenDataBannerItemsModel : BaseModel
@property (nonatomic, assign) NSInteger imgHeight;
@property (nonatomic, copy) NSString *sItypeName;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *cm;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *ext;
@property (nonatomic, assign) NSInteger hot;
@property (nonatomic, copy) NSString *mimg;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger isOptimize;
@property (nonatomic, copy) NSString *pm;
@property (nonatomic, copy) NSString *img03;
@property (nonatomic, assign) NSInteger subCount;
@property (nonatomic, assign) NSInteger stypeID;
@property (nonatomic, copy) NSString *adPlatformID;
@property (nonatomic, assign) NSInteger artificial;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *seqDate;
@property (nonatomic, assign) NSInteger endBannerType;
@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *clickMonitor;
@property (nonatomic, assign) NSInteger piccount;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger templet;
@property (nonatomic, assign) NSInteger imgWIDth;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *exposureMonitor;
@property (nonatomic, assign) NSInteger action;
@property (nonatomic, copy) NSString *channels;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy) NSString *img02;
@property (nonatomic, copy) NSString *fileurl;
@property (nonatomic, copy) NSString *bigimg;
@end


@interface DuWenDataFeedlistModel : BaseModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger isOptimize;
@property (nonatomic, assign) NSInteger templet;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger stypeID;
@property (nonatomic, assign) long long time;
@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, assign) NSInteger updatecount;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, strong) NSArray<DuWenDataFeedlistItemsModel *> *items;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *more;
@end


@interface DuWenDataFeedlistItemsModel : BaseModel
@property (nonatomic, assign) NSInteger imgHeight;
@property (nonatomic, copy) NSString *sItypeName;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *cm;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *ext;
@property (nonatomic, assign) NSInteger hot;
@property (nonatomic, copy) NSString *mimg;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger isOptimize;
@property (nonatomic, copy) NSString *pm;
@property (nonatomic, copy) NSString *img03;
@property (nonatomic, assign) NSInteger subCount;
@property (nonatomic, assign) NSInteger stypeID;
@property (nonatomic, copy) NSString *adPlatformID;
@property (nonatomic, assign) NSInteger artificial;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *seqDate;
@property (nonatomic, assign) NSInteger endBannerType;
@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *clickMonitor;
@property (nonatomic, assign) NSInteger piccount;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger templet;
@property (nonatomic, assign) NSInteger imgWIDth;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *exposureMonitor;
@property (nonatomic, assign) NSInteger action;
@property (nonatomic, copy) NSString *channels;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) long long time;
@property (nonatomic, copy) NSString *img02;
@property (nonatomic, copy) NSString *fileurl;
@property (nonatomic, copy) NSString *bigimg;
@end






