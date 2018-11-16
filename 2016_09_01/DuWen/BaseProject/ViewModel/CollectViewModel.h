//
//  CollectViewModel.h
//  BaseProject
//
//  Created by tarena on 15/11/18.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectViewModel : NSObject
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 将收藏数据初始化 */
-(instancetype)initWithDataArr:(NSArray *)dataArr;

/** 有多少行 */
@property (nonatomic,assign) NSUInteger rowNumber;
/** 根据cell行数 返回title */
-(NSString *)titleForRow:(NSInteger)row;
/** 根据cell行数 返回url */
-(NSURL *)urlForRow:(NSInteger)row;
/** 根据cell行数 返回图片url */
-(NSURL *)picURLForRow:(NSInteger)row;
@end
