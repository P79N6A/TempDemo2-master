//
//  TestVC9.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC9.h"
#import "Masonry.h"

const static CGFloat ANIM_TIME = 5.0; // 动画时间
const static CGFloat ROTATION_EXTEND = 20; // 旋转圈数延长 // 2 * M_PI = 1圈
const static NSInteger ITEM_COUNT = 14; // 转盘等比分割

@interface TestVC9 ()
{
    UIAlertView *alert;
    
    Boolean isCW; // 是否顺时针
    float random; // 位置，demo中从0开始
    float orign; // 角度
}

/** 旋转的位置 */
@property (nonatomic, strong) UISegmentedControl *segmentedItem;
/** 旋转的方向 */
@property (nonatomic, strong) UISegmentedControl *segmentedDirection;
/** 提示文本 */
@property (nonatomic, strong) UILabel *lblResult;
/** 底盘 */
@property (nonatomic, strong) UIImageView *imgRound;
/** 指针 */
@property (nonatomic, strong) UIButton *btnIndex;

@end

@implementation TestVC9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 添加控件 */
- (void) addView {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"大转盘";
    
    NSArray *arrayItem = [[NSArray alloc]initWithObjects:@"指针旋转", @"底盘旋转",nil];
    _segmentedItem = [[UISegmentedControl alloc]initWithItems:arrayItem];
    _segmentedItem.selectedSegmentIndex = 0;
    [_segmentedItem addTarget:self action:@selector(segmentedValueChanged) forControlEvents:UIControlEventValueChanged];
    _segmentedItem.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_segmentedItem];
    
    NSArray *arrayDirection = [[NSArray alloc]initWithObjects:@"逆时针", @"顺时针", nil];
    _segmentedDirection = [[UISegmentedControl alloc]initWithItems:arrayDirection];
    _segmentedDirection.selectedSegmentIndex = 0;
    [_segmentedDirection addTarget:self action:@selector(segmentedDirectionValueChanged) forControlEvents:UIControlEventValueChanged];
    _segmentedDirection.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_segmentedDirection];
    
    _lblResult = [UILabel new];
    _lblResult.textAlignment = NSTextAlignmentCenter;
    _lblResult.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_lblResult];
    
    _imgRound = [UIImageView new];
    _imgRound.image = [UIImage imageNamed:@"round"];
    _imgRound.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_imgRound];
    
    _btnIndex = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnIndex setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [_btnIndex addTarget:self action:@selector(btnIndexClick) forControlEvents:UIControlEventTouchUpInside];
    _btnIndex.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_btnIndex];
    
    int padding = 10;
    
    [_segmentedItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(padding * 5);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [_segmentedDirection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedItem.mas_bottom).offset(padding);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [_lblResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedDirection.mas_bottom).offset(padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(25);
    }];
    
    [_imgRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblResult.mas_bottom).offset(padding * 2);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [_btnIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_imgRound);
    }];
}

/** 改变选择位置 */
- (void) segmentedValueChanged {
    orign = 0.0;
    _lblResult.text = @"";
    
    [_btnIndex.imageView.layer removeAllAnimations];
    [_imgRound.layer removeAllAnimations];
    
    _btnIndex.imageView.transform = CGAffineTransformMakeRotation(0);
    _imgRound.transform = CGAffineTransformMakeRotation(0);
}

/** 改变选择方向 */
- (void) segmentedDirectionValueChanged {
    isCW = _segmentedDirection.selectedSegmentIndex == 1;
    [self segmentedValueChanged];
}

/** 点击事件 */
- (void) btnIndexClick {
    _btnIndex.userInteractionEnabled = NO;
    
    [self getResult];
    
}

/** 模拟从服务器请求结果 */
- (void) getResult {
    // 产生随机数，作为停止项
    // 这里从0开始 0-ITEM_COUNT-1
    random = (arc4random() % ITEM_COUNT);
    
    _lblResult.text = [NSString stringWithFormat:@"停止项=%.0lf", random];
    
    if (_segmentedItem.selectedSegmentIndex == 0) {
        [self beginIndexRotate];
        
    } else {
        [self beginRoundRotate];
    }
}

/** 开始旋转-指针 */
- (void) beginIndexRotate {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (isCW) {
        [anim setFromValue:[NSNumber numberWithFloat:M_PI * orign]];
        orign = random / ITEM_COUNT * 2;
        [anim setToValue:[NSNumber numberWithFloat:M_PI * (ROTATION_EXTEND + orign)]];
        
    } else {
        [anim setFromValue:[NSNumber numberWithFloat:-M_PI * orign]];
        orign = 2 - random / ITEM_COUNT * 2;
        [anim setToValue:[NSNumber numberWithFloat:-M_PI * (ROTATION_EXTEND + orign)]];
        
    }
    anim.duration = ANIM_TIME;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [anim setDelegate:self];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [_btnIndex.imageView.layer addAnimation:anim forKey:@"rotation"];
}

/** 开始旋转-底盘 */
- (void) beginRoundRotate {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (isCW) {
        [anim setFromValue:[NSNumber numberWithFloat:M_PI * orign]];
        orign = 2 - random / ITEM_COUNT * 2;
        [anim setToValue:[NSNumber numberWithFloat:M_PI * (ROTATION_EXTEND + orign)]];
        
    } else {
        [anim setFromValue:[NSNumber numberWithFloat:-M_PI * orign]];
        orign = random / ITEM_COUNT * 2;
        [anim setToValue:[NSNumber numberWithFloat:-M_PI * (ROTATION_EXTEND + orign)]];
        
    }
    anim.duration = ANIM_TIME;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [anim setDelegate:self];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [_imgRound.layer addAnimation:anim forKey:@"rotation"];
}

/** 动画开始 */
- (void)animationDidStart:(CAAnimation *)anim {
    _btnIndex.userInteractionEnabled = NO;
    _segmentedItem.userInteractionEnabled = NO;
    _segmentedDirection.userInteractionEnabled = NO;
}

/** 动画结束 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _btnIndex.userInteractionEnabled = YES;
    _segmentedItem.userInteractionEnabled = YES;
    _segmentedDirection.userInteractionEnabled = YES;
    
    if (!alert) {
        alert = [[UIAlertView alloc]initWithTitle:nil
                                          message:@""
                                         delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil, nil];
    }
    
    alert.message = [NSString stringWithFormat:@"你抽中%.0lf", random];
    [alert show];
    
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
