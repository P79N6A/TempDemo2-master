//
//  FacilitiesHotelView.m
//  FacilitiesHotelView
//
//  Created by xiaoyulong on 16/9/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "FacilitiesHotelView.h"
#import "FacilitiesHotelItem.h"

// 方框宽度
#define kItemWidth ( (kScreenWidth - 20.0) / 4)

// 方框高度
#define itemHeight (40.0)

// 离屏幕左边 右边 间隔
#define kPadding (10.0)

#define kTag_360000 (360000)


@interface FacilitiesHotelView ()

@property (nonatomic, strong) UIView *itemsBgView;

@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) FacilitiesHotelItem *tempItem;

@end

@implementation FacilitiesHotelView

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
    [self addSubview:self.itemsBgView];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    for (UIView *view in self.itemsBgView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    _itemArray = [[NSMutableArray alloc] init];
    
    
    for (NSInteger i = 0; i < titleArray.count; i++)
    {
        NSString *titleStr = titleArray[i];
        
        FacilitiesHotelItem *item = [[FacilitiesHotelItem alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, itemHeight)];
        item.tag = kTag_360000 + i;
        
//        item.layer.borderColor = UIColorMake(153, 153, 153, 1).CGColor;
//        item.layer.borderWidth = WIDT05;
        
//        item.titleName = titleStr;
//        item.imageName = imageNameArray[i];
//        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.itemsBgView addSubview:item];
        
        [_itemArray addObject:item];
        
        if (i == 0)
        {
            item.frame = CGRectMake(kPadding, 0, kItemWidth, itemHeight);
        }
        else
        {
            self.tempItem = _itemArray[i-1];
            item.frame = CGRectMake(CGRectGetMaxX(self.tempItem.frame) + 0, self.tempItem.frame.origin.y, kItemWidth, itemHeight);
            
            if ((item.frame.origin.x+item.frame.size.width) > (kScreenWidth-10))
            {
                // 越界了
                item.frame = CGRectMake(kPadding, self.tempItem.frame.origin.y+self.tempItem.frame.size.height + 0, kItemWidth, itemHeight);
            }
        }
        
        //  第一列 左边线不隐藏，其他都隐藏
        if (i % 4 == 0)
        {
            item.leftLine.hidden = NO;
        }
        else
        {
            item.leftLine.hidden = YES;
        }
        
        // 第一行 顶部线不隐藏，其他都隐藏
        if (i < 4)
        {
            item.topLine.hidden = NO;
        }
        else
        {
            item.topLine.hidden = YES;
        }
        
    }
    
    FacilitiesHotelItem *item = [_itemArray lastObject];
    self.itemsBgView.frame = CGRectMake(0, 0, kScreenWidth, item.frame.origin.y + item.frame.size.height);
}


- (CGFloat)defaultHeight
{
    if (_itemArray.count > 0)
    {
        FacilitiesHotelItem *item = [_itemArray lastObject];
        return item.frame.origin.y + item.frame.size.height;
    }
    return self.itemsBgView.frame.origin.y + self.itemsBgView.frame.size.height;
}

- (UIView *)itemsBgView
{
    if (_itemsBgView == nil)
    {
        _itemsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _itemsBgView.backgroundColor = [UIColor clearColor];
        _itemsBgView.userInteractionEnabled = YES;
    }
    return _itemsBgView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
