//
//  DuWenShowViewController.m
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenShowViewController.h"
#import "DuWenNoPicCell.h"
#import "DuWenLeftPicCell.h"
#import "DuWenBottonPicCell.h"
#import "DuWenViewModel.h"
#import "DuWenImageView.h"
#import "iCarousel.h"//视图切换效果
#import "DuWenDetailViewController.h"
#import "Factory.h"

@interface DuWenShowViewController ()<iCarouselDelegate,iCarouselDataSource,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)DuWenViewModel *duwenVM;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation DuWenShowViewController

{
    iCarousel *_ic;
    UIPageControl *_pageControl;
    UILabel *_titleLb;//headerView底部label
    NSTimer *_timer;//时间选择器
}
/** 头部滚动视图 */
-(UIView *)headerView{
    [_timer invalidate];
    
    if (!self.duwenVM.bannar) {
        return nil;
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kWindowW/750*500)];
    //添加底层视图
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    bottomView.alpha = 0.3;
    [headView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    _titleLb = [UILabel new];
    [bottomView addSubview:_titleLb];
    _titleLb.numberOfLines = 2;
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-60);
        make.centerY.mas_equalTo(0);
    }];
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = self.duwenVM.bannar.items.count;
    [bottomView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.width.mas_greaterThanOrEqualTo(20);
        make.width.mas_lessThanOrEqualTo(60);
        make.left.mas_equalTo(_titleLb.mas_right).mas_equalTo(-10);
    }];
    _titleLb.text = [self.duwenVM headTitleForRow:0];
    //添加滚动栏
    _ic = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.mas_top).mas_equalTo(0);
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    //如果只有一张图，怎不显示圆点和滚动
    _pageControl.hidesForSinglePage = YES;
    _ic.scrollEnabled = self.duwenVM.bannar.items.count != 1;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //广告效果 
    if (self.duwenVM.bannar.items.count > 1) {
        _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];        } repeats:YES];
    }
    //小圆点 不能与用户交互
    _pageControl.userInteractionEnabled = NO;
    return headView;
}
#pragma mark -iCarousel Delegate
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.duwenVM.bannar.items.count;
}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/750*500-35)];
        DuWenImageView *imageView = [DuWenImageView new];
        [view addSubview:imageView];
        imageView.tag = 100;
        imageView.contentMode = 2;
        view.clipsToBounds = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    DuWenImageView *imageView = (DuWenImageView *)[view viewWithTag:100];
    [imageView.imageView setImageWithURL:[self.duwenVM headPicForRow:index] placeholderImage:nil];
    return view;
}
/** 允许循环滚动 */
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
/** 监控当前滚到第几个 */
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _titleLb.text = [self.duwenVM headTitleForRow:carousel.currentItemIndex];
    _pageControl.currentPage = carousel.currentItemIndex;
}

-(DuWenViewModel *)duwenVM{
    if (!_duwenVM) {
        _duwenVM = [[DuWenViewModel alloc]initWithType:self.type OldTimestamp:0];
    }
    return _duwenVM;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[DuWenNoPicCell class] forCellReuseIdentifier:@"NoCell"];
        [_tableView registerClass:[DuWenLeftPicCell class] forCellReuseIdentifier:@"LeftCell"];
        [_tableView registerClass:[DuWenBottonPicCell class] forCellReuseIdentifier:@"BottomCell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.duwenVM refreshDataCompletionHandle:^(NSError *error) {
                _tableView.tableHeaderView = [self headerView];
                [_tableView.mj_header endRefreshing];
                [_tableView reloadData];
            }];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _tableView.tableHeaderView = [self headerView];
            [self.duwenVM getMoreDataCompletionHandle:^(NSError *error) {
                [_tableView.mj_footer endRefreshing];
                [_tableView reloadData];
            }];
            
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.duwenVM.rowNumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cellindex = [self.duwenVM cellTypeForRow:indexPath.row];
//    NSLog(@"%ld",cellindex);
//    102图在最下面 120图在左边 103无图
    if (cellindex == 101) {
        return nil;
    }
    else if (cellindex == 103) {//无图
        DuWenNoPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoCell"];
        cell.titileLabel.text = [self.duwenVM titleForRow:indexPath.row];
        cell.hotLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.duwenVM hotForRow:indexPath.row]];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",[self.duwenVM timeForRow:indexPath.row]];
        return cell;
    }
    else if (cellindex == 120){//图在左边
        DuWenLeftPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
        [cell.picImageView.imageView setImageWithURL:[self.duwenVM imgUrlForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"nodata"]];

        cell.titileLabel.text = [self.duwenVM titleForRow:indexPath.row];
        cell.hotLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.duwenVM hotForRow:indexPath.row]];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",[self.duwenVM timeForRow:indexPath.row]];

        return cell;
    }
    else{//图在下边
        DuWenBottonPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BottomCell"];
        if ([self.duwenVM hotForRow:indexPath.row] == 0) {
            [cell.picImageView.imageView setImage:[UIImage imageNamed:@"loading"]];
            return cell;
        }
        
        cell.titileLabel.text = [self.duwenVM titleForRow:indexPath.row];
        cell.hotLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.duwenVM hotForRow:indexPath.row]];
        [cell.hotImageView.imageView setImage:[UIImage imageNamed:@"thermometer_25x20"]];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",[self.duwenVM timeForRow:indexPath.row]];
        [cell.picImageView.imageView setImageWithURL:[self.duwenVM imgUrlForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"nodata1"]];
        return cell;
    }
}
/** 去掉左分割线缝隙 */
kRemoveCellSeparator

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DuWenDetailViewController *vc = [[DuWenDetailViewController alloc]initWithPicURL:[self.duwenVM imgUrlForRow:indexPath.row] URL:[self.duwenVM detailURLForRow:indexPath.row] newsTitle:[self.duwenVM titleForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

/** 滚动栏被选中 */
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    DuWenDetailViewController *vc = [[DuWenDetailViewController alloc]initWithPicURL:[self.duwenVM headPicForRow:index] URL:[self.duwenVM headURLForRow:index] newsTitle:[self.duwenVM headTitleForRow:index]];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
