//
//  CommonUtil.m
//  StreamingMedia
//
//  Created by xiaoyulong on 16/6/14.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (CompareZeroResult)compareZeroWith:(CGFloat)differ
{
    CompareZeroResult result = -1;
    if (differ < 0.001 && differ > -0.001)
    {
        // differ为0
        result = equalToZero;
    }
    else
    {
        // differ 不为0
        if (differ > 0)
        {
            result = biggerThanZero;
        }
        else
        {
            result = smallerThanZero;
        }
    }
    return result;
}


@end
