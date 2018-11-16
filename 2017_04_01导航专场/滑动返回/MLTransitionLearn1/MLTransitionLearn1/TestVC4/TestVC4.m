//
//  TestVC4.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC4.h"


@interface TestVC4 () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

/// 搜索栏
@property (nonatomic, strong) UISearchBar *mySearchBar;

/// 搜索控制器
@property (nonatomic, strong) UISearchDisplayController *mySearchDisplayController;


@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    self.navigationItem.title = @"首页4";
    
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.mySearchBar;
    
    /**
     _searchDisplayCtl.searchResultsTableView
     当UISearchDisplayController被初始化时会自带一个tableView（官方封装）
     */
    _mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
    _mySearchDisplayController.searchResultsDelegate = self;
    _mySearchDisplayController.searchResultsDataSource = self;
    _mySearchDisplayController.delegate = self;
    
    _mySearchDisplayController.active = NO;
    

}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"时尚";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        
        // 不隐藏时是什么样子的，PUSH滑动返回时， 一般都会先隐藏的呀
//        [self.searchDisplayController setActive:NO animated:NO];
        
        UIViewController *viewCtl = [[UIViewController alloc] init];
        viewCtl.view.backgroundColor = [UIColor redColor];
        viewCtl.navigationItem.title = @"详情";
        [self.navigationController pushViewController:viewCtl animated:YES];

    }
    
}


#pragma mark - setter, getter

- (UITableView *)mainTableView
{
    if (_mainTableView == nil)
    {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
}

- (UISearchBar *)mySearchBar
{
    if (_mySearchBar == nil)
    {
        _mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _mySearchBar.delegate = self;
        _mySearchBar.placeholder = @"搜索列表";
    }
    return _mySearchBar;
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
