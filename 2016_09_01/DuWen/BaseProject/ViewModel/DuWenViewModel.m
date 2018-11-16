//
//  DuWencViewModel.m
//  BaseProject
//
//  Created by soft on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenViewModel.h"
#import "DuWenModel.h"
#import "DuWenNetManager.h"
@implementation DuWenViewModel

-(instancetype)initWithType:(NSInteger)type OldTimestamp:(NSInteger)oldTimestamp{
    if (self = [super init]) {
        _type = type;
        _oldTimestamp = oldTimestamp;
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 必须使用initWithAid初始化", __FUNCTION__);
    }
    return self;
}

/** 获取model */
-(DuWenDataFeedlistItemsModel *)itemsModelforRow:(NSInteger)row{
    return [self modelForRow:row].items.firstObject;
}

-(DuWenDataFeedlistModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}

/** 判断当前cell是否为空 */
-(BOOL)isNilCellForRow:(NSInteger)row{
    return ![self itemsModelforRow:row];
}

/** 根据time秒数返回对应的日期 */
-(NSString *)dateWithTime:(double)time{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *nowdate = [NSDate date];
    NSDate *issuedate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString *nowTime = [formatter stringFromDate:nowdate];
    NSString *issueTime = [formatter stringFromDate:issuedate];
    double diffierenceValue = nowTime.doubleValue - issueTime.doubleValue;
    /** 时间错误，比当前时间还晚 */
    if (diffierenceValue< 0) {
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:nowdate];
    }
    /** 今天内 */
    else if (diffierenceValue < 1) {
        [formatter setDateFormat:@"HH:mm"];
    }
    /** 1年内 */
    else if (diffierenceValue < 10000){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    /** 1年外 */
    else{
        return [NSString stringWithFormat:@"%f年前",diffierenceValue/10000];
    }
    return [formatter stringFromDate:issuedate];
}

/** 有多少行 */
-(NSInteger)rowNumber{
    return self.dataArr.count;
}
/** 通过行数 返回此行中的图片img地址 */
-(NSURL *)imgUrlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self itemsModelforRow:row].img];
}
/** 通过行数 返回此行中的图片img02地址 */
-(NSURL *)img02UrlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self itemsModelforRow:row].img02];
}
/** 通过行数 返回此行中的图片img03地址 */
-(NSURL *)img03UrlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self itemsModelforRow:row].img03];
}
/** 通过行数 返回此行中title */
-(NSString *)titleForRow:(NSInteger)row{
    return [self itemsModelforRow:row].title;
}

/** 通过行数 返回此行中关注hot */
-(NSInteger)hotForRow:(NSInteger)row{
    return [self itemsModelforRow:row].hot;
}

/** 通过行数 返回此行中图片的数量 */
-(NSInteger)picCountForRow:(NSInteger)row{
    return [self itemsModelforRow:row].piccount;
}

/** 通过行数 返回此行中信息发布的时间 */
-(NSString *)timeForRow:(NSInteger)row{
    return [self dateWithTime:[self itemsModelforRow:row].time];
}
/** 通过行数 判断此行数据展示的类型 由templet参考 102图在最下面 120图在左边 103无图*/
-(NSInteger)cellTypeForRow:(NSInteger)row{
    return [self modelForRow:row].templet;
}

/** 通过行数 获取内容URL */
-(NSURL *)detailURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self itemsModelforRow:row].fileurl];
}


/** 通过行数 返回此行的头部图片 */
-(NSURL *)headPicForRow:(NSInteger)row{
    DuWenDataBannerItemsModel *model = self.bannar.items[row];
        return [NSURL URLWithString:model.img];
    
}

/** 通过行数 返回此行的头部title */
-(NSString *)headTitleForRow:(NSInteger)row{
    DuWenDataBannerItemsModel *model = self.bannar.items[row];
    return model.title;
}

-(NSURL *)headURLForRow:(NSInteger)row{
    DuWenDataBannerItemsModel *model = self.bannar.items[row];
    return [NSURL URLWithString:model.fileurl];
}

-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [DuWenNetManager getNewDataWithType:_type OldTimestamp:_oldTimestamp completionHandle:^(DuWenModel *model, NSError *error) {
        if (_oldTimestamp == 0) {
            [self.dataArr removeAllObjects];
            self.bannar = model.data.banner;
        }
        
        [self.dataArr addObjectsFromArray:model.data.feedlist];
        _oldTimestamp = model.data.oldTimestamp;
        completionHandle(error);
    }];
}

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    self.oldTimestamp = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    [self getDataFromNetCompleteHandle:completionHandle];
}
@end
