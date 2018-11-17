//
//  TestVC1.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TestVC1

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
    [self.view addSubview:self.webView];
    
    
    //webview加载本地文件，可以使用加载数据的方式
    NSString *path = [[NSBundle mainBundle] pathForResource:@"肖宇龙产品详情接口需求" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    
    //以二进制数据的形式加载沙箱中的文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    //第一个诶参数是一个NSData， 本地文件对应的数据
    //第二个参数是MIMEType
    //第三个参数是编码格式
    
    
    //webView加载docx文件
    [_webView loadData:data MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" textEncodingName:@"UTF-8" baseURL:nil];
    
    //相对地址，一般加载本地文件不使用，可以在指定的baseURL中查找相关文件。
    NSLog(@"getMimeType==%@", [self getMimeType:url]);

    
}

#pragma mark 获取指定URL的MIMEType类型
- (NSString *)getMimeType:(NSURL *)url
{
    //1NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2NSURLConnection
    
    //3 在NSURLResponse里，服务器告诉浏览器用什么方式打开文件。
    
    //使用同步方法后去MIMEType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
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