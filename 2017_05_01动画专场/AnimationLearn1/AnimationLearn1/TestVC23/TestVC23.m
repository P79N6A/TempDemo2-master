//
//  TestVC23.m
//  Animation
//
//  Created by yulong on 16/2/16.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC23.h"
#import "GoodCell.h"

@interface TestVC23 () <UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *cartView;

@end

@implementation TestVC23

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
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.cartView];
}

#pragma mark - setter, getter

- (UITableView *)mainTableView
{
    if (_mainTableView == nil)
    {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
}

- (UIView *)cartView
{
    if (_cartView == nil)
    {
        UIImage *image = [UIImage imageNamed:@"shopping_cart.png"];
        _cartView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-image.size.width, [UIScreen mainScreen].bounds.size.height-90-64, image.size.width, image.size.height)];
        _cartView.backgroundColor = [UIColor yellowColor];
        
        UIImageView *cartImageView = [[UIImageView alloc] initWithFrame:_cartView.bounds];
        cartImageView.image = image;
        [_cartView addSubview:cartImageView];
    }
    return _cartView;
}

#pragma mark - 按钮响应事件


/*
 3、Bezier曲线
 关于Bezier曲线，iOS已为我们封装好了生成操作，我们只需要提供控制点便可。为了更好地理解Bezier曲线，为了以后能更好的利用Bezier曲线来创造好看的效果，我们应当学习其原理与生成机制，这里只做简单1提，以后再专门学习记录。。
 由于我们想产生1种类抛物线的动画，所以这里我们需要2阶Bezier曲线便可，所以要提供3个控制点，起始点和终止点都已有了，关键就是中间的控制点。在计图实验中生成Bezier时，我们用的1种思路是以直代曲，用大量短线段来表示1条曲线，每个n阶Bezier曲线（n+1个点）在生成时，总能在n个线段中依照1个比例各找出1个点，而这n个点又能生成1个n⑴阶Bezier，我们的Bezier曲线上的点就是当只有1条线段以后依照那个比例找出的那个点。
 无图无真相，盗图可耻，我干脆摆上1个链接好了偷笑
 Beizer曲线上点的肯定
 
 原理是这样，我们用起来只要略微了解1点，就知道我们缺少的那个控制点就是在起止点之间，但是纵坐标要比这两点“高”很多的1个点。所以可以通过下面的公式得出1个控制点
 
 
 float x = sx + (ex - sx) / 3; float y = sy + (ey - sy) * 0.5 - 400;
 由于该控制点的存在，我们的曲线会从起始点向上抛起然后再落到终点处。这里x、y的算法其实不是固定的，可以自由更改，只要符合上面上的条件并且自己觉得好看就好。
 利用这3个控制点就可以生成1个2阶Bezier曲线，将其作为动画的path属性便可。
 
 http://www.wfuyu.com/technology/21462.html
 */
- (void)makeAnimationWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    
    //get the location of label in table view
    //    NSValue *value = notification.userInfo[@"position"];
    //    CGPoint lbCenter = value.CGPointValue;
    
    //the image which will play the animation soon
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cm_center_discount"]];
    imageView.backgroundColor = [UIColor redColor];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, 20, 20);
    imageView.hidden = YES;
    imageView.center = startPoint;
    
    //the container of image view
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.contents = imageView.layer.contents;
    layer.frame = imageView.frame;
    layer.opacity = 1;
    [self.view.layer addSublayer:layer];
    
    
    //    CGPoint btnCenter = carButton.center;
    //动画 终点 都以sel.view为参考系
    //    CGPoint endpoint = [self.view convertPoint:btnCenter fromView:carBG];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //动画出发点
    [path moveToPoint:startPoint];
    //贝塞尔曲线控制点
    float sx = startPoint.x;
    float sy = startPoint.y;
    float ex = endPoint.x;
    float ey = endPoint.y;
    float x = sx + (ex - sx) / 3;
    float y = sy + (ey - sy) * 0.5 - 400;
    CGPoint centerPoint = CGPointMake(x, y);
    NSLog(@"centerPoint==%@", NSStringFromCGPoint(centerPoint));
    [path addQuadCurveToPoint:endPoint controlPoint:centerPoint];
    
    
    //key frame animation to show the bezier path animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.8;
    animation.delegate = self;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:@"buy"];
    
}

#pragma mark - 网络请求



#pragma mark - 代理方法

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"goodCellID";
    GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[GoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    __weak typeof(self) weakSelf = self;
    cell.addBtnCLickBlock = ^(UIButton *sender){
        
        NSLog(@"sender.center==%@", NSStringFromCGPoint(sender.center));
        CGPoint startPoint = [sender convertPoint:sender.center toView:weakSelf.view];
        
        startPoint = CGPointMake(20, startPoint.y);
        NSLog(@"startPoint==%@", NSStringFromCGPoint(startPoint));
        
        CGPoint endpoint = weakSelf.cartView.center;
        NSLog(@"endpoint=%@", NSStringFromCGPoint(endpoint));
        
        [weakSelf makeAnimationWithStartPoint:startPoint endPoint:endpoint];
    };
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GoodCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row is %lu", indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
