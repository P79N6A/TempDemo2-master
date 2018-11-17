//
//  RootViewController.m
//  LRPerceivedErrorEffectLearn1
//
//  Created by xiaoyulong on 2017/7/10.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "LRPerceivedErrorCell.h"


@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollViewDidScroll:nil];
}


#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.mainTableView];
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求

- (void)loadData
{
    for (NSInteger i = 0; i < 8; i++)
    {
        [self.dataArray addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    
    [self.mainTableView reloadData];
}

#pragma mark - 代理方法

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取表视图的可见单元格。(可见的视图)
    NSArray *visibleCells = [self.mainTableView visibleCells];
    
    for (LRPerceivedErrorCell *cell in visibleCells) {
        //可见视图设置->背景图片y值
        [cell cellOnTableView:self.mainTableView  didScrollView:self.view];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    LRPerceivedErrorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[LRPerceivedErrorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        // 超出部分不显示
        cell.clipsToBounds = YES;
    }
    
    if (indexPath.row < self.dataArray.count) {
        NSString *imageName = self.dataArray[indexPath.row];
        [cell refreshLRPerceivedErrorCell:imageName];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LRPerceivedErrorCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - setter, getter

- (UITableView *)mainTableView
{
    if (_mainTableView == nil)
    {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _mainTableView.rowHeight = LRPerceivedErrorCellHeight;

        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
