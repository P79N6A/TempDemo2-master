//
//  NSArray+findMaxNumber.m
//  findMaxNumber
//
//  Created by xiaoyulong on 16/7/29.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "NSArray+findMaxNumber.h"


@implementation NSArray (findMaxNumber)

- (NSNumber *)maxNumber
{
    NSNumber *maxNumber = nil;
    
    Class numberClass = [NSNumber class];
    
    for (NSNumber *num in self)
    {
        if (![num isKindOfClass:numberClass])
        {
            continue;
        }
        
        if ([maxNumber compare:num] != NSOrderedDescending)
        {
            maxNumber = num;
        }
    }
    
    return maxNumber;
}

@end
