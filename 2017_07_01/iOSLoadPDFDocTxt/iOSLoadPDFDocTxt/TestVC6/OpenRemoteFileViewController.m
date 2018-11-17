//
//  OpenRemoteFileViewController.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "OpenRemoteFileViewController.h"

@interface OpenRemoteFileViewController () <UIWebViewDelegate, QLPreviewControllerDataSource, QLPreviewControllerDelegate>
{
    UIWebView *openFileWebView;
    
}
@property (nonatomic, strong) NSURL *fileURL;


@end

@implementation OpenRemoteFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.backgroundColor = [UIColor orangeColor];
    centerBtn.frame = CGRectMake(0, 0, 200, 50);
    centerBtn.center = self.view.center;
    [centerBtn addTarget:self action:@selector(openPDF:) forControlEvents:UIControlEventTouchUpInside];
    [centerBtn setTitle:@"打开一个远程PDF" forState:UIControlStateNormal];
    [self.view addSubview:centerBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openPDF:(UIButton *)sender{
    openFileWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    openFileWebView.delegate = self;
    [openFileWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileURLString]]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSURL *targetURL = [NSURL URLWithString:self.fileURLString];
    
    NSString *docPath = [self documentsDirectoryPath];
    NSString *pathToDownloadTo = [NSString stringWithFormat:@"%@/%@", docPath, [targetURL lastPathComponent]];
    
    NSLog(@"pathToDownloadTo==%@", pathToDownloadTo);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL hasDownLoad= [fileManager fileExistsAtPath:pathToDownloadTo];
    if (hasDownLoad) {
        self.fileURL = [NSURL fileURLWithPath:pathToDownloadTo];
        
        
        QLPreviewController *qlVC = [[QLPreviewController alloc] init];
        qlVC.delegate = self;
        qlVC.dataSource = self;
        [self.navigationController pushViewController:qlVC animated:YES];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            UIImage *image = [self captureScrollView:openFileWebView.scrollView];
//            UIImageWriteToSavedPhotosAlbum(image, self, @selector(completeAction:), NULL);
//        });
    }
    else
    {
        NSURL *targetURL = [NSURL URLWithString:self.fileURLString];
        
        // 这个下载方式是同步的呀大哥
        NSData *fileData = [[NSData alloc] initWithContentsOfURL:targetURL];
        
        
        // Get the path to the App's Documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        
        [fileData writeToFile:[NSString stringWithFormat:@"%@/%@", documentsDirectory, [targetURL lastPathComponent]] atomically:YES];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [openFileWebView loadRequest:request];
        
        
    }
    
    NSLog(@"webViewDidFinishLoad");
}

- (void)completeAction:(id)sender
{
    NSLog(@"completeAction");
}




-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return self.fileURL;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller
{
    NSLog(@"previewControllerWillDismiss");
}


- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    NSLog(@"previewControllerDidDismiss");
}

-(BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id )item
{
    return YES;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView * __nullable * __nonnull)view
{
    return CGRectZero;
}

-(NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0]; 
    return documentsDirectoryPath; 
} 



/**
 截屏UIScrollView 的 contentSize 整个内容
 */
- (UIImage *)captureScrollView:(UIScrollView *)scrollView
{
    /**
     跟随机器的高清截图
     变模糊和失真的问题解决了
     运行后发现，需求基本达到，但是有个问题，转换后的UIImage显示后会变模糊。因此猜测，这个方法适用于iPhone4之前的机型。iPhone4后，由于采用了Retain高清屏，在转换时需要根据屏幕密度做个处理，又到到下面的答案:
     */
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, [UIScreen mainScreen].scale);
    
    
    //截屏 范围scrollView.contentSize
    //    UIGraphicsBeginImageContext(scrollView.contentSize);
    
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    scrollView.contentOffset = CGPointZero;
    //先将它scrollView的frame调大到contentSize的宽度和高度
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    
    [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    //先将它scrollView的frame复原到原来的宽度和高度
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = savedFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
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
