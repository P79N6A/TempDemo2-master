//
//  RootViewController.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"还缺哪些接口" ofType:@"txt"];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *data = [fileHandle readDataToEndOfFile];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"打印文本数据：%@",text);
    
    [self.view addSubview:self.webView];
    
    
    //webView加载txt文件
    [_webView loadData:data MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:nil];
    
    
    
    
}

#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    // new for memory cleanup
    [[NSURLCache sharedURLCache] setMemoryCapacity: 0];
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    
    NSLog(@"webViewDidStartLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}

#pragma mark - setter, getter

- (UIWebView *)webView
{
    if (_webView == nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        _webView.backgroundColor = [UIColor clearColor];
        
        // opaque意思的不透明，等于NO就是透明
        _webView.opaque = NO;
        // 页面滚动弹跳
        _webView.scrollView.bounces = YES ;
        
        //        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;

    }
    return _webView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
