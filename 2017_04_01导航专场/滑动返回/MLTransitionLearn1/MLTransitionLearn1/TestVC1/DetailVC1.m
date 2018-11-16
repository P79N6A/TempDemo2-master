//
//  DetailVC1.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "DetailVC1.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"
#import "CommonUtil.h"

#import "MLTransition.h"

@interface DetailVC1 () <UITableViewDelegate, UITableViewDataSource>
{
    // 定时器
    NSTimer * _timer;
}

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) PlayerView *playerView;

/// 定义一个媒体
@property (nonatomic, strong) AVPlayerItem *playerItem;;

/// 播放器
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation DetailVC1

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情Detail1";
    self.view.backgroundColor = [UIColor redColor];
    [self createUI];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 针对这个viewController 打开
    self.view.disableMLTransition = NO;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - 创建UI

- (void)createUI
{
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.playerView;
    
    
    
    
    // 播放网络视频
    NSString *str = @"http://cloud.video.taobao.com/play/u/665026784/p/1/e/6/t/1/41422605.mp4";
    NSURL * url = [NSURL URLWithString:str];
    _playerItem = [[AVPlayerItem alloc] initWithURL:url];
    
    
    
    // 播放本地视频
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"魅力乔布斯之演讲技巧" ofType:@"mp4"];
    ////    NSString *urlPath = [NSString stringWithFormat:@"file:///%@", [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ////    NSURL * url = [NSURL URLWithString:str];
    //    NSURL * url = [NSURL fileURLWithPath:path];
    //    _playerItem = [[AVPlayerItem alloc] initWithURL:url];
    
    
    
    
    //实例化一个带媒体的播放器
    _player = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
    self.playerView.xyPlayer = _player;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEndAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
    
    
    /*
     监听status属性
     
     status有三种状态：
     AVPlayerStatusUnknown,
     AVPlayerStatusReadyToPlay,
     AVPlayerStatusFailed
     当status等于AVPlayerStatusReadyToPlay时代表视频已经可以播放了，
     我们就可以调用play方法播放了
     */
    //    [_item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    /*
     监听loadedTimeRanges属性
     loadedTimeRange属性代表已经缓冲的进度，监听此属性可以在UI中更新缓冲进度，也是很有用的一个属性。
     */
    [_player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - 按钮响应事件

- (void)handlePlayBtnClickAction:(BOOL)startPlay
{
    if (startPlay)
    {
        [_player play];
        
        
        if (_timer == nil)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
        else
        {
            // 开启定时器
            _timer.fireDate = [NSDate distantPast];
        }
        
    }
    else
    {
        [_player pause];
        
        // 关闭定时器
        _timer.fireDate = [NSDate distantFuture];
    }
}

- (void)handleSliderAction:(CGFloat)value
{
    NSLog(@"value==%f", value);
    
    // 除号后面一定不要等于 0
    long long totalSecond = 0;
    if ([CommonUtil compareZeroWith:_playerItem.currentTime.timescale] == biggerThanZero)
    {
        totalSecond = _playerItem.duration.value / _playerItem.duration.timescale;
    }
    
    
    CMTime time = _playerItem.currentTime;
    
    // 计算value
    time.value = value * time.timescale;
    
    
    // 关闭定时器
    _timer.fireDate = [NSDate distantFuture];
    
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        
        
        [_player play];
        // 开启定时器
        _timer.fireDate = [NSDate distantPast];
        
    }];
    
}

- (void)playProgress
{
    CompareZeroResult result = [CommonUtil compareZeroWith:_playerItem.currentTime.timescale];
    long long second = 0;
    if (result == biggerThanZero)
    {
        second = _playerItem.currentTime.value / _playerItem.currentTime.timescale;
    }
    
    // 除号后面一定不要等于 0
    long long totalSecond = 0;
    if ([CommonUtil compareZeroWith:_playerItem.currentTime.timescale] == biggerThanZero)
    {
        totalSecond = _playerItem.duration.value / _playerItem.duration.timescale;
    }
    
    [_playerView refreshPlayerViewWithCurrentTime:second TotalTime:totalSecond];
}

- (void)playToEndAction:(NSNotification *)notefication
{
    NSLog(@"play to end...");
    // 一定要把播放暂停
    [_player pause];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"])
    {
        if ([playerItem status] == AVPlayerStatusReadyToPlay)
        {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            //播放暂停按钮呈现可点击状态
            self.playerView.playBtn.userInteractionEnabled = YES;
            [self.playerView playBtnClick:_playerView.playBtn];
        }
    }
    
    
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        //计算缓冲进度
        
        NSTimeInterval timeInterval = [self availableDuration];
        NSLog(@"缓冲进度timeInterval==%f",timeInterval);
        
        
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        CGFloat f =  timeInterval / totalDuration;
        
        //        _progressSlider.middleValue = f;
        //
    }
}



- (NSTimeInterval ) availableDuration
{
    NSArray *loadedTimeRanges = [[_playerView.xyPlayer currentItem] loadedTimeRanges];
    
    /*
     获取缓冲区域
     */
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
    
}

#pragma mark - 网络请求


#pragma mark - 代理方法

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"时尚";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


#pragma mark - setter, getter

- (PlayerView *)playerView
{
    if (_playerView == nil)
    {
        _playerView = [[PlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, PlayerViewHeight)];
        _playerView.backgroundColor = [UIColor yellowColor];
        
        kSelfWeak;
        _playerView.playBtnCLickBlock = ^(BOOL startPlay){
            kSelfStrong;
            [strongSelf handlePlayBtnClickAction:startPlay];
        };
        
        
        _playerView.sliderValueBlock = ^(CGFloat value){
            kSelfStrong;
            [strongSelf handleSliderAction:value];
        };
    }
    return _playerView;
}

- (UITableView *)mainTableView
{
    if (_mainTableView == nil)
    {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
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
