//
//  RootViewController.m
//  threeDTouchLearn2
//
//  Created by xiaoyulong on 2017/5/27.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

#import "DemoCollectionViewCell.h"

//详情页
#import "PreVC.h"


// UIViewControllerPreviewingDelegate 遵循预览协议
@interface RootViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UICollectionView       *collectionView;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: - 2、 在代码里面添加，这种叫动态标签
// MARK: 但是它也是有一个缺点，就是直接 app 装上后运行过一次，才能唤出3d touch手势，第一种是装上就能。
- (void)demo1
{
    /**
     1.判断 iOS系统为 9.0以上，添加 addThreeDTouchItems
     可以使用系统自带的图标，也可以自己添加图标，但是要切好放在项目中 Assets 或者 mainBundle 都行。
     
     2.在  performActionForShortcutItem  方法中拦截点击事件。
     
     
     3.需要注意的是，快捷启动按钮最多只能添加 4 个。
       最新的 iOS 10 系统会给所有的 App 额外添加一个 3D Touch 分享按钮，点击后不打开 App 而是调用系统分享该应用的 App Store 下载地址。所以我们没有必要再快捷启动按钮中添加分享按钮的了。
     */
    
    
    /*
     iOS 为 App 添加 3D Touch 快捷访问菜单
     http://www.jianshu.com/p/28cb171fc667
     
     
     */
}


#pragma mark - 创建UI

- (void)createUI
{
    
}


#pragma mark - 按钮响应事件


#pragma mark - 网络请求


#pragma mark - 代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PreVC *preViewController = [[PreVC alloc]init];
    preViewController.currentPage = indexPath.item;
    
    [self.navigationController pushViewController:preViewController animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
    
    //设置代理
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        cell.previewingDelegate = self;
    }
    
    
    return cell;
}


#pragma mark - UIViewControllerPreviewingDelegate
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    // 打开详情页触发
    if (viewControllerToCommit){
        [self showViewController:viewControllerToCommit sender:self];
    }
}
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    // 1.我们可以通过触控的location获取 当前点击的是第几个元素(位于collectionview)
    // 2.由于响应3dtouch事件的view是cell的contentView,我们对触控拿到的location要进行一个转换(相对于collectionview(父视图)来说的位置
    // 3.这里通过previewingContext中sourceView获取到触摸的view
    
    UIView *contentView = previewingContext.sourceView;
    
    // 看回"2" 中第一句话,我们要拿到这个触控的location位于collectionview中的位置
    CGPoint iLocation = [contentView convertPoint:location toView:self.collectionView];
    // 将 获取到的位置 通过collectionview获取indexPath
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:iLocation];
    

    
    
    PreVC *preViewController = [[PreVC alloc]init];
    
    // 展现出来的大小
    preViewController.preferredContentSize = CGSizeMake(0, 300);
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 40);
    previewingContext.sourceRect = rect;

    
    preViewController.currentPage = indexPath.item;
    
    return preViewController;
}


#pragma mark - setter, getter

- (UICollectionView *)collectionView{
    if (!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        layout.itemSize = CGSizeMake(200, 100);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"cells"];
    }
    return _collectionView;
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
