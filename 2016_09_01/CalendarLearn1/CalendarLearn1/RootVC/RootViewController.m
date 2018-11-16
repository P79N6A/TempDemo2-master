//
//  RootViewController.m
//  CalendarLearn1
//
//  Created by xiaoyulong on 16/9/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "YLWeekView.h"
#import "YLCollectionViewCell.h"
#import "YLCollectionReusableView.h"
#import "NSDate+LYWCalendar.h"

#import "CalendarViewModel.h"
#import "MonthModel.h"
#import "DayModel.h"

#import "DetailVC.h"


static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";


@interface RootViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) YLWeekView *weekView;

//表格视图
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) CalendarViewModel *calendarViewModel;

@end

@implementation RootViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ dealloc...", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;//关闭自动适应
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    self.navigationItem.title = @"Courage2";
    
    _calendarViewModel = [[CalendarViewModel alloc] init];
    
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveAction) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadLocalData];

}

#pragma mark - 创建UI

- (void)createUI
{
//    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.weekView];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.refreshControl = self.refreshControl;
}


#pragma mark - 按钮响应事件

- (void)handleTapAction
{
    NSString *message = [[NSUserDefaults standardUserDefaults] objectForKey:kMessageStr];
    if (message == nil || [message isEqualToString:@""])
    {
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"👌" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)handleFourTapAction
{
    DetailVC *controller = [[DetailVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didBecomeActiveAction
{
    [self loadLocalData];
}

#pragma mark - 网络请求

- (void)loadLocalData
{
    kSelfWeak;
    [_calendarViewModel getCalendarDataWith:^(BOOL isSuccess) {
        kSelfStrong;
        [strongSelf handleCalendarDataAction:isSuccess];
    }];
}

- (void)handleCalendarDataAction:(BOOL)isSuccess
{
    if (isSuccess) {
        [self.refreshControl endRefreshing];
        self.navigationItem.title = [NSString stringWithFormat:@"Courage%@", @(_calendarViewModel.successDayCount)];
        [self.collectionView reloadData];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//            NSLog(@"_calendarViewModel.todayIndexPath==(%d, %d)", _calendarViewModel.todayIndexPath.item, _calendarViewModel.todayIndexPath.section);
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:_calendarViewModel.todayIndexPath.section];
            if (indexPath.section > 0)
            {
                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
            }
        });
    }
}

#pragma mark - 代理方法

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

// 这两个不用说,返回cell个数及section个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section < _calendarViewModel.dataArray.count)
    {
        MonthModel *monthModel = _calendarViewModel.dataArray[section];
        return monthModel.dayArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _calendarViewModel.dataArray.count;
}


// 这里是自定义cell,非常简单的自定义
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID  forIndexPath:indexPath];
    kSelfWeak;
    cell.tapActionBlock = ^{
        kSelfStrong;
        [strongSelf handleTapAction];
    };
    
    cell.fourTapActionBlock = ^{
        kSelfStrong;
        [strongSelf handleFourTapAction];
    };
    
    
    if (indexPath.section < _calendarViewModel.dataArray.count)
    {
        MonthModel *monthModel = _calendarViewModel.dataArray[indexPath.section];
        if (indexPath.item < monthModel.dayArray.count)
        {
            DayModel *dayModel = monthModel.dayArray[indexPath.item];
            [cell refreshYLCollectionViewCellWith:dayModel];
        }
    }
    
    
//    UIView *selectedBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
//    
//    selectedBgView.layer.cornerRadius = kScreenWidth / 7 / 2;
//    selectedBgView.layer.masksToBounds = YES;
//
//    selectedBgView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.6];
//    //设置单击后的颜色
//    cell.selectedBackgroundView = selectedBgView;
    
    return cell;
}

// cell大小及间距
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 7, kScreenWidth / 7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 这里也有个三项判断式,和上面的大同小异,主要是防止12月显示为0月
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        YLCollectionReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        //自定义蓝色
        headerRV.backgroundColor = [UIColor clearColor];
        
        

//        NSDate *currentDate = [[NSDate alloc]init];
//        NSInteger year = ([currentDate month:currentDate] + indexPath.section)/12 + 2017;
//        NSInteger mounth = ([currentDate month:currentDate] + indexPath.section) % 12 == 0 ? 12 : ([currentDate month:currentDate] + indexPath.section)%12;
        
        if (indexPath.section < _calendarViewModel.dataArray.count) {
            MonthModel *monthModel = _calendarViewModel.dataArray[indexPath.section];
            headerRV.dateLabel.text = [NSString stringWithFormat:@"%@", monthModel.titleStr];
        }
//        headerRV.dateLabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,mounth];
        
        return headerRV;
        
    } else {
        return nil;
    }
}

#if 0


// 还是代理,处理选中效果,选中的为黄色
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YLCollectionViewCell *cell = [self collectionView:_collectionView cellForItemAtIndexPath:indexPath];
    
    NSDate *currentDate = [[NSDate alloc]init];
    
    
    
//    打印当前日期

//    if (![cell.dateLabel.text isEqualToString:@""]) {
//        
//        NSInteger year = ([currentDate month:currentDate] + indexPath.section)/12 + 2016;
//        
//        NSInteger mounth = ([currentDate month:currentDate] + indexPath.section)%12;
//        
//        NSInteger day = [cell.dateLabel.text intValue];
//        
//        NSLog(@"%ld年%02ld月%02ld日",year,mounth,day);
//        
//    }
    
    //排除空值cell
    
    //获取月份
    
    NSInteger mounth = ([currentDate month:currentDate] + indexPath.section) % 12 == 0 ? 12 : ([currentDate month:currentDate] + indexPath.section)%12;
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    
    components.month = mounth;
    
    components.year = 2016 + mounth/12;
    
    components.day = 1;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    //获取该月第一天星期几
    
    NSInteger firstDayInThisMounth = [nextDate firstWeekdayInThisMonth:nextDate];
    
    //该月的有多少天daysInThisMounth
    
    NSInteger daysInThisMounth = [nextDate totaldaysInMonth:nextDate];
    
    if ((indexPath.item < firstDayInThisMounth || indexPath.item > daysInThisMounth + firstDayInThisMounth - 1)){
        
        //如果点击空表格则单击无效
        
        [collectionView cellForItemAtIndexPath:indexPath].userInteractionEnabled = NO;
        
        [collectionView reloadData];
        
    }
}


#endif

#pragma mark - setter, getter

- (UIImageView *)bgImageView
{
    if (_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAllHeight - 64)];
        _bgImageView.image = [UIImage imageNamed:@"courage"];
    }
    return _bgImageView;
}

- (YLWeekView *)weekView
{
    if (_weekView == nil)
    {
        _weekView = [[YLWeekView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, YLWeekViewHeight)];
        _weekView.backgroundColor = [UIColor clearColor];
    }
    return _weekView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        // 确定垂直滚动
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        // 头部始终在顶端
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        
        // 头部视图高度
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _weekView.frame.origin.y + _weekView.frame.size.height, kScreenWidth, kAllHeight - (_weekView.frame.origin.y + _weekView.frame.size.height)) collectionViewLayout:flowLayout];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        _collectionView.backgroundView = imageView;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = YES;

        // 注册表格
        [_collectionView registerClass:[YLCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        // 注册头视图
        [_collectionView registerClass:[YLCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        
        // 注册尾视图
        //    [_collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:footerID];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIRefreshControl *)refreshControl
{
    if (_refreshControl == nil)
    {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(loadLocalData) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
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
