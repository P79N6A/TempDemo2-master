//
//  HKLanguageTools.h
//  HKMall
//
//  Created by xujiaqi on 15/5/25.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserLanguage @"userLanguage"

#define HKLocalizedStringFromTable(key, tbl) \
[[HKLanguageTools shareInstance] locatizedStringForkey:key value:nil table:tbl]

#define kLanguageTypeSystem     HKLocalizedStringFromTable(@"Follow_System", tableLocalizable)
#define kLanguageTypeEnglish    @"English"
#define kLanguageTypeZhHans    @"简体中文"
#define kLanguageTypeThai      @"ไทย"

///跟随系统
extern NSString *const HKLanguageTypeSystem;
///英文
extern NSString *const HKLanguageTypeEnglish;
///简体中文
extern NSString *const HKLanguageTypeZhHans;
///泰文
extern NSString *const HKLanguageTypeThai;

@interface HKLanguageTools : NSObject

@property (strong, nonatomic) NSString *currentLanguage;
@property (strong, nonatomic) NSBundle *languageBundle;

+ (HKLanguageTools *)shareInstance;
/// app启动就调用的
- (void)initUserLanguage;
- (void)saveDefineUserLanguage:(NSString *)userLanguage;

///获取当前语言
- (NSString *)defineUserLanguage;
///获取当前语言 1：中文，2：英文,3:泰文
- (NSInteger)defineUserLanguageNumber;

- (NSString *)locatizedStringForkey:(NSString *)keyStr;
- (NSString *)locatizedStringForkey:(NSString *)key  value:(NSString *)value table:(NSString *)tableName;

/************************************************/

// 当前选择语言 张绍裕 20150812

/// 保存当前选择
- (void)saveCurrentSelectedlanguage:(NSString *)text;

/// 获取保存选择
//- (NSString *)getCurrentSelectedlanguage;

/************************************************/

@end
