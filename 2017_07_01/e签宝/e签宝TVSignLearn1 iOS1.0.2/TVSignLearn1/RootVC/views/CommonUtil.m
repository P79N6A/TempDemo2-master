//
//  CommonUtil.m
//  weiChat
//
//  Created by xiaoyulong on 16/4/18.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7的系统


#import "CommonUtil.h"
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
//#import "sys/utsname.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation CommonUtil

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

+ (NSString *)sha1:(NSString *)input
{
    const char *ptr = [input UTF8String];
    
    int i =0;
    int len = strlen(ptr);
    Byte byteArray[len];
    while (i!=len)
    {
        unsigned eachChar = *(ptr + i);
        unsigned low8Bits = eachChar & 0xFF;
        
        byteArray[i] = low8Bits;
        i++;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(byteArray, len, digest);
    
    NSMutableString *hex = [NSMutableString string];
    for (int i=0; i<20; i++)
        [hex appendFormat:@"%02x", digest[i]];
    
    NSString *immutableHex = [NSString stringWithString:hex];
    
    return immutableHex;
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    
    // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
    return [addresses count] ? addresses : nil;
}

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text {
    NSUInteger asciiLength = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}


/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
+ (NSString *)genNonceStr
{
    return [[self class] md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length{
    
    if (text==nil) {
        return text;
    }
    
    NSUInteger asciiLength = 0;
    NSUInteger location = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
        if (asciiLength==length) {
            location=i;
            break;
        }else if (asciiLength>length){
            location=i-1;
            break;
        }
        
    }
    
    if (asciiLength<length) { //文字长度小于限制长度
        return text;
        
    } else {
        
        __block NSMutableString * finalStr = [NSMutableString stringWithString:text];
        
        [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             
             //             DLog(@"substring:%@ substringRange:%@  enclosingRange:%@",substring,NSStringFromRange(substringRange),NSStringFromRange(enclosingRange));
             
             if (substringRange.location<=location+1) {
                 NSString *temp=[text substringToIndex:substringRange.location];
                 finalStr=[NSMutableString stringWithString:temp];
                 *stop=YES;
             }
             
         }];
        
        return finalStr;
    }
}

+ (NSString*)getDate:(NSDate*)date withFormat:(NSString*)dataFormat
{
    if (date == nil)
    {
        date = [[NSDate alloc] init];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dataFormat];
    NSString *theDate = [formatter stringFromDate:date];
    return theDate;
}

/// 限制textfild 小数位数为2位
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
        //   NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@".0"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为0或小数点
            //    NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (/*IfirstRange.location != NSNotFound || */numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
            /*
             // 编辑状态中移动光标后，首个输入不能为0
             NSString *firstString = [tempStr substringToIndex:1];
             if ([firstString isEqualToString:@"0"] || [firstString isEqualToString:@"."])
             {
             return NO;
             }
             */
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
            
            // 无小数点时，只能输入6个数字
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (pointRange.location == NSNotFound && 7 == tempStr.length)
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
                
                // 存在小数时点，整数不足五位时，最多只能输入6位
                NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                if (7 == subTemp.length)
                {
                    return NO;
                }
            }
        }
        return YES;
        
    }
    return YES;
}

// 金额输入限制位数，可自定义整数位
+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number
{
    if ([textField isFirstResponder])
    {
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为小数点
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
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
            
            // 无小数点时，只能输入number个数字，0时无限制
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (number != 0)
            {
                if (pointRange.location == NSNotFound && number + 1 == tempStr.length)
                {
                    return NO;
                }
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
                
                // 存在小数时点，整数不足五位时，最多只能输入6位，0时无限制
                if (number != 0)
                {
                    NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                    if (number + 1 == subTemp.length)
                    {
                        return NO;
                    }
                }
            }
        }
        
        return YES;
    }
    return YES;
}

// 金额输入限制（首位不能为0）
+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number shouldBiggerThanOne:(BOOL)bigger
{
    if ([textField isFirstResponder])
    {
        NSCharacterSet *withoutZeroNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"¥" withString:@""];

        
        if (tempStr.length == 1)
        {
            // 首个输入限制
            if (bigger)
            {
                // 不能为0或小数点，即不能小于1
                NSRange numberRange = [tempStr rangeOfCharacterFromSet:withoutZeroNumberSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            else
            {
                // 可以小于1
                NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
        }
        else if (tempStr.length > 1)
        {
            // 如果允许首个数字为0，则第二个数字非0时，或非小数点时，首位自动更新为非0数字 张绍裕 20150722
            NSString *firstString = [tempStr substringWithRange:NSMakeRange(0, 1)];
            NSString *secondString = [tempStr substringWithRange:NSMakeRange(1, 1)];
            if (!bigger && [firstString isEqualToString:@"0"] && ![secondString isEqualToString:@"."])
            {
                textField.text = secondString;
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
            
            // 无小数点时，只能输入number个数字，0时无限制; 如果第一个数字为0，也不让输入
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (number != 0)
            {
                if (pointRange.location == NSNotFound && number + 1 == tempStr.length)
                {
                    return NO;
                }
                
                if (pointRange.location == NSNotFound && [[tempStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
                    return NO;
                }
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
                
                // 存在小数时点，整数不足五位时，最多只能输入6位，0时无限制
                if (number != 0)
                {
                    NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                    if (number + 1 == subTemp.length)
                    {
                        return NO;
                    }
                }
            }
        }
        
        return YES;
    }
    return YES;
}


#pragma mark - 计算高度

+ (CGFloat)heightWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    if (ISIOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineSpacing;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.height) + 0.5;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.height;
    }
}

+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    if (ISIOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.height) + 0.5;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.height;
    }
}

#pragma mark- 单行文字宽度

+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGSize rtSize;
    if (ISIOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.width) + 0.5;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.width;
    }
}

#pragma mark 保存图片到Cache

+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path
{
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.5);
    //    NSString *fullPathToFile  = [self cachesFolderPathWithName:imageName];
    [imageData writeToFile:path atomically:NO];
    //    return fullPathToFile;
}

#pragma mark 从文档目录下获取路径

+ (NSString *)cachesFolderPathWithName:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile  = [cachesDirectory stringByAppendingPathComponent:imageName];
    return fullPathToFile;
    //    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@",imageName]];
}

+ (void)removeCachesFolderAtPath:(NSString *)filePath
{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size
{
    CGSize temSize = CGSizeZero;
    if (MIN(image.size.width, image.size.height) <= size)
    {
        temSize = image.size;
    }
    else if (image.size.width - image.size.height > 0)
    {
        temSize = CGSizeMake(image.size.width*size/image.size.height, size);
    }
    else
    {
        temSize = CGSizeMake(size, image.size.height * size / image.size.width);
    }
    UIGraphicsBeginImageContext(temSize);
    [image drawInRect:CGRectMake(0, 0, temSize.width, temSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark - Random

+ (NSString *)getRandomFileName
{
    NSDate *date = [NSDate date];
    NSString *dateString = [self getDate:date withFormat:@"yyyyMMddHHmmss"];
    int random = [self getRandomNumber:0 to:1000000];
    return [NSString stringWithFormat:@"%@_%06d",dateString,random];
}

// 获取一个随机整数，范围在[from,to），包括from，不包括to
+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

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


/// 唯一字符串
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

/// 获取（周一、周二、周三、周四、周五、周六、周日），包括年月日的整型值都可以获取到的
+ (NSString *)getWeekDayStringWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSLog(@"calendar==%@", calendar);
    
    NSCalendarUnit unitFlags =
    NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay|
    NSCalendarUnitHour|
    NSCalendarUnitMinute|
    NSCalendarUnitSecond|
    NSCalendarUnitWeekday |
    NSCalendarUnitWeekdayOrdinal |
    NSCalendarUnitQuarter |
    NSCalendarUnitWeekOfMonth |
    NSCalendarUnitWeekOfYear |
    NSCalendarUnitYearForWeekOfYear |
    NSCalendarUnitNanosecond |
    NSCalendarUnitCalendar |
    NSCalendarUnitTimeZone;
    
    
    
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
//    NSLog(@"dateComponents==%@", dateComponents);
    
//    NSInteger Era = [dateComponents era];
//    
//    NSInteger year = [dateComponents year];
//    NSInteger month = [dateComponents month];
//    NSInteger day = [dateComponents day];
//    NSInteger hour = [dateComponents hour];
//    NSInteger minute = [dateComponents minute];
//    NSInteger second = [dateComponents second];
//    
//    NSInteger Weekday = [dateComponents weekday];
//    NSInteger weekdayOrdinal = [dateComponents weekdayOrdinal];
//    NSInteger quarter = [dateComponents quarter];
//    NSInteger weekOfMonth = [dateComponents weekOfMonth];
//    NSInteger weekOfYear = [dateComponents weekOfYear];
//    NSInteger yearForWeekOfYear = [dateComponents yearForWeekOfYear];
//    NSInteger nanosecond = [dateComponents nanosecond];
//    //    NSCalendar *calendar = [dateComponents calendar];
//    NSTimeZone *timeZone = [dateComponents timeZone];
    
    
//#if 0
//
//    
//    NSLog(@"Era==%@", @(Era));
//    
//    // 这些都可以获取到的
//    NSLog(@"year==%@", @(year));
//    NSLog(@"month==%@",@(month));
//    NSLog(@"day==%@",@(day));
//    NSLog(@"hour==%@",@(hour));
//    NSLog(@"minute==%@",@(minute));
//    NSLog(@"second==%@",@(second));
//    
//    NSLog(@"Weekday==%@",@(Weekday));
//    
//    // 表示WeekDay在下一个更大的日历单元中的位置。例如WeekDay=3，WeekDayOrdinal=2  就表示这个月的第2个周二。
//    NSLog(@"weekdayOrdinal==%@",@(weekdayOrdinal));
//    
//    NSLog(@"quarter==%@",@(quarter));
//    
//    // 表示当月里面的第几周
//    NSLog(@"weekOfMonth==%@",@(weekOfMonth));
//    // 当年的第几周
//    NSLog(@"weekOfYear==%@",@(weekOfYear));
//    NSLog(@"yearForWeekOfYear==%@",@(yearForWeekOfYear));
//    NSLog(@"nanosecond==%@",@(nanosecond));
//    NSLog(@"timeZone==%@",timeZone);
//    
// #endif   
    
    
    
    // 表示周里面的天 1代表周日 2代表周一 7代表周六
    NSInteger weekDay = [dateComponents weekday];
    
    NSString *weekStr = nil;
    switch (weekDay) {
        case 1:
            weekStr = @"周日";
            break;
        case 2:
            weekStr = @"周一";
            break;
        case 3:
            weekStr = @"周二";
            break;
        case 4:
            weekStr = @"周三";
            break;
        case 5:
            weekStr = @"周四";
            break;
        case 6:
            weekStr = @"周五";
            break;
        case 7:
            weekStr = @"周六";
            break;
            
        default:
            break;
    }
    
    return weekStr;
}

//返回周几的问题
+ (NSString *)getWeekStrWith:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    // 自带的类型
    NSLog(@"weekdaySymbols==%@", dateFormat.weekdaySymbols);
    NSLog(@"%@", dateFormat.shortWeekdaySymbols);
    NSLog(@"%@", dateFormat.standaloneWeekdaySymbols);
    NSLog(@"%@", dateFormat.veryShortWeekdaySymbols);
    NSLog(@"%@", dateFormat.shortStandaloneWeekdaySymbols);
    NSLog(@"%@", dateFormat.veryShortStandaloneWeekdaySymbols);
    
    // 自定义类型赋给
    NSArray *weekdayAry = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    [dateFormat setShortWeekdaySymbols:weekdayAry];
    //    [dateFormat setDateFormat:@"yyyy年eee"];
    [dateFormat setDateFormat:@"eee"];
    
    //    NSDate *date = [NSDate date];
    NSString *srting = [dateFormat stringFromDate:date];
    return srting;
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

+ (NSString *)getDateStrWithDate:(NSDate *)date DateFormatter:(NSString *)dateFormatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = @"";
    [dateFormatter setDateFormat:dateFormatterStr];
    dateString = [dateFormatter stringFromDate:date];
    
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

+ (NSString *)previousDateWithDateStr:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr
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
    timeInterval = timeInterval - 24 * 60 * 60;
    
    // 新的时间
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *newDateStr = [dateFormatter stringFromDate:newDate];
    
    return newDateStr;
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

//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    if (toBeString.length > kMaxLength) {
        textField.text = [toBeString substringToIndex:kMaxLength];
//        [textField resignFirstResponder];
    }
    
}


/**
 两个日期相比较，
 */
+ (NSInteger)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr withFormatterStr:(NSString *)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatterStr;
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending)
    {
        NSLog(@"oneDayStr  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending)
    {
        NSLog(@"oneDayStr is in the past");
        return -1;
    }
    else
    {
        NSLog(@"Both dates are the same");
        return 0;
    }
}

/**
 * 银行卡 卡号分割 4个一组
 */
+ (NSString *)insertSpaceWithBankCardNumber:(NSString *)number
{
    NSMutableString *string = [NSMutableString string];
    for (NSInteger i = 0; i < number.length; i++)
    {
        if (i == 3 || i == 7 || i == 11 || i == 15 || i == 19)
        {
            [string appendString:[NSString stringWithFormat:@"%@ ",[number substringWithRange:NSMakeRange(i, 1)]]];
        }
        else
        {
            [string appendString:[number substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return string;
}


/**
 * 在数字前加上人命币符号
 */
+ (NSString *)insertRMBSymbolWithMoney:(NSString *)money
{
    NSMutableString *string = [NSMutableString string];
    for (NSInteger i = 0; i < money.length; i++)
    {
        if (i == 0)
        {
            [string appendString:[NSString stringWithFormat:@"¥%@",[money substringWithRange:NSMakeRange(i, 1)]]];
        }
        else
        {
            [string appendString:[money substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return string;
}


//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

+ (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}

@end
