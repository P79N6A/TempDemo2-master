//
//  TestVC1.m
//  HTTP_HTTPS_GET_POST
//
//  Created by xiaoyulong on 16/4/2.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 () <NSURLConnectionDataDelegate>
{
    NSMutableData *_recvData;
    NSURLConnection *_connection;

}

@property (nonatomic, strong) UIButton *btn;

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
    [self.view addSubview:self.btn];
}

#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(100, 100, 100, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(calulateDistance:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma mark - 按钮响应事件

- (void)calulateDistance:(id)sender
{
    // GET方式 http://192.168.1.135/cgi-bin/post1.cgi?SrcLatitude=%@&SrcLongitude=%@&DestLatitude=%@&DestLongitude=%@
    // POST1方式：
    NSString *s = @"http://192.168.1.135/cgi-bin/post1.cgi";
    NSURL *url = [NSURL URLWithString:s];
    
    NSString *srcLatitudeStr = @"";
    NSString *srcLongitudeInputStr = @"";
    NSString *destLatitudeInputStr = @"";
    NSString *destLongitudeInputStr = @"";
    
    
    // 请求体
    NSString *body = [NSString stringWithFormat:
                      @"SrcLatitude=%@&SrcLongitude=%@&DestLatitude=%@&DestLongitude=%@",
                      srcLatitudeStr,
                      srcLongitudeInputStr,
                      destLatitudeInputStr,
                      destLongitudeInputStr];
    NSLog(@"body==%@", body);
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    int bodyLen = [body lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSString *l = [NSString stringWithFormat:@"%d", bodyLen];
    [request addValue:l forHTTPHeaderField:@"Content-Length"];
    NSData *d = [body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:d];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - 网络请求


#pragma mark - 代理方法
#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _recvData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_recvData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *s = [[NSString alloc] initWithData:_recvData encoding:NSUTF8StringEncoding];
    NSLog(@"s is %@", s);
//    distanceLabel.text = s;

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
