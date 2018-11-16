//
//  TestVC5.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/6.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC5.h"
#import "TurntableView5.h"

@interface TestVC5 ()

@end

@implementation TestVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    TurntableView5 * turntableView = [[TurntableView5 alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    turntableView.backgroundColor = [UIColor yellowColor];
    turntableView.center = self.view.center;
    
    
    
    
    //呈现一些图片
    UIView  *presentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    
    for (NSInteger i = 0; i < 12; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"bt_%@.png",@(i + 1)];
        UIImage *image=[UIImage imageNamed:imageName];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        imageView.tag = i;
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        
        //将图片的center调到下边中间位置
        imageView.layer.anchorPoint = CGPointMake(0.5, 1);
        imageView.center = presentView.center;
        imageView.layer.transform = CATransform3DMakeRotation(M_PI/6*i, 0, 0, 1);
       
        [presentView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];

        
//        if (i == 2) {
//            imageView.backgroundColor = [UIColor redColor];
//            break;
//        }
        
        
    }
    [turntableView addSubview:presentView];

    
    [self.view addSubview:turntableView];


    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap.view.tag==%@", @(tap.view.tag));
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
