//
//  QLProductAdView.m
//  趣旅网
//
//  Created by xiaoyulong on 16/6/6.
//  Copyright © 2016年 junjun. All rights reserved.
//

#import "QLProductAdView.h"
#import "FlipView.h"

@interface QLProductAdView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) FlipView *flipView;


//@property (nonatomic, strong) UIView *pageBgView;
//@property (nonatomic, strong) UILabel *pageLabel;



@property (nonatomic, strong) NSMutableArray *imageUrlArr;

@end

@implementation QLProductAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)createUI
{
    [self addSubview:self.scrollView];
    [self addSubview:self.titleView];
    
    [self.titleView addSubview:self.titleLabel];
    [self.titleView addSubview:self.flipView];

}

#pragma mark - 按钮响应事件

- (void)refreshQLProductAdViewWithImageUrlArr:(NSMutableArray *)imageUrlArr
{
    _imageUrlArr = [NSMutableArray arrayWithArray:imageUrlArr];
    
    for (NSInteger i = 0; i < imageUrlArr.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.borderWidth = 1;
        imageView.layer.cornerRadius = 4;
        
        imageView.image = [UIImage imageNamed:@"320×350"];
        
        //        if (_isImageCenterCut)
        //        {
        imageView.contentMode = UIViewContentModeCenter;
        imageView.layer.masksToBounds  = YES;
        [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //        }
        NSString *urlStr = [imageUrlArr objectAtIndex:i];
        
        if ([urlStr hasPrefix:@"http://"])
        {
            // 网络图片 请使用ego异步图片库
            NSURL *imageUrl = [NSURL URLWithString:urlStr];
//            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"320×350"]];
        }else{
            UIImage *img = [UIImage imageNamed:[imageUrlArr objectAtIndex:i]];
            [imageView setImage:img];
        }
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * imageUrlArr.count, 0);
    
    self.flipView.allPage = imageUrlArr.count;
//    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", 1, imageUrlArr.count];
    
}

#pragma mark - 网络请求


#pragma mark - 代理方法
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView)
    {
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
//        self.flipView.curPage = (index+1);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView)
    {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSLog(@"offsetX==%f", offsetX);
        
        NSInteger dada = (NSInteger)offsetX % (NSInteger)self.bounds.size.width;
        NSLog(@"dada==%ld", dada);

        NSInteger page = offsetX / self.bounds.size.width;
        //        NSLog(@"%ld", ii+1);
        if (dada > (self.bounds.size.width/2))
        {
            // 大于半屏幕
            self.flipView.curPage =  page+1+1;
        }
        else
        {
            // 小于半屏幕
            self.flipView.curPage =  page+1;
        }

        
        CGFloat per = offsetX / (self.bounds.size.width);
        NSLog(@"per==%f", per);

        CATransform3D transform3D = CATransform3DIdentity;
        transform3D.m34 = 1.0f / 2500.0f; // 角度值
        self.flipView.layer.transform = CATransform3DRotate(transform3D, per* 1*M_PI, 0, 1, 0);
        [self.flipView flipWithCATransform3D:transform3D Per:per];
    }
}


#pragma mark - setter, getter

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        //        _scrollView.alwaysBounceVertical = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, 0);
    }
    return _scrollView;
}

- (UIView *)titleView
{
    if (_titleView == nil)
    {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
        _titleView.backgroundColor = [UIColor redColor];
    }
    return _titleView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        //        _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _titleLabel.text = @"  产品编号";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (FlipView *)flipView
{
    if (_flipView == nil)
    {
        _flipView = [[FlipView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40,  0, 30, 30)];
        _flipView.backgroundColor = [UIColor clearColor];

    }
    return _flipView;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
