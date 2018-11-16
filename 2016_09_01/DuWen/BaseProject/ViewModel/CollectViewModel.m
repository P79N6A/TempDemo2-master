//
//  CollectViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/18.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CollectViewModel.h"
#import "CollectModel.h"


@implementation CollectViewModel

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}


-(instancetype)initWithDataArr:(NSArray *)dataArr{
    if (self = [super init]) {
        for (int i = 0; i < dataArr.count; i++) {
            NSDictionary *dic = dataArr[i];
            CollectModel *model = [CollectModel mj_objectWithKeyValues:dic];
            [self.dataArr addObject:model];
        }
    }
    return self;
}

-(NSUInteger)rowNumber{
    return self.dataArr.count;
}

-(CollectModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}

/** 根据cell行数 返回title */
-(NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].newsTitle;
}
/** 根据cell行数 返回url */
-(NSURL *)urlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].newsURL];
}
/** 根据cell行数 返回图片url */
-(NSURL *)picURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].newsPicURL];
}

@end
