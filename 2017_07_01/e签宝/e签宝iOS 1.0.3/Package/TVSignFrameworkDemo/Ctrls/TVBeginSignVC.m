//
//  TVBeginSignVC.m
//  TVSignFrameworkDemo
//
//  Created by wz on 16/5/11.
//  Copyright © 2016年 Timevale. All rights reserved.
//

#import "TVBeginSignVC.h"
#import <TVSignFramework/TVSignFramework.h>

@interface TVBeginSignVC () <TVSignProtocol> {
}

@property (weak, nonatomic) IBOutlet UIImageView *sealImageView;
@property (weak, nonatomic) IBOutlet UISwitch *needPortrait;

@end

@implementation TVBeginSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self performSelector:@selector(createFingerSign) withObject:nil afterDelay:0.8];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击开始签署
- (IBAction)beginSign:(id)sender {
    
    self.accountUid = @"xxxxx";
    if(_needPortrait.isOn) {
        [TVSignFramework tvSignCtrlWithType:TVSignCtrlTypePortraitFirst ctrl:self accountUid:self.accountUid signProtocol:self];
    }
    else {
        [TVSignFramework tvSignCtrlWithType:TVSignCtrlTypeDefault ctrl:self accountUid:self.accountUid signProtocol:self];
    }
}

#pragma mark - TVSignProtocol
- (void)didSignCancel:(NSString*)_accountUid {
    NSLog(@"cancel sign");
}

- (void)didSignBackImage:(NSString*)_accountUid sealImage:(UIImage*)_sealImage {
    self.sealImageView.image = _sealImage;
    NSLog(@"back images");
}

@end
