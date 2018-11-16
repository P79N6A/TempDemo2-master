//
//  RootViewController.m
//  UILabel
//
//  Created by xiaoyulong on 16/5/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "TTTAttributedLabel.h"
#import "AttributedTableViewCell.h"


@interface RootViewController () <TTTAttributedLabelDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *espressos;

@property (nonatomic, strong) UITableView *mainTableView;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"espressos" ofType:@"txt"];
    self.espressos = [[NSString stringWithContentsOfFile:filePath usedEncoding:nil error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    [self.view addSubview:self.mainTableView];
}

#pragma mark - setter, getter

- (UITableView *)mainTableView
{
    if (_mainTableView == nil)
    {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = [UIColor yellowColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.espressos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    
//    cell.textLabel.text = @"时尚";
//    return cell;
    
    static NSString *CellIdentifier = @"Cell";
    
    AttributedTableViewCell *cell = (AttributedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[AttributedTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *description = [self.espressos objectAtIndex:(NSUInteger)indexPath.row];
    cell.summaryText = description;
    cell.summaryLabel.delegate = self;
    cell.summaryLabel.userInteractionEnabled = YES;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath
{
    return [AttributedTableViewCell heightForCellWithText:[self.espressos objectAtIndex:(NSUInteger)indexPath.row]
                                           availableWidth:CGRectGetWidth(tableView.frame)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSString *description = [self.espressos objectAtIndex:(NSUInteger)indexPath.row];
//    DetailViewController *viewController = [[DetailViewController alloc] initWithEspressoDescription:description];
//    [self.navigationController pushViewController:viewController animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url {
    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label didLongPressLinkWithURL:(__unused NSURL *)url atPoint:(__unused CGPoint)point {
    [[[UIAlertView alloc] initWithTitle:@"URL Long Pressed"
                                message:@"You long-pressed a URL. Well done!"
                               delegate:nil
                      cancelButtonTitle:@"Woohoo!"
                      otherButtonTitles:nil] show];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
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
