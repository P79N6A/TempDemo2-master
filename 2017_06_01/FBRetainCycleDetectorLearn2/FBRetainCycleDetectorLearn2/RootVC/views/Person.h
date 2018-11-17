//
//  Person.h
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Apartment;
@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Apartment *apartment;

@end
