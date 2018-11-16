//
//  QLPopView.m
//  趣旅网
//
//  Created by xiaoyulong on 16/5/27.
//  Copyright © 2016年 junjun. All rights reserved.
//

#import "QLPopView.h"

@interface QLPopView () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/// 弹出视图frame
@property (nonatomic, assign) CGRect         popRect;

@property (nonatomic, strong) NSMutableArray *imageArray;       // 图像
@property (nonatomic, strong) NSMutableArray *titleArray;       // 标题
@property (nonatomic, strong) UIImageView    *bgImageView;      //
//@property (nonatomic, strong) UIImage        *bgroundImage;     // 弹出视图的背景图片
@property (nonatomic, strong) UITableView    *popTableView;


@end

@implementation QLPopView

- (instancetype)initWithFrame:(CGRect)frame andPopViewFrame:(CGRect)popFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.popRect = popFrame;
        
        [self addSubview:self.bgImageView];
        [self addSubview:self.popTableView];
        
        
        [UIView animateWithDuration:0.2 animations:^{
            _bgImageView.frame = CGRectMake(self.popRect.origin.x, self.popRect.origin.y, self.popRect.size.width, self.titleArray.count * QLPopCellHeight+ 8);
            _popTableView.frame = CGRectMake(self.popRect.origin.x, self.popRect.origin.y+9, self.popRect.size.width, self.titleArray.count * QLPopCellHeight-3);
        } completion:^(BOOL finished) {
        }];
        
    }
    return self;
}

#pragma mark - 创建UI



#pragma mark - setter, getter

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil)
    {
        _titleArray = [[NSMutableArray alloc] init];
        [_titleArray addObject:@"首页"];
        [_titleArray addObject:@"搜索"];
        [_titleArray addObject:@"足迹"];
    }
    return _titleArray;
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil)
    {
        _imageArray = [[NSMutableArray alloc] init];
        [_imageArray addObject:@"pop_home"];
        [_imageArray addObject:@"pop_search"];
        [_imageArray addObject:@"pop_zuji"];
    }
    return _imageArray;
}

- (UITableView *)popTableView
{
    if(_popTableView == nil)
    {
        _popTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.popRect.origin.x, self.popRect.origin.y+9, self.popRect.size.width, 0) style:UITableViewStylePlain];
        _popTableView.delegate = self;
        _popTableView.dataSource = self;
        _popTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _popTableView.backgroundColor = [UIColor clearColor];
        _popTableView.scrollEnabled = NO;
        //        _popTableView.estimatedRowHeight = cusPopCellHeight;
        //        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        //        {
        //            _popTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //        }
    }
    return _popTableView;
}

- (UIImageView *)bgImageView
{
    if(_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.popRect.origin.x, self.popRect.origin.y, self.popRect.size.width, 0)];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
        _bgImageView.image = [[UIImage imageNamed:@"pop_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 40)];
    }
    return _bgImageView;
}


#pragma mark - 按钮响应事件

- (void)makePopViewDisappear
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
        _bgImageView.frame = CGRectMake(self.popRect.origin.x, self.popRect.origin.y, self.popRect.size.width, 0);
        _popTableView.frame = CGRectMake(self.popRect.origin.x, self.popRect.origin.y+9, self.popRect.size.width, 0);
        
    } completion:^(BOOL finished) {
        if (_popViewDisappearBlock)
        {
            _popViewDisappearBlock();
        }
    }];
}

#pragma mark - 网络请求


#pragma mark - 代理方法

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *myTouch = [touches anyObject];
    CGPoint curPoint = [myTouch locationInView:self];
    //    DLog(@"curPoint==%@", NSStringFromCGPoint(curPoint));
    //    DLog(@"self.bgImageView.frame==%@", NSStringFromCGRect(self.bgImageView.frame));
    
    if (CGRectContainsPoint(self.bgImageView.frame, curPoint))
    {
        // 点到pop上了
    }
    else
    {
        [self makePopViewDisappear];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CusPopOverCellId";
    QLPopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[QLPopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row < self.titleArray.count && indexPath.row < self.imageArray.count)
    {
        NSString *title = self.titleArray[indexPath.row];
        NSString *imageName = self.imageArray[indexPath.row];
        [cell refreshQLPopCellWithTitle:title imageName:imageName bgImageViewFrame:self.bgImageView.frame];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return QLPopCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_selectPopItemAtIndexBlock)
    {
        _selectPopItemAtIndexBlock(indexPath.row);
    }
    
    [self makePopViewDisappear];
    
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
