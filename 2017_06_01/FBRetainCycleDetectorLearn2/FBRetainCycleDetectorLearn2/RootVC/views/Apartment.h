//
//  Apartment.h
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;
@interface Apartment : NSObject

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) Person *person;

@end
