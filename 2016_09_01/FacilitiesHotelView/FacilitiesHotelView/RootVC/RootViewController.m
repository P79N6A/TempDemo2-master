//
//  RootViewController.m
//  FacilitiesHotelView
//
//  Created by xiaoyulong on 16/9/7.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "FacilitiesHotelView.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FacilitiesHotelView *facilitiesHotelView = [[FacilitiesHotelView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, FacilitiesHotelViewHeight)];
    facilitiesHotelView.backgroundColor = [UIColor yellowColor];

    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    [tempArr addObject:@"自由行问题"];
    [tempArr addObject:@"跟团游问题"];
    [tempArr addObject:@"机票相关"];
    [tempArr addObject:@"线路预订"];
    [tempArr addObject:@"支付相关"];
    [tempArr addObject:@"订单相关"];
    [tempArr addObject:@"酒店住宿"];
    [tempArr addObject:@"导游带队"];
    [tempArr addObject:@"订单相关"];

    
    [tempArr addObject:@"自由行问题"];
    [tempArr addObject:@"跟团游问题"];
    [tempArr addObject:@"机票相关"];
    [tempArr addObject:@"线路预订"];
    [tempArr addObject:@"支付相关"];
    

    
    facilitiesHotelView.titleArray = tempArr;
    facilitiesHotelView.frame = CGRectMake(0, 100, kScreenWidth, facilitiesHotelView.defaultHeight);
    [self.view addSubview:facilitiesHotelView];
    
    
    
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
