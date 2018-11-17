//
//  ViewController.m
//  封装生成、显示PDF的类
//
//  Created by bz on 16/5/26.
//  Copyright © 2016年 济南博卒软件有限公司. All rights reserved.
//

#import "ViewController.h"
#import "JGGPDF.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)baocun:(id)sender {
    UIImage*image1=[UIImage imageNamed:@"1.jpg"];
    UIImage*image2=[UIImage imageNamed:@"1.jpg"];
    UIImage*image3=[UIImage imageNamed:@"3.jpg"];
    UIImage*image4=[UIImage imageNamed:@"1.jpg"];
    UIImage*image5=[UIImage imageNamed:@"1.jpg"];
    UIImage*image6=[UIImage imageNamed:@"3.jpg"];
    UIImage*image7=[UIImage imageNamed:@"1.jpg"];
    UIImage*image8=[UIImage imageNamed:@"1.jpg"];
    UIImage*image9=[UIImage imageNamed:@"3.jpg"];
    NSMutableArray*marr=[[NSMutableArray alloc]init];
    [marr addObject:image1];
    [marr addObject:image2];
    [marr addObject:image3];
    [marr addObject:image4];
    [marr addObject:image5];
    [marr addObject:image6];
    [marr addObject:image7];
    [marr addObject:image8];
    [marr addObject:image9];
    
//    [JGGPDF PDFimages:marr PDFw:1024 PDFh:768 PDFName:@"123"];
    
    
    
    [JGGPDF PDFimages:marr PDFw:320 PDFh:568 PDFName:@"123"];

}

- (IBAction)xianshi:(id)sender
{
    UIWebView *webview1 = [JGGPDF PDFname:@"123" PDFx:0 PDFy:100 PDFw:800 PDFh:600];
    webview1.scalesPageToFit = YES;
    [self.view addSubview:webview1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
