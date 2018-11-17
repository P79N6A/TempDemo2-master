//
//  AppDelegate+TestVC.m
//  UserInfoLearn1
//
//  Created by xiaoyulong on 17/3/20.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "AppDelegate+TestVC.h"


@implementation AppDelegate (TestVC)

- (void)setupTestRootVC
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    // MARK: - AsyncSocket是 MRC的（-fno-objc-arc）， 文件直接拖到工程中，
    [array addObject:@"RootViewController"];
    
    
    // MARK: - Socket TCP
    [array addObject:@"TestVC1"];

    
    // MARK: - Socket TCP
    [array addObject:@"TestVC2"];
    
    
    // MARK: - Socket TCP
    [array addObject:@"TestVC3"];


    // MARK: - Socket UDP
    [array addObject:@"TestVC4"];

    
    // MARK: - Socket UDP
    [array addObject:@"TestVC5"];

    
    
    
    
    [self makeControllerWith:array];
}

- (void)makeControllerWith:(NSArray *)array
{
    NSString *clsName = array[0];
    
    
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = array.count-1; i >= 0; --i)
//    {
//        [mArray addObject:array[i]];
//    }
//    NSString *clsName = mArray[61];
    
    
    
    Class class = NSClassFromString(clsName);
    
    UIViewController *rootVC = [[class alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootVC.navigationItem.title = NSStringFromClass(rootVC.classForCoder);
    rootVC.edgesForExtendedLayout = UIRectEdgeNone;
    rootVC.automaticallyAdjustsScrollViewInsets = NO;
    rootVC.extendedLayoutIncludesOpaqueBars = NO;
    self.window.rootViewController = nav;
    
}


@end



