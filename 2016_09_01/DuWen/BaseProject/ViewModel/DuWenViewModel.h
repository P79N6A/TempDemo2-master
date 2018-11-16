//
//  DuWencViewModel.h
//  BaseProject
//
//  Created by soft on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//
#import "BaseViewModel.h"
#import "BaseNetManager.h"
#import "DuWenModel.h"

@interface DuWenViewModel : BaseViewModel
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger oldTimestamp;
/** 根据类型和时间来初始化 */
-(instancetype)initWithType:(NSInteger)type OldTimestamp:(NSInteger)oldTimestamp;
/** 有多少行 */
@property(nonatomic,assign)NSInteger rowNumber;
/** 判断当前cell是否为空 */
-(BOOL)isNilCellForRow:(NSInteger)row;

/** 通过行数 返回此行中的图片img地址 */
-(NSURL *)imgUrlForRow:(NSInteger)row;
/** 通过行数 返回此行中的图片img02地址 */
-(NSURL *)img02UrlForRow:(NSInteger)row;
/** 通过行数 返回此行中的图片img03地址 */
-(NSURL *)img03UrlForRow:(NSInteger)row;
/** 通过行数 返回此行中title */
-(NSString *)titleForRow:(NSInteger)row;
/** 通过行数 返回此行中关注hot */
-(NSInteger)hotForRow:(NSInteger)row;
/** 通过行数 返回此行中图片的数量 */
-(NSInteger)picCountForRow:(NSInteger)row;
/** 通过行数 返回此行中信息发布的时间 */
-(NSString *)timeForRow:(NSInteger)row;
/** 通过行数 判断此行数据展示的类型 由templet参考 102图在最下面 120图在左边 103无图*/
-(NSInteger)cellTypeForRow:(NSInteger)row;
/** 通过行数 获取内容URL */
-(NSURL *)detailURLForRow:(NSInteger)row;

/** 头部滚动视图 */
@property(nonatomic,strong)DuWenDataBannerModel *bannar;
/** 通过行数 返回此行的头部图片 */
-(NSURL *)headPicForRow:(NSInteger)row;
/** 通过行数 返回此行的头部title */
-(NSString *)headTitleForRow:(NSInteger)row;
/** 通过行数 返回此行的头部URL */
-(NSURL *)headURLForRow:(NSInteger)row;

@end

