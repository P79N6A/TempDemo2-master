//
//  TestVC8.m
//  Animation
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC8.h"

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"

#import "UIImage+GIF.h"


@interface TestVC8 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TestVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self click1];
//    [self click2];
    
//    [self click3];
    
//    [self click4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 加载gif图片, 需要SDWebImage方法
- (void)click1
{
//    downRef.gif
//    loading_gif.gif
    
    UIImage *loading_gif_image = [UIImage imageNamed:@"loading_gif.gif"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, loading_gif_image.size.width, loading_gif_image.size.height)];
    self.imageView.backgroundColor = [UIColor clearColor];
    
    // 1. sd_animatedGIFWithData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loading_gif" ofType:@"gif"];
//    NSString *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loading_gif" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    self.imageView.image = [UIImage sd_animatedGIFWithData:imageData];
    
    // 2. sd_animatedGIFNamed
    // 不要后缀
//    self.imageView.image = [UIImage sd_animatedGIFNamed:@"loading_gif"];
    [self.view addSubview:self.imageView];
    [self.view bringSubviewToFront:self.imageView];

}


#pragma mark - 使用UIWebView播放
- (void)click2
{
    UIImage *loading_gif_image = [UIImage imageNamed:@"loading_gif.gif"];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, loading_gif_image.size.width, loading_gif_image.size.height)];
    webView.backgroundColor = [UIColor yellowColor];
    webView.userInteractionEnabled = NO;//用户不可交互

    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading_gif" ofType:@"gif"]];

    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
}


#pragma mark - 将gif图片分解成多张png图片，使用UIImageView播放
- (void)click3
{
    UIImage *loading_gif_image = [UIImage imageNamed:@"1eagle"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, loading_gif_image.size.width, loading_gif_image.size.height)];
    self.imageView.backgroundColor = [UIColor clearColor];

    //老鹰飞翔
    NSMutableArray *imageArr1 = [NSMutableArray array];

    for (int i = 0; i < 13; i++)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%deagle",i+1]];
        [imageArr1 addObject:img];
    }
    self.imageView.animationImages = imageArr1; //动画图片数组
    self.imageView.animationDuration = 2.0; //执行一次完整动画所需的时长
    self.imageView.animationRepeatCount = 1;  //动画重复次数
    [self.imageView startAnimating];
    [self.view addSubview:self.imageView];
}

#pragma mark - 将gif图片分解成多张png图片，使用UIImageView播放
- (void)click4
{
    UIImage *loading_gif_image = [UIImage imageNamed:@"1eagle"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, loading_gif_image.size.width, loading_gif_image.size.height)];
    self.imageView.backgroundColor = [UIColor clearColor];
    
    //老鹰飞翔
    NSMutableArray *imageArr1 = [NSMutableArray array];
    
    for (int i = 0; i < 13; i++)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%deagle",i+1]];
        [imageArr1 addObject:img];
    }
    
    UIImage *img = [UIImage animatedImageWithImages:imageArr1 duration:2.0];
    self.imageView.image = img;
    [self.view addSubview:self.imageView];
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
