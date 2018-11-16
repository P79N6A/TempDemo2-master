//
//  DuWenViewController.m
//  BaseProject
//
//  Created by soft on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuWenViewController.h"
#import "DuWenViewModel.h"
#import "DuWenShowViewController.h"
#import "Factory.h"

@interface DuWenViewController ()

@end

@implementation DuWenViewController

+(DuWenViewController *)standard{
    static DuWenViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[DuWenViewController alloc]initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
    });
    return vc;
}

+(UINavigationController *)standatdNavi{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DuWenViewController *vc = [[DuWenViewController alloc]initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}


/** 提供每个VC对应key值的数组 */
+(NSMutableArray *)vcKeys{
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger count = [self itemNames].count;
    for (int i = 0; i < count; i++) {
        [arr addObject:@"type"];
    }
    return [arr copy];
}
/** 提供每个vc对应的values值数组 */
+(NSMutableArray *)vcValues{
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger count = [self itemNames].count;
    for (int i = 0; i < count; i++) {
        [arr addObject:@(i)];
    }
    return [arr copy];
}

/** 提供题目数目 */
+(NSArray *)itemNames{
    return @[@"时事",@"旅游",@"搞笑",@"互联网",@"健康"];
}

/** 提供题目对应的控制器类型 */
+(NSArray *)viewControllerClasses{
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger count = [self itemNames].count;
    for (int i = 0; i < count; i++) {
        [arr addObject:[DuWenShowViewController class]];
    }
    return [arr copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenSeaColor];
    self.title = @"读文";
    [Factory addMenuItemToVC:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
