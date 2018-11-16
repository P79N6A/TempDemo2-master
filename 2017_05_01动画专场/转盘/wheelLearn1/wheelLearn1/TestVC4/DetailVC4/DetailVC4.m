//
//  DetailVC4.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/8.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DetailVC4.h"
#import "TurntableView4.h"

#define screenW self.view.bounds.size.width

@interface DetailVC4 () <CAAnimationDelegate>

@property (nonatomic,strong) TurntableView4 * turntable;

@property (nonatomic,strong) UILabel * label;
@property (nonatomic,strong) NSString * labelText;

@end

@implementation DetailVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 转盘View
    self.turntable = [[TurntableView4 alloc] initWithFrame:CGRectMake(0, 0, screenW-50, screenW-50)];
    self.turntable.center = self.view.center;
    [self.turntable.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.turntable];
    
    //显示奖励的label
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.turntable.frame)+50, screenW-200, 30)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.label];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimaition
{
    NSInteger turnAngle;
    NSInteger randomNum = arc4random() % 100;//控制概率
    NSInteger turnsNum = arc4random() % 5 + 1;//控制圈数
    
    if (randomNum>=0 && randomNum<20) {//80%的概率 就是0-80
        
        if (randomNum < 40) {
            turnAngle = 0;
        } else {
            turnAngle = 135;
        }
        self.labelText = self.turntable.numberArray[0];
        NSLog(@"抽中了500");
        
    } else if (randomNum>=20 && randomNum<40) {
        
        if (randomNum < 75) {
            turnAngle = 45;
        }else{
            turnAngle = 225;
        }
        self.labelText = self.turntable.numberArray[3];
        NSLog(@"抽中了鲜花");
        
    } else if (randomNum >=40 && randomNum<60) {
        
        turnAngle = 315;
        self.labelText = self.turntable.numberArray[1];
        NSLog(@"抽中了2000");
        
    } else if(randomNum >=60 && randomNum<80){
        
        if (randomNum < 95) {
            turnAngle = 90;
        }else{
            turnAngle = 270;
        }
        self.labelText = self.turntable.numberArray[2];
        NSLog(@"抽中了5000");
        
    }else{
        
        turnAngle = 180;
        self.labelText = self.turntable.numberArray[4];
        NSLog(@"抽中了20000");
    }
    
    //    NSLog(@"randomNum = %ld , angle = %ld , turnsNum = %ld",randomNum,turnAngle,turnsNum);
    CGFloat perAngle = M_PI/180.0;
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
   
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.turntable.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    // 转盘结束后调用，显示获得的对应奖励
    self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",self.labelText];
    
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
