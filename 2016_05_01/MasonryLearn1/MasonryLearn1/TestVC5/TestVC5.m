//
//  TestVC5.m
//  MasonryLearn1
//
//  Created by xiaoyulong on 16/7/29.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC5.h"

@interface TestVC5 ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;



@end

@implementation TestVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[UIDevice currentDevice].systemVersion compare:@"7.0"] == NSOrderedDescending)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(20);
        make.height.equalTo(@100.0);
        make.width.equalTo(@50);

        make.center.centerY.equalTo(self.view);
    }];
    
    
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.backgroundColor = [UIColor redColor];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:self.iconImageView];
    
    
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.topLabel.font = [UIFont systemFontOfSize:15];
    self.topLabel.textColor = [UIColor blackColor];
    [view addSubview:self.topLabel];
    
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bottomLabel.textAlignment = NSTextAlignmentLeft;
    self.bottomLabel.font = [UIFont systemFontOfSize:11];
    self.bottomLabel.textColor = [UIColor blackColor];
    [view addSubview:self.bottomLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.leading.equalTo(self.view).offset(15);
         make.top.equalTo(self.view).offset(10);
         make.width.equalTo(@30);
         make.height.equalTo(@30);
         make.bottom.equalTo(self.view).offset(-10);
    }];
    
//    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.equalTo(self.iconImageView);
//         make.leading.equalTo(self.iconImageView.mas_trailing).offset(10);
//         make.trailing.equalTo(self.view);
//         make.height.equalTo(@16);
//    }];
//    
//     [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.equalTo(self.topLabel.mas_bottom).offset(5);
//         make.leading.and.trailing.equalTo(self.topLabel);
//         make.bottom.equalTo(self.iconImageView).offset(2);
//     
//     }];
    
    
    

    
    
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
