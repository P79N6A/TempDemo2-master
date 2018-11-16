//
//  CommonUtil.h
//  StreamingMedia
//
//  Created by xiaoyulong on 16/6/14.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    biggerThanZero = 1,
    smallerThanZero,
    equalToZero
}CompareZeroResult;

@interface CommonUtil : NSObject

/// 和零比较
+ (CompareZeroResult)compareZeroWith:(CGFloat)differ;


@end
