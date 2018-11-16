//
//  TestVC2.m
//  HTTP_HTTPS_GET_POST
//
//  Created by xiaoyulong on 16/4/2.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"

#define BOUNDARY @"ABC12345678"


@interface TestVC2 () <NSURLConnectionDataDelegate>
{
    NSMutableData *_recvData;
    NSURLConnection *_connection;

}
@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC2

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
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)click:(UIButton *)sender
{
//    NSString * s = @"http://119.255.38.178:8088/sns/my/login.php?username=test&password=123456";
//    NSURLRequest  *request = [NSURLRequest requestWithURL:[NSURL URLWithString:s]];
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
    
    //NSString * s = @"http://119.255.38.178/sns/my/upload_headimage.php";
    NSString *str = @"http://119.255.38.178:8088/sns/my/upload_headimage.php";
    
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    str = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY];
    [request addValue:str forHTTPHeaderField:@"Content-Type"];
    
    NSMutableString *bodyString = [NSMutableString string];
    [bodyString appendFormat:@"--%@\r\n", BOUNDARY];
    
    [bodyString appendString:@"Content-Disposition: form-data; name=\"action\"\r\n"];
    [bodyString appendString:@"\r\n"];
    [bodyString appendString:@"upload_pic"];
    [bodyString appendString:@"\r\n"];
    
    [bodyString appendFormat:@"--%@\r\n", BOUNDARY];
    [bodyString appendString:@"Content-Disposition: form-data; name=\"headimage\"; filename=\"test.png\"\r\n"];
    [bodyString appendString:@"Content-Type: image/png\r\n"];
    [bodyString appendString:@"\r\n"];
    
    NSLog(@"bodyString==%@",bodyString);
    
    UIImage *img = [UIImage imageNamed:@"image1"];
    NSData *imgData = UIImagePNGRepresentation(img);
    
    NSMutableData *bodyData = [[NSMutableData alloc] init];
    NSData *bodyStringData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [bodyData appendData:bodyStringData];
    [bodyData appendData:imgData];
    
    NSString *endString = [NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDARY];
    NSData *endData = [endString dataUsingEncoding:NSUTF8StringEncoding];
    [bodyData appendData:endData];
    
    NSString *len = [NSString stringWithFormat:@"%d", [bodyData length]];
    [request addValue:len forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];
    
    //[bodyData release];
    
    
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[request release];
}

#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - NSURLConnectionDataDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _recvData = [[NSMutableData alloc] init];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_recvData appendData:data];
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *s = [[NSString alloc] initWithData:_recvData encoding:NSUTF8StringEncoding];
    NSLog(@"s is %@", s);
//    [s release];
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
