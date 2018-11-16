//
//  TestVC20.m
//  Animation
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC20.h"

@interface TestVC20 ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC20

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)setUI
{
    [self.view addSubview:self.imgView];
    
    [self.view addSubview:self.btn];
}

#pragma mark - setter, getter

- (UIImageView *)imgView
{
    if (_imgView == nil)
    {
        //        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, [UIScreen mainScreen].bounds.size.width-40, 300)];
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,80, 300, 400)];//拖动形式的
        
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.image = [UIImage imageNamed:@"test"];
        _imgView.layer.cornerRadius = 20;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(80, [UIScreen mainScreen].bounds.size.height-120, 40, 40);
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitle:@"变" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma mark - 按钮响应事件

- (void)click:(UIButton *)sender
{
    //    [UIView animateWithDuration:1.0 animations:^{
    //
    //        CATransform3D transform2 = CATransform3DIdentity;
    //        //.m行一定要写在CATransform3DRotate的前面！
    //        transform2.m42 = 1.0/-500; //平移效果
    //        transform2 = CATransform3DRotate(transform2,(M_PI_2/360*20), 0, 1, 0);//旋转角度等
    //        [_imgView.layer setTransform:transform2];
    //        _imgView.frame = CGRectMake(10, 80,300, 400);
    //
    //
    //    } completion:^(BOOL finished) {
    //        _imgView.transform = CGAffineTransformIdentity;//列表View回归到初始角度
    //    }];
    
    
    //从屏幕右边滑动过去
    
    [UIView animateWithDuration:1.0 animations:^{
        CATransform3D transform2 = CATransform3DIdentity;
        //.m行一定要写在CATransform3DRotate的前面！
        transform2.m34 = 1.0/-400; // 透视效果
        transform2 = CATransform3DRotate(transform2,(M_PI/360*20), 1, 0, 1);//旋转角度等
        [_imgView.layer setTransform:transform2];
        _imgView.frame = CGRectMake(360, 80,300, 400);
        
    } completion:^(BOOL finished) {
        _imgView.transform = CGAffineTransformIdentity;//列表View回归到初始角度
    }];
}



#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark -



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
