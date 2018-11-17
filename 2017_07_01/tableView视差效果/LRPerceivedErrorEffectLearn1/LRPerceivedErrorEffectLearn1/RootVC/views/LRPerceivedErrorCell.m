//
//  LRPerceivedErrorCell.m
//  LRPerceivedErrorEffectLearn1
//
//  Created by xiaoyulong on 2017/7/10.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "LRPerceivedErrorCell.h"

@interface LRPerceivedErrorCell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *productNameLabel;

@end

@implementation LRPerceivedErrorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.productNameLabel];
}


#pragma mark - 按钮响应事件

- (void)refreshLRPerceivedErrorCell:(NSString *)imageName
{
    self.bgImageView.image = [UIImage imageNamed:imageName];
}

- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view
{
    // 将cell的frame转换成view的Frame(为了获取每个cell的Y值)
    CGRect rect = [tableView convertRect:self.frame toView:view];
    
    NSLog(@"rect==%@", NSStringFromCGRect(rect));
    
    //视图的frame的一半 减去 所看到的每个CellY值(获取滚动的值)
    //以屏幕中心点为0点 获取能看到的每个Cell离中心点得值是多少
    float distanceCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rect);
    NSLog(@"distanceCenter==%@", @(distanceCenter));

    // 图片高度 - cell的高度 (获取图片超出cell高度部分)图片肯定要比cell大，否则不会有视觉差效果
    float difference = CGRectGetHeight(self.bgImageView.frame) - CGRectGetHeight(self.frame);
    NSLog(@"difference==%@", @(difference));

    float imageMove = (distanceCenter / CGRectGetHeight(view.frame)) * difference;
    
    //旧的图片Frame
    CGRect imageRect = self.bgImageView.frame;
    
    //移动
    imageRect.origin.y = imageMove - (difference/2);
    
    //新的图片Frame
    self.bgImageView.frame = imageRect;
    
}


#pragma mark - 网络请求


#pragma mark - 代理方法


#pragma mark - setter, getter

- (UIImageView *)bgImageView
{
    if (_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, LRPerceivedErrorCellHeight + 40*2)];
        _bgImageView.backgroundColor = [UIColor redColor];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UILabel *)productNameLabel
{
    if (_productNameLabel == nil)
    {
        _productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, LRPerceivedErrorCellHeight - 40, 200, 40)];
        _productNameLabel.backgroundColor = [UIColor whiteColor];
        _productNameLabel.font = [UIFont systemFontOfSize:14];
        
        _productNameLabel.textAlignment = NSTextAlignmentLeft;
        _productNameLabel.textColor = [UIColor blackColor];
        _productNameLabel.text = @"我是产品名称啊啊啊啊啊";
    }
    return _productNameLabel;
}

@end
