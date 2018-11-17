//
//  JGGPDF.m
//  封装生成、显示PDF的类
//
//  Created by bz on 16/5/26.
//  Copyright © 2016年 济南博卒软件有限公司. All rights reserved.
//

#import "JGGPDF.h"

@implementation JGGPDF


#pragma mark--返回PDF数据--图片数组--PDF宽--PDF高（单页）
+(void)PDFimages:(NSMutableArray*)imagesmarr PDFw:(NSUInteger)w PDFh:(NSInteger)h PDFName:(NSString*)pdfname
{
//    创建可变的数据
    NSMutableData*pdfData=[NSMutableData data];
//    创建滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    scrollView.contentSize = CGSizeMake(w, h*imagesmarr.count);
    
    int a=0;
    for (UIImage*image in imagesmarr){
        UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, a*h, w, h)];
        imageview.image=image;
        [scrollView addSubview:imageview];
        a++;
    }
    
    UIGraphicsBeginPDFContextToData(pdfData,(CGRect){0,0,scrollView.contentSize},nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0,0,scrollView.contentSize.width,scrollView.contentSize.height),nil);
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    CGRect origSize = scrollView.frame;
    CGRect newSize = origSize;
    newSize.size = scrollView.contentSize;
    [scrollView setFrame:newSize];
    [scrollView.layer renderInContext:pdfContext];
    [scrollView setFrame:origSize];
    UIGraphicsEndPDFContext();
    
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",pdfname]];
    [pdfData writeToFile:fileName atomically:YES];
    NSLog(@"PDF存储路径是 %@",path);
}



#pragma mark--显示PDF文件(本地文件)
+(UIWebView*)PDFname:(NSString*)pdfname PDFx:(NSUInteger)x PDFy:(NSInteger)y PDFw:(NSUInteger)w PDFh:(NSInteger)h
{
    UIWebView*webview=[[UIWebView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",pdfname]];
    
    NSURL *url=[NSURL fileURLWithPath:fileName];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [webview loadRequest:request];
    
    return webview;
}
@end
