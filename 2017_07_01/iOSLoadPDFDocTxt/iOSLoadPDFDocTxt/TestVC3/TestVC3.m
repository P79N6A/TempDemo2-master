//
//  TestVC3.m
//  iOSLoadPDFDocTxt
//
//  Created by xiaoyulong on 16/6/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC3.h"
#import <QuickLook/QuickLook.h>

@interface TestVC3 () <QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic,strong) QLPreviewController *previewController;
@property (nonatomic,retain) NSURL *fileURL;

@end

@implementation TestVC3

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
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"附件预览";
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"pdf"];
    _fileURL = [NSURL fileURLWithPath:filePath];

    
    _previewController = [[QLPreviewController alloc] init];
    _previewController.view.backgroundColor = [UIColor yellowColor];
    _previewController.dataSource = self;
    _previewController.delegate = self;
    _previewController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    _previewController.currentPreviewItemIndex = 0;
    // [self addChildViewController:_previewController];
    [self.view addSubview:_previewController.view];
    [_previewController reloadData];

}

#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - QLPreviewControllerDataSource, QLPreviewControllerDelegate
- (id)previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index
{
    return self.fileURL;
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
} 

#pragma mark - setter, getter




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
