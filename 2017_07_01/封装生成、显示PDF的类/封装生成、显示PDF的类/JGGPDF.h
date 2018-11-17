//
//  JGGPDF.h
//  封装生成、显示PDF的类
//
//  Created by bz on 16/5/26.
//  Copyright © 2016年 济南博卒软件有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JGGPDF : NSObject

#pragma mark--返回PDF数据--图片数组--PDF宽--PDF高（单页)--PDF文件名
+(void)PDFimages:(NSMutableArray*)imagesmarr PDFw:(NSUInteger)w PDFh:(NSInteger)h PDFName:(NSString*)pdfname;

#pragma mark--显示PDF文件(本地文件)--文件名--文件x--文件y--文件宽--文件高
+(UIWebView*)PDFname:(NSString*)pdfname PDFx:(NSUInteger)x PDFy:(NSInteger)y PDFw:(NSUInteger)w PDFh:(NSInteger)h;

@end
