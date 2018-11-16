//
//  DataHelper.h
//  DataHelper
//
//  Created by yulong on 15/11/5.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    biggerThanZero = 1,
    smallerThanZero,
    equalToZero
}CompareZeroResult;

@interface DataHelper : NSObject

/// 和零比较, (浮点数与浮点数比较，有等号时要注意精度范围；没有等号的比较可以直接比较)
+ (CompareZeroResult)compareZeroWith:(CGFloat)differ;

/// 得到的是大写的字母
+ (NSString *)upperMd5:(NSString *)str;

/// 得到的是小写的字母
+ (NSString *)md5:(NSString *)input;

/// 对图片进行重新压缩
- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;

/// 根据最小尺寸转换图片
+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size;

/// 根据比例转换图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/// 保存图片到Cache
+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path;

/// 从文档目录下获取路径
+ (NSString *)cachesFolderPathWithName:(NSString *)imageName;

/// 指定路径删除文件
+ (void)removeCachesFolderAtPath:(NSString*)filePath;

/// 过滤HTML 标签
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr;

/// 获取现在时间
+ (NSString *)getCurrentTime;

/// 获取当前时间, 改变时间格式
+ (NSString *)getCurrentTimeTypeWithDateFormatter:(NSString *)dateFormatterStr;

/// dateStr＝2016-05-31 16:23:08； 得出明天
+ (NSString *)nextDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr;

/// 设置view的边框属性 张绍裕 20150806
+ (void)setlayerWithView:(UIView *)view radius:(CGFloat)radius borderColor:(UIColor *)bordercolor borderWidth:(CGFloat)borderwidth;

/// tableView隐藏多余的线
+ (void)setExtraCellLineHidden:(UITableView *)tableView;

/// 转化DeviceToken
+ (NSString*)conversionDeviceToken:(NSData*)deviceToken;

/// 随机获取文件名 例如20131111_051014,唯一的
+ (NSString *)getRandomFileName;

/// 获取一个随机整数，范围在[from,to），包括from，不包括to
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;

/// 判断gps是否有效
+ (BOOL)gpsIsValidLongitude:(double)longitude latitude:(double)latitude;



/*
 iPhone设备唯一字符串标识符， 这个应该不是唯一的，每次生成都不一样啊
 
 用这个方法获取的每次都一样，但是和在Xcode Device中看到的手机的identifier不一样啊
 [IPhoneInfoHelper getDeviceUUID];
 */
+ (NSString *)generateUUID;

/// 获取设备唯一ID
+ (NSString *)getDeviceID;




#pragma mark - UIColor
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(float)al;

/**
 *  32位 md5加密
 *  @param srcString 需要加密的字符串
 *  @param uppercase 是否需要转大写
 *  @return 加密后的字符串
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase;

/**
 *  16位 md5加密
 *  @param srcString 需要加密的字符串
 *  @param uppercase 是否需要转大写
 *  @return 加密后的字符串
 */
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase;


/**
 *  计算高度
 *  @param string 需要计算高度的字符串
 *  @param font   字体
 *  @param width  限制宽度
 *  @return 返回计算出来的高度
 */
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  计算宽度 单行
 *  @param string
 *  @param font
 *  @return
 */
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;

/**
 * 当需要改变Label中得一段字体属性时调用
 * @param allstring 总字段
 * @param string    需要改变属性的字段
 * @param color     颜色
 * @param size      字体大小
 * @return  处理过后带属性的字段
 */
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size;

/**
 *  设置textfiled左边的空白
 *  @param textField
 *  @param rect
 */
+ (void)setEmptyLeftViewForTextField:(UITextField *)textField withFrame:(CGRect)rect;

/// 判断是否为空字符串
+(BOOL) isEmptyOrNull:(NSString *) string;

/**
 *  限制textfild 整数部分最多5位，小数位数最多为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  动态限制输入金额长度
 *  限制textfild 整数部分最多 stringLength 位，小数位数最多为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string stringLength:(float)stringLength;

/// 数字输入限制（自定义位数） 张绍裕 20150824，都是整数位
+ (BOOL)limitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number;

// string to number
+ (NSNumber *)stringToNum:(NSString *)string;


/**
 截取小数点后几位方法 
 moneyStr：金额字符串 
 nuberCount：保留小数点后几位不做四舍五入
 如剧情需要可设置基数加100即可 例：102表示保留2位小数 当值为0.00时自动转换为0
 */
+ (NSString *)interceptMoneyString:(NSString *)moneyStr numberCount:(NSInteger)nuberCount;

/// 获取当前app版本
+ (NSString *)getAppCurrentVersion;

/// 获取当前app包名
+ (NSString *)getBundleIdentifier;

/// 限制textField不能输入的字符
+ (BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr;


@end












