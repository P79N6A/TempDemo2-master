//
//  HKLanguageTools.m
//  HKMall
//
//  Created by xujiaqi on 15/5/25.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "HKLanguageTools.h"
#import "NSString+MyString.h"

NSString *const HKLanguageTypeSystem = @"AppleLanguages";
NSString *const HKLanguageTypeEnglish = @"en";
NSString *const HKLanguageTypeZhHans = @"zh-Hans";
NSString *const HKLanguageTypeThai = @"th";

@interface HKLanguageTools()

@end

@implementation HKLanguageTools

+ (HKLanguageTools *)shareInstance
{
    static HKLanguageTools *languageTools;
    static  dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        languageTools = [[HKLanguageTools alloc] init];
    });
    return languageTools;
}

- (void)initUserLanguage
{
    NSString *userLanguage = [self defineUserLanguage];
    NSString *languagePath = nil;
    
    if (!userLanguage) {
        // 第一次加载，默认跟随系统
        userLanguage = HKLanguageTypeSystem;
        //获取文件路径
        languagePath = [[NSBundle mainBundle] pathForResource:[self currentSystemLanguage] ofType:@"lproj"];
    } else {
        if ([userLanguage isEqualToString:HKLanguageTypeSystem]) {
            //获取文件路径
            languagePath = [[NSBundle mainBundle] pathForResource:[self currentSystemLanguage] ofType:@"lproj"];
        }
        else {
            //begin  肖宇龙，2015.8.12，修改说明
            // 非第一次加载，也不是系统语言
            languagePath = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
        }
    }
    
    [self saveDefineUserLanguage:userLanguage];
    
    _languageBundle = [NSBundle bundleWithPath:languagePath];
}

- (void)saveDefineUserLanguage:(NSString *)userLanguage
{
    if (userLanguage == _currentLanguage) {
        return;
    }
    _currentLanguage = userLanguage;
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *languagePath = nil;
    
    languagePath = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj" ];
    
    if ([userLanguage isEqualToString:HKLanguageTypeSystem]) {
        languagePath = [[NSBundle mainBundle] pathForResource:[self currentSystemLanguage] ofType:@"lproj"];
    }
    
    if (!languagePath) {
        languagePath = [[NSBundle mainBundle] pathForResource:HKLanguageTypeThai ofType:@"lproj" ];
        [def setValue:HKLanguageTypeThai forKey:kUserLanguage];
    }
    
    _languageBundle = [NSBundle bundleWithPath:languagePath];
    
    [def setValue:userLanguage forKey:kUserLanguage];
    
    //添加 by chenli
    NSString *userLanguageString = nil;
    if ([userLanguage isEqualToString:HKLanguageTypeSystem]) {
        userLanguageString = kLanguageTypeSystem;
    }if ([userLanguage isEqualToString:HKLanguageTypeEnglish]) {
        userLanguageString = kLanguageTypeEnglish;
    }if ([userLanguage isEqualToString:HKLanguageTypeZhHans]) {
        userLanguageString = kLanguageTypeZhHans;
    }if ([userLanguage isEqualToString:HKLanguageTypeThai]) {
        userLanguageString = kLanguageTypeThai;
    }
    [self saveCurrentSelectedlanguage:userLanguageString];
    [def synchronize];
}

- (NSString*)currentSystemLanguage
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:HKLanguageTypeSystem];
    NSString* currentLanguage = [languages objectAtIndex:0];
    DLog(@"*******************currentLanguage %@", currentLanguage);
    
    NSArray *array = @[HKLanguageTypeThai, HKLanguageTypeZhHans, HKLanguageTypeEnglish, HKLanguageTypeSystem];
    __block BOOL isBelongTo = NO;   //检查是否属于这四种之间
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if ([currentLanguage isEqualToString:obj]) {
            isBelongTo = YES;
            *stop = YES;
        }
    }];
    if (!isBelongTo) {
        currentLanguage = HKLanguageTypeThai;
    }
    return currentLanguage;
}

- (NSString *)defineUserLanguage{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [def valueForKey:kUserLanguage];
    return userLanguage;
}

- (NSInteger)defineUserLanguageNumber
{
    NSString *languageString = [self defineUserLanguage];
    NSInteger languageNumber = 3;
    
    if ([languageString isEqualToString:HKLanguageTypeZhHans]) {
        languageNumber = 1;
    } else if ([languageString isEqualToString:HKLanguageTypeEnglish]) {
        languageNumber = 2;
    } else if ([languageString isEqualToString:HKLanguageTypeThai]) {
        languageNumber = 3;
    } else if ([languageString isEqualToString:HKLanguageTypeSystem]){
        
        NSString *currentLanguage = [self  currentSystemLanguage];
        if ([currentLanguage isEqualToString:HKLanguageTypeZhHans]) {
            languageNumber = 1;
        } else if ([currentLanguage isEqualToString:HKLanguageTypeEnglish]) {
            languageNumber = 2;
        } else if ([currentLanguage isEqualToString:HKLanguageTypeThai]) {
            languageNumber = 3;
        }
        
    }
    
    return languageNumber;
}

- (NSString *)locatizedStringForkey:(NSString *)keyStr
{
    //默认为本地资源文件名 为Localizable.strings
    return [self locatizedStringForkey:keyStr value:nil table:@"Localizable"];
}

- (NSString *)locatizedStringForkey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    static BOOL isOnce;
    if (!isOnce)
    {
        [self initUserLanguage];
        isOnce = YES;
    }
    
    NSString *str = [_languageBundle localizedStringForKey:key value:value table:tableName];
    return str;
}

/************************************************/

// 当前选择语言 张绍裕 20150812

// 保存当前选择
- (void)saveCurrentSelectedlanguage:(NSString *)text
{
    [[NSUserDefaults standardUserDefaults] setValue:text forKey:@"CurrentSelectedlanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 获取保存选择
- (NSString *)getCurrentSelectedlanguage
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSelectedlanguage"];
    if ([NSString isNull:string]) {
        string = HKLocalizedStringFromTable(@"跟随系统", tableLocalizable);
    }
    return string;
}

/************************************************/

@end
