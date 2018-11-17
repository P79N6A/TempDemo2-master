//
//  CommonUtil.h
//  weiChat
//
//  Created by xiaoyulong on 16/4/18.
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

/// 得到的是大写的字母
+ (NSString *)upperMd5:(NSString *)str;

/// 得到的是小写的字母
+ (NSString *)md5:(NSString *)input;

+ (NSString *)sha1:(NSString *)input;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (NSDictionary *)getIPAddresses;

/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
+ (NSString *)genNonceStr;

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text;

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length;


+ (NSString*)getDate:(NSDate*)date withFormat:(NSString*)dataFormat;

///  限制textfild 小数位数为2位
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/// 金额输入限制位数，可自定义整数位
+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number;

/// 金额输入限制（首位不能为0）
+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number shouldBiggerThanOne:(BOOL)bigger;


/// 计算高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;
+ (CGFloat)heightWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/// 计算宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;

/// 从文档目录下获取路径
+ (NSString *)cachesFolderPathWithName:(NSString *)imageName;

/// 根据最小尺寸转换图片
+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size;

/// 根据比例转换图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/// 保存图片到Cache
+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path;


/// 随机获取文件名 例如20131111_051014
+ (NSString *)getRandomFileName;

/// 和零比较
+ (CompareZeroResult)compareZeroWith:(CGFloat)differ;

/// iPhone设备唯一字符串标识符
+ (NSString *)generateUUID;

/// 获取（周一、周二、周三、周四、周五、周六、周日），包括年月日的整型值都可以获取到的
+ (NSString *)getWeekDayStringWithDate:(NSDate *)date;

//返回周几的问题
+ (NSString *)getWeekStrWith:(NSDate *)date;

/// 获取现在时间
+ (NSString *)getCurrentTime;

/// 获取当前时间, 改变时间格式
+ (NSString *)getCurrentTimeTypeWithDateFormatter:(NSString *)dateFormatterStr;

+ (NSString *)getDateStrWithDate:(NSDate *)date DateFormatter:(NSString *)dateFormatterStr;

/// dateStr＝2016-05-31 16:23:08； 得出前一天
+ (NSString *)previousDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr;


/// dateStr＝2016-05-31 16:23:08； 得出明天
+ (NSString *)nextDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr;

/// 过滤HTML 标签
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr;

//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength;


/**
 两个日期相比较，
 1  oneDayStr is in the future
 -1 dateA is in the past
 0 Both dates are the same
 */
+ (NSInteger)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr withFormatterStr:(NSString *)formatterStr;

/**
 * 银行卡 卡号分割 4个一组
 */
+ (NSString *)insertSpaceWithBankCardNumber:(NSString *)number;


/**
 * 在数字前加上人命币符号
 */
+ (NSString *)insertRMBSymbolWithMoney:(NSString *)money;



/**
 获得设备型号
 */
+ (NSString *)getCurrentDeviceModel;

// html 标签中有多少张图片
+ (NSArray *)filterImage:(NSString *)html;


@end
