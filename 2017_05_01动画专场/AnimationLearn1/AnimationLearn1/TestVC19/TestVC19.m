//
//  TestVC19.m
//  Animation
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC19.h"

@interface TestVC19 ()

@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TestVC19

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
    [self.view addSubview:self.titleLabel];
//    self.contentStr = @"人生最宝贵的是生命，生命属于人只有一次。一个人的生命应当这样度过：当他回忆往事的时候，他不致因虚度年华而悔恨，也不致因碌碌无为而羞愧；在临死的时候，他能够说：“我的整个生命和全部精力，都已献给世界上最壮丽的事业——为人类的解放而斗争。”";
    
    
    self.contentStr = @"肖茗溪健康成长快乐";
    
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(animationLabel) object:nil];
    [thread start];
    
}

#pragma mark - setter, getter

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 50, 200, 300)];
//        _titleLabel.backgroundColor = [UIColor colorWithRed:1/255.0 green:222/255.0 blue:255.0/255.0 alpha:1.0];
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _titleLabel.text = @"肖茗溪健康成长快乐";
        _titleLabel.textColor = [UIColor redColor];
        
        _titleLabel.textAlignment = NSTextAlignmentJustified;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

#pragma mark - 代理方法

#pragma mark -

- (void)animationLabel
{
    for (NSInteger i = 0; i < self.contentStr.length; i++)
    {
        [self performSelectorOnMainThread:@selector(refreshUIWithContentStr:) withObject:[self.contentStr substringWithRange:NSMakeRange(0, i+1)] waitUntilDone:YES];
        [NSThread sleepForTimeInterval:0.3];
    }
}

- (void)refreshUIWithContentStr:(NSString *)contentStr
{
    self.titleLabel.text = contentStr;
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
