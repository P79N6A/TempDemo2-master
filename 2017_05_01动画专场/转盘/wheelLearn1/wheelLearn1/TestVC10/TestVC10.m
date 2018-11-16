//
//  TestVC10.m
//  wheelLearn1
//
//  Created by xiaoyulong on 2017/6/19.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "TestVC10.h"
#import "CircleImageView.h"

#define RADIUS 100.0
#define PHOTONUM 5
#define PHOTOSTRING @"icon"

#define kTag_100000 (100000)

// 动画持续时间
#define durationTime (1.5)

#define SCALENUMBER 1.25


// 这是 C 语言中的二维数组，数组中的元素是 int 型
int array [PHOTONUM][PHOTONUM] = {
    {0, 1, 2, 3, 4},
    {4, 0, 1, 2, 3},
    {3, 4, 0, 1, 2},
    {2, 3, 4, 0, 1},
    {1, 2, 3, 4, 0}
};


// 这是 C 语言中的数组，数组中的元素是 CATransform3D 型
CATransform3D rotationTransform1[PHOTONUM];

@interface TestVC10 ()
{
    UIImageView *addview;
    NSInteger  currentTag;
}

@end

@implementation TestVC10

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backImageView.image = [UIImage imageNamed:@"icon_bg_image"];
    backImageView.alpha = 0.6;
    [self.view addSubview:backImageView];
    

    
    NSArray *titleArray = [NSArray arrayWithObjects:@"手机银行", @"手机订票", @"影票在线", @"网点地图", @"建行商城", nil];
    
    float centery = self.view.center.y - 50;
    float centerx = self.view.center.x;
    
    for (NSInteger i = 0; i < PHOTONUM; i++)
    {
        float tmpy = centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
        float tmpx = centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
        
        CircleImageView *addview1 = [[CircleImageView alloc] initWithFrame:CGRectMake(0, 0, CircleImageViewWidth, CircleImageViewHeight)];
        NSString *imageName = [NSString stringWithFormat:@"icon%@", @(i)];
        UIImage *image = [UIImage imageNamed:imageName];
        NSString *titleStr = titleArray[i];
        [addview1 refreshCircleImageViewWithImage:image text:titleStr];
        addview1.tag = kTag_100000 + i;
        addview1.center = CGPointMake(tmpx,tmpy);
        [addview1 addTarget:self action:@selector(addview1Click:) forControlEvents:UIControlEventTouchUpInside];
        
        
        rotationTransform1[i] = CATransform3DIdentity;
        
        //float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
        float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3){
            Scalenumber = 0.4;
        }
        
        CATransform3D rotationTransform = CATransform3DIdentity;
        rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
        addview1.layer.transform = rotationTransform;
        [self.view addSubview:addview1];
        
    }
    
    currentTag = kTag_100000;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addview1Click:(CircleImageView *)sender
{
    if(currentTag == sender.tag)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点击" message: @"添加自己的处理" delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    NSInteger index = [self getblank:sender.tag];
    NSLog(@"index==%@", @(index));
    
    for (NSInteger i = 0;i < PHOTONUM; i++)
    {
        UIImageView *imgview = (UIImageView*)[self.view viewWithTag:kTag_100000 + i];
        
        // 改变位置
        [imgview.layer addAnimation:[self moveanimation:kTag_100000+i number:index] forKey:@"position"];

        // 改变大小
        [imgview.layer addAnimation:[self setscale:kTag_100000+i clicktag:sender.tag] forKey:@"transform"];
    }
    
    [self performSelector:@selector(setcurrenttag) withObject:nil afterDelay:durationTime];
    currentTag = sender.tag;
}


- (void)setcurrenttag
{
    for (NSInteger i = 0; i < PHOTONUM; i++ )
    {
        UIImageView *imgview = (UIImageView*)[self.view viewWithTag:kTag_100000+i];
        int j = array[currentTag - kTag_100000][i];
        float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber<0.3)
        {
            Scalenumber = 0.4;
        }
        CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
        imgview.layer.transform=dtmp;
    	//imgview.layer.needsDisplayOnBoundsChange = YES;
    }
}


- (CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
    int i = array[clicktag - kTag_100000][tag - kTag_100000];
    int i1 = array[currentTag - kTag_100000][tag - kTag_100000];
    float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber<0.3)
    {
        Scalenumber = 0.4;
    }
    
//    UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = durationTime;
    animation.repeatCount =1;
    
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - kTag_100000],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - kTag_100000],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //imgview.layer.transform=dtmp;
    
    return animation;
}

- (CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
    // CALayer
    UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
    CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
    
    NSInteger p =  [self getblank:tag];
    NSLog(@"旋转%d",p);
    
    float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    float h = f + 2.0*M_PI *num/PHOTONUM;
    float centery = self.view.center.y - 50;
    float centerx = self.view.center.x;
    float tmpy =  centery + RADIUS*cos(h);
    float tmpx =	centerx - RADIUS*sin(h);
    imgview.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = durationTime;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced";
    return animation;
}


- (NSInteger)getblank:(NSInteger)tag
{
    if (currentTag > tag)
    {
        return currentTag - tag;
    }
    else
    {
        return PHOTONUM  - tag + currentTag;
    }
}

-(void)Scale
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];
    
    /*
     + (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
     + (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
     + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
     + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
     + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
     + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
     + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
     + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
     */
    
    CATransform3D rotationTransform = CATransform3DIdentity;
    
    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);
    //rotationTransform = CATransform3DScale (rotationTransform, 0.1,0.1, 2);
    //self.view.transform=CGAffineTransformMakeScale(2,2);
    
    self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];	
    [UIView commitAnimations];
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
