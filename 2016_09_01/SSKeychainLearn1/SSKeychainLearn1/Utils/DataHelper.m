//
//  DataHelper.m
//  DataHelper
//
//  Created by yulong on 15/11/5.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "DataHelper.h"
#import "SSKeychain.h"

// md5 32位加密导入
#import <CommonCrypto/CommonDigest.h>

@implementation DataHelper

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

/// 得到的是大写的字母
+ (NSString *)upperMd5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/// 得到的是小写的字母
+ (NSString *)md5:(NSString *)input
{
    if (input == nil || input.length == 0)
    {
        return nil;
    }
    
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // 返回的就是已经改变的图片
    return scaledImage;
}

/// 根据最小尺寸转换图片
+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size
{
    //    DLog(@"%@",NSStringFromCGSize(image.size));
    CGSize temSize = CGSizeZero;
    if (MIN(image.size.width, image.size.height)<=size) {
        temSize = image.size;
    }else if (image.size.width-image.size.height>0) {
        temSize = CGSizeMake(image.size.width*size/image.size.height, size);
    }else{
        temSize = CGSizeMake(size, image.size.height*size/image.size.width);
    }
    UIGraphicsBeginImageContext(temSize);
    [image drawInRect:CGRectMake(0, 0, temSize.width, temSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/// 根据比例转换图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/// 保存图片到Cache
+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path
{
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.5);
    [imageData writeToFile:path atomically:NO];
}

#pragma mark 从文档目录下获取路径
+ (NSString *)cachesFolderPathWithName:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile  = [cachesDirectory stringByAppendingPathComponent:imageName];
    return fullPathToFile;
}

/// 指定路径删除文件
+ (void)removeCachesFolderAtPath:(NSString*)filePath
{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

/// 获取现在时间
+ (NSString *)getCurrentTime
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:nowDate];
}

/// 获取当前时间, 改变时间格式
+ (NSString *)getCurrentTimeTypeWithDateFormatter:(NSString *)dateFormatterStr
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = @"";
    [dateFormatter setDateFormat:dateFormatterStr];
    dateString = [dateFormatter stringFromDate:nowDate];
    
    //    NSString *language = [[HKLanguageTools shareInstance] currentLanguage];
    //    if ([language isEqualToString:@"zh-Hans"])
    //    {
    //        // 中文
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    //    else if ([language isEqualToString:@"en"])
    //    {
    //        // 英文
    //        [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    //    else
    //    {
    //        // 泰文
    //        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    //        dateString = [dateFormatter stringFromDate:nowDate];
    //    }
    
    return dateString;
}

+ (NSString *)nextDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr
{
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [dateFormatter setDateFormat:dateFormatterStr];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];

    // 将dateStr转换为时间戳,加上 24小时，然后再将时间戳转换为时间格式的yyyy-MM-dd HH:mm:ss字符串
    NSTimeInterval timeInterval = [date timeIntervalSince1970];

    
    // 加上24小时
    timeInterval = timeInterval + 24 * 60 * 60;
    
    // 新的时间
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *newDateStr = [dateFormatter stringFromDate:newDate];
    
    return newDateStr;
}

/// 过滤HTML 标签
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr
{
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        // NSLog(@"start-> %d end-> %d", arrowTagStartRange.location, arrowTagEndRange.location);
        // NSString *arrowSubString = [originHtmlStr substringWithRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location)];
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        // NSLog(@"Result--->%@", result);
        return [self filterHtmlTag:result]; //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""]; // 过滤&nbsp等标签
        //result = [originHtmlStr stringByReplacingOccurrencesOf ........
    }
    return result;
}

/// 设置view的边框属性 张绍裕 20150806
+ (void)setlayerWithView:(UIView *)view radius:(CGFloat)radius borderColor:(UIColor *)bordercolor borderWidth:(CGFloat)borderwidth
{
    if (view)
    {
        if (radius > 0.0)
        {
            view.layer.cornerRadius = radius;
            view.layer.masksToBounds = YES;
        }
        
        if (bordercolor && borderwidth > 0.0)
        {
            view.layer.borderColor = bordercolor.CGColor;
            view.layer.borderWidth = borderwidth;
        }
    }
}

/// tableView隐藏多余的线
+ (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/// 转化DeviceToken
+ (NSString*)conversionDeviceToken:(NSData*)deviceToken
{
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return deviceTokenStr;
}

/// 随机获取文件名 例如20131111_051014
+ (NSString *)getRandomFileName
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *dateString = [formatter stringFromDate:date];

    NSInteger random = [self getRandomNumber:0 to:1000000];
    return [NSString stringWithFormat:@"%@_%06d",dateString,random];
}

/// 获取一个随机整数，范围在[from,to），包括from，不包括to
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to-from + 1)));
}

#pragma mark - gps
/// 判断gps是否有效
+ (BOOL)gpsIsValidLongitude:(double)longitude latitude:(double)latitude
{
    if (latitude!=0.0
        && longitude!=0.0
        && latitude<90.0
        && latitude>-90.0
        && longitude<180.0
        && longitude>-180.0) {
        return YES;
    }
    return NO;
}


/*
 iPhone设备唯一字符串标识符， 这个应该不是唯一的，每次生成都不一样啊
 
 
 获得的这个CFUUID值系统并没有存储。每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。
 如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。
 
 用这个方法获取的每次都一样，但是和在Xcode Device中看到的手机的identifier不一样啊
 [IPhoneInfoHelper getDeviceUUID];
 */
+ (NSString *)generateUUID
{
    CFUUIDRef uuid;
    CFStringRef uuidString;
    NSString *result;
    
    uuid = CFUUIDCreate(NULL);
    uuidString = CFUUIDCreateString(NULL, uuid);
    result = [NSString stringWithFormat:@"%@",uuidString];
    
    CFRelease(uuidString);
    CFRelease(uuid);
    
    return result;
}

+ (NSString *)getDeviceID
{
    NSString *huixinUUID = [SSKeychain passwordForService:@"huixinUUID" account:@"huixinUUID"];
    if ([huixinUUID isEqual:[NSNull null]]
        || huixinUUID == nil
        || [huixinUUID isEqualToString:@""]
        || [huixinUUID isEqualToString:@" "]
        || [huixinUUID isEqualToString:@"   "])
    {
        huixinUUID = [self generateUUID];
        [SSKeychain setPassword:huixinUUID forService:@"huixinUUID" account:@"huixinUUID"];
    }
    return huixinUUID;
}

#pragma mark - UIColor
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(float)al
{
    return [[self colorWithHexString:color] colorWithAlphaComponent:al];
}

#pragma mark - md5 32位加密
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return uppercase ? [result uppercaseString] : result;
}

#pragma mark - md5 16位加密
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString uppercase:uppercase];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}


#pragma mark - 计算高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(rtSize.height) + 0.5;
}

#pragma mark- 单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGSize rtSize;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(rtSize.width) + 0.5;
}

#pragma mark- 当需要改变Label中得一段字体属性时调用
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSRange stringRange = [allstring rangeOfString:string];
    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
    [stringDict setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
    [allString setAttributes:stringDict range:stringRange];
    
    return allString;
}

#pragma mark- 设置TextField左边空白
+ (void)setEmptyLeftViewForTextField:(UITextField *)textField withFrame:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

+ (BOOL)isEmptyOrNull:(NSString *)string
{
    if (!string || [string isEqualToString:@""] ||[string isEqualToString:@" "]||[string isEqualToString:@"  "])
    {
        return YES;
    }
    else
    {
        NSString *trimedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0)
        {
            // empty string
            return YES;
        }
        else
        {
            // is neither empty nor null
            return NO;
        }
    }
}

/**
 *  限制textfild 整数部分最多5位，小数位数最多为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     BOOL _isHasRadixPoint;
     if ([textField isFirstResponder]) {
     _isHasRadixPoint = YES;
     NSString *existText = textField.text;
     if ([existText rangeOfString:@"."].location == NSNotFound) {
     _isHasRadixPoint = NO;
     }
     if (string.length > 0) {
     unichar newChar = [string characterAtIndex:0];
     if ((newChar >= '0' && newChar <= '9') || newChar == '.' ) {
     if (newChar == '.') {
     if (_isHasRadixPoint)
     return NO;
     else
     return YES;
     }else {
     if (_isHasRadixPoint) {
     NSRange ran = [existText rangeOfString:@"."];
     int radixPointCount = range.location - ran.location;
     if (radixPointCount <= 2) return YES;
     else return NO;
     } else
     return YES;
     }
     
     }else {
     if ( newChar == '\n') return YES;
     return NO;
     }
     
     }else {
     return YES;
     }
     }
     return YES;
     */
    if ([textField isFirstResponder])
    {
        NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@".0"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为0或小数点
            NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (firstRange.location != NSNotFound || numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
            // 编辑状态中移动光标后，首个输入不能为0，也不能为小数点
            NSString *firstString = [tempStr substringToIndex:1];
            if ([firstString isEqualToString:@"0"] || [firstString isEqualToString:@"."])
            {
                return NO;
            }
            
            for (int i = 0; i < tempStr.length; i++)
            {
                NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                
                // 只能输入数字和小数点
                NSRange numberRange = [subString rangeOfCharacterFromSet:limitSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 无小数点时，只能输入5个数字
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (pointRange.location == NSNotFound && 6 == tempStr.length)
            {
                return NO;
            }
            
            // 存在小数点时，只能再输入两位小数，不能再输入小数点
            if (pointRange.location != NSNotFound)
            {
                // 只能有一个小数点
                CGFloat limitlength = pointRange.location + pointRange.length;
                NSString *temp = [tempStr substringFromIndex:limitlength];
                NSRange hasPointRange = [temp rangeOfString:@"."];
                if (hasPointRange.location != NSNotFound)
                {
                    return NO;
                }
                
                // 小数点后两位
                if (limitlength + 3 == tempStr.length)
                {
                    return NO;
                }
                
                // 存在小数时点，整数不足五位时，最多只能输入5位
                NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                if (6 == subTemp.length)
                {
                    return NO;
                }
            }
        }
        return YES;
    }
    return YES;
}

/**
 *  动态限制输入金额长度
 *  限制textfild 整数部分最多 stringLength 位，小数位数最多为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string stringLength:(float)stringLength
{
    if ([textField isFirstResponder]) {
        NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@".0"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为0或小数点
            NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (firstRange.location != NSNotFound || numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
            // 编辑状态中移动光标后，首个输入不能为0
            NSString *firstString = [tempStr substringToIndex:1];
            if ([firstString isEqualToString:@"0"] || [firstString isEqualToString:@"."])
            {
                return NO;
            }
            
            for (int i = 0; i < tempStr.length; i++)
            {
                NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                
                // 只能输入数字和小数点
                NSRange numberRange = [subString rangeOfCharacterFromSet:limitSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 无小数点时，只能输数字
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (pointRange.location == NSNotFound && (stringLength+1) == tempStr.length)
            {
                return NO;
            }
            
            // 存在小数点时，只能再输入两位小数，不能再输入小数点
            if (pointRange.location != NSNotFound)
            {
                // 只能有一个小数点
                CGFloat limitlength = pointRange.location + pointRange.length;
                NSString *temp = [tempStr substringFromIndex:limitlength];
                NSRange hasPointRange = [temp rangeOfString:@"."];
                if (hasPointRange.location != NSNotFound)
                {
                    return NO;
                }
                
                // 小数点后两位
                if (limitlength + 3 == tempStr.length)
                {
                    return NO;
                }
                
                // 存在小数时点，整数不足五位时，最多只能输入5位
                NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                if ((stringLength+1) == subTemp.length)
                {
                    return NO;
                }
            }
        }
        return YES;
        
    }
    return YES;
}

// 数字输入限制（自定义位数） 都是整数位
+ (BOOL)limitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number
{
    /** 这个不对，点击返回键删除时，第一位删除不了，第一位输入数字后，后面可以输入其他如英文字符
     if ([textField isFirstResponder])
     {
     NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
     NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
     
     
     DLog(@"tempStr==%@", tempStr);
     if (number >= tempStr.length)
     {
     NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
     if (numberRange.location == NSNotFound)
     {
     return NO;
     }
     
     return YES;
     }
     else
     {
     textField.text = [tempStr substringToIndex:number];
     return NO;
     }
     }
     return YES;
     */
    
    if ([textField isFirstResponder])
    {
        NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@".0"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为0或小数点
            NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (firstRange.location != NSNotFound || numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
            // 编辑状态中移动光标后，首个输入不能为0
            NSString *firstString = [tempStr substringToIndex:1];
            if ([firstString isEqualToString:@"0"] || [firstString isEqualToString:@"."])
            {
                return NO;
            }
            
            for (int i = 0; i < tempStr.length; i++)
            {
                NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                
                // 只能输入数字
                NSRange numberRange = [subString rangeOfCharacterFromSet:limitSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }

//            NSRange pointRange = [tempStr rangeOfString:@"."];
            // 存在小数时点，整数不足五位时，最多只能输入5位
//            NSString *subTemp = [tempStr substringToIndex:pointRange.location];
            
            DLog(@"tempStr==%@", tempStr);
            DLog(@"tempStr.length==%d", tempStr.length);
            if ((number+1) == tempStr.length)
            {
                return NO;
            }
            
            // 无小数点时，只能输数字
//            NSRange pointRange = [tempStr rangeOfString:@"."];
//            if (number == tempStr.length)
//            {
//                return NO;
//            }
//            
//            // 存在小数点时，只能再输入两位小数，不能再输入小数点
//            if (pointRange.location != NSNotFound)
//            {
//                // 只能有一个小数点
//                CGFloat limitlength = pointRange.location + pointRange.length;
//                NSString *temp = [tempStr substringFromIndex:limitlength];
//                NSRange hasPointRange = [temp rangeOfString:@"."];
//                if (hasPointRange.location != NSNotFound)
//                {
//                    return NO;
//                }
//                
//                // 小数点后两位
//                if (limitlength + 3 == tempStr.length)
//                {
//                    return NO;
//                }
//                
//                // 存在小数时点，整数不足五位时，最多只能输入5位
//                NSString *subTemp = [tempStr substringToIndex:pointRange.location];
//                if (length == subTemp.length)
//                {
//                    return NO;
//                }
//            }
        }
        return YES;
        
    }
    return YES;
}

// string to number
+ (NSNumber *)stringToNum:(NSString *)string
{
    return [NSNumber numberWithLongLong:[string longLongValue]];
}

/**
 截取小数点后几位方法 moneyStr：金额字符串 nuberCount：保留小数点后几位不做四舍五入
 如剧情需要可设置基数加100即可 例：102表示保留2位小数 当值为0.00时自动转换为0
 */
+ (NSString *)interceptMoneyString:(NSString *)moneyStr numberCount:(NSInteger)nuberCount
{
    NSArray *floatSpArr = [moneyStr componentsSeparatedByString:@"."];
    // 浮点部分
    NSString *floatPart = [floatSpArr count] > 1 ? floatSpArr[1]: @"0";
    NSString *integerPart = floatSpArr[0];
    BOOL isNeedZero = NO;//是否将0.00转换为0
    if (nuberCount > 100) {
        nuberCount = nuberCount - 100;
        isNeedZero = YES;
    }
    if(floatPart.length > nuberCount){
        floatPart = [floatPart substringToIndex:nuberCount];
    }else if(floatPart.length < nuberCount){
        NSMutableString *addStr = [[NSMutableString alloc]initWithCapacity:0];
        for (int i = 0; i < nuberCount - floatPart.length; i++) {
            [addStr appendString:@"0"];
        }
        floatPart = [NSString stringWithFormat:@"%@%@", floatPart, addStr];
    }
    if(nuberCount > 0){
        moneyStr = [NSString stringWithFormat:@"%@.%@", integerPart, floatPart];
    }else{
        moneyStr = [NSString stringWithFormat:@"%@", integerPart];
    }
    
    if ([integerPart isEqualToString:@"0"] && isNeedZero) {//需要0.00转化为0时，判断数值是否为0
        NSMutableString *addStr = [[NSMutableString alloc]initWithCapacity:0];
        for (int i = 0; i < floatPart.length; i++) {
            [addStr appendString:@"0"];
        }
        if ([floatPart isEqualToString:addStr]) {
            moneyStr = @"0";
        }
    }
    return moneyStr;
}

// 获取当前app版本号
+ (NSString *)getAppCurrentVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *versionString = [NSString stringWithFormat:@"%@", appCurVersion];
    return versionString;
}

/// 获取当前app包名
+ (NSString *)getBundleIdentifier
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleIdentifier"];
}

// 限制textField不能输入的字符
+ (BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return !canChange;
}

@end
