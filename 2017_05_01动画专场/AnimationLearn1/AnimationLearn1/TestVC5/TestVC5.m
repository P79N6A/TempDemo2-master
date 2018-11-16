//
//  TestVC5.m
//  UIViewAnimation
//
//  Created by yulong on 15/10/16.
//  Copyright © 2015年 HuiXin. All rights reserved.
//

#import "TestVC5.h"
#import "DetailVC5.h"



@interface TestVC5 ()

@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UIView *view2;


@end

@implementation TestVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view1];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_view2];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
    
    
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            int temp = 4*i+j;
            
            UIButton * b = [UIButton buttonWithType:UIButtonTypeSystem];
            b.tag = temp;
            b.frame = CGRectMake(80*j, 50+100*i, 70, 30);
            b.layer.borderColor = [UIColor whiteColor].CGColor;
            b.layer.borderWidth = 2.0;
            b.tintColor = [UIColor whiteColor];
            [b setTitle:[NSString stringWithFormat:@"%d",temp] forState:UIControlStateNormal];
            [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:b];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click:(UIButton *) myBtn
{
    CATransition *transition = [CATransition animation];
    transition.duration = 2.0;
    
    /*
     1.动画类型 typeArr中得四个 和  privateTypeArr 的八个  选出一个
     
     fade     //交叉淡化过渡(不支持过渡方向)
     push     //新视图把旧视图推出去
     moveIn   //新视图移到旧视图上面
     reveal   //将旧视图移开,显示下面的新视图
     
     
     cube     //立方体
     oglFlip  //上下左右翻转效果
     suckEffect   //收缩，如一块布被抽走(不支持过渡方向)
     rippleEffect //滴水(不支持过渡方向)
     pageCurl     //向上翻页
     pageUnCurl   //向下翻页
     cameraIrisHollowOpen  //相机镜头打开(不支持过渡方向)
     cameraIrisHollowClose //相机镜头关上(不支持过渡方向)
     
     2.动画方向 directionTypeArr 的四个 选出一个
     
     
     两个配合使用
     */
    NSArray * typeArr = @[kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal];
    //写成这样也行
    //    NSArray *typeArr = @[@"fade",@"moveIn",@"push",@"reveal"];
    
    
    /**
     私有的动画类型好像不让上线
     */
    
    NSArray * privateTypeArr = @[@"cube",
                                 @"suckEffect",
                                 @"oglFlip",
                                 @"rippleEffect",
                                 @"pageCurl",
                                 @"pageUnCurl",
                                 @"cameraIrisHollowOpen",
                                 @"cameraIrisHollowClose"];
    
    
    //动画方向
    NSArray *directionTypeArr = @[kCATransitionFromBottom,kCATransitionFromLeft,kCATransitionFromRight,kCATransitionFromTop];
    
    NSLog(@"tag is %@", @(myBtn.tag));
    
    if (myBtn.tag >= 0 && myBtn.tag <= 3)
    {
        transition.type = typeArr[myBtn.tag];
        
    }
    else if (myBtn.tag >= 4 && myBtn.tag <= 7)
    {
        transition.type = privateTypeArr[myBtn.tag-4];
    }
    else if (myBtn.tag >= 8 && myBtn.tag <= 11)
    {
        transition.type = privateTypeArr[myBtn.tag-4];
    }
    
    
    transition.subtype = directionTypeArr[2];
    
    
    /* 添加动画
     * 是添加在layer上的
     * 如果是UIButton的话，就
     * UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     * [b.layer addAnimation:transition forKey:nil];
     */
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}

- (void)rightClick
{
    DetailVC5 *detail = [[DetailVC5 alloc] init];
    CATransition *transition = [CATransition animation];
    transition.duration = 2.0;
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:@"dad"];
    [self.navigationController pushViewController:detail animated:YES];
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
