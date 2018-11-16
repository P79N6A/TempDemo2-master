//
//  DuWenDetailViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/17.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenDetailViewController.h"
#import "Factory.h"
@interface DuWenDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation DuWenDetailViewController

-(instancetype)initWithPicURL:(NSURL *)picURL URL:(NSURL *)url newsTitle:(NSString *)newstitle{
    if (self = [super init]) {
        self.newstitle = newstitle;
        self.url = url;
        self.picURL = picURL;
    }
    return self;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [UIWebView new];
        [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self showProgress];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideProgress];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hideProgress];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addBackItemToVc:self];
    [Factory addCollectItemToVC:self newsPicURL:self.picURL newsURL:self.url newsTitle:self.newstitle];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
//    [Factory addBackItemToVc:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
