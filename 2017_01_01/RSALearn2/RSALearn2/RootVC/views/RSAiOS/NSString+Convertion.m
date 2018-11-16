//
//  NSString+HexData.m
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "NSString+Convertion.h"

@implementation NSString (Convertion)

- (NSData *)hexData
{
    if (self == nil)
    {
        return nil;
    }

    if(self.length == 0)
    {
        return nil;
    }
    
    //字符串必须是16进制描述也就是必须是0-9,A-F,这里不做检查，我们假设他是按照要求来的。
    if (self.length % 2 == 1)
    {
        return nil;    //必须是偶数,且长度必须大于
    }
    

    int len = self.length / 2;
    unsigned char *result = malloc(len);
    unsigned char *t = result;
    if (result == NULL)
    {
        return nil;
    }
    
    
    for (NSInteger i = 0; i < self.length; i+=2)
    {
        int h = [self characterAtIndex:i] - 48;
        int l = [self characterAtIndex:i+1] - 48;
        
        if (h >= 17 && h <= 22)
        {
            h -= 7;   //大写A-F
        }
        else if (h >= 49 && h <= 54)
        {
            h -= 39;  //小写a-f
        }
        else if (h >= 0 && h <=9)
        {
            h -= 0;
        }
        else
        {
            free(result);  //不正确格式
            return nil;
        }
            
        
        if (l >= 17 && l <= 22)
        {
            l -= 7;
        }
        else if (l >= 49 && l <= 54)
        {
            l -= 39;
        }
        else if (l >= 0 && l <= 9)
        {
            l -= 0;
        }
        else
        {
            free(result);
            return nil;
        }
        
        
        *t = ((h << 4) & 0xF0) + (l & 0x0F);
        
        t = t+1;
    }
    
    
    return [NSData dataWithBytesNoCopy:result length:len];
}


@end
