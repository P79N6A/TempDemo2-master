//
//  ViewController.m
//  HttpStream
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HlsViewController.h"
#import "CustomCell.h"
#import "Masonry.h"



#define WEIBO_SEARCH @"http://weibo.com/rannie"
#define HTTP_BODY @"wvr=5&"
#define  KEYWINDOW       [UIScreen mainScreen]



@interface HlsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property  (nonatomic,strong)  UITableView* tableview;
@property  (nonatomic,strong)  NSMutableArray* tableDataArray;
@property  (nonatomic,strong)  UIImageView* tvImageView;
@property  (nonatomic,strong)  VideoInfo* currInfo;

@end

@implementation HlsViewController
@synthesize tableview;
@synthesize tableDataArray;
@synthesize tvImageView;
@synthesize currInfo;
@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableDataArray = [NSMutableArray array];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setBackground];
    [self setTitle:@"流媒体播放"];
    
    self.tvImageView = [UIImageView new];
    [tvImageView setImage:[UIImage imageNamed:@"tv.png"]];
    [self.view addSubview:tvImageView];
    [tvImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(-30);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@250);
    }];
    
    
    
    
    
    
    
    CGRect tableViewRect = CGRectMake(0.0, 0.0, 110.0, KEYWINDOW.bounds.size.width);
    self.tableview = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    [self.tableview setBackgroundColor:[UIColor clearColor]];
    tableview.center = CGPointMake(self.view.frame.size.width / 2, KEYWINDOW.bounds.size.height - self.tableview.frame.size.width/2);
    self.automaticallyAdjustsScrollViewInsets = FALSE;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [self.view addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(110, KEYWINDOW.bounds.size.width));
        //make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        //make.top.equalTo(self.view.mas_bottom).with.offset(-210);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_bottom).with.offset(-110/2);
        make.width.mas_equalTo(@110);
        make.height.mas_equalTo(KEYWINDOW.bounds.size.width);
        
    }];
    
    
    
   // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"hls");
    [HttpKit HttpConnectionKit:WEIBO_SEARCH x:@"text/html" dataStr:HTTP_BODY succeed:^(NSArray *array) {
        [self.tableDataArray removeAllObjects];
        [self.tableDataArray addObjectsFromArray:array];
        [self.tableview reloadData];
         NSLog(@"array count = %d",(int)[array count]);
    } err:^(NSArray* array){
        [self.tableDataArray removeAllObjects];
        [self.tableDataArray addObjectsFromArray:array];
        [self.tableview reloadData];
    }];
}

- (UITableViewCell *)tableView :( UITableView *)aTableView cellForRowAtIndexPath :( NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"identifier";
    CustomCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell顺时针旋转90度
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    //UIColor *color = [self.tableDataArray objectAtIndex: indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    
    VideoInfo* info = [self.tableDataArray objectAtIndex: indexPath.row];
    
    [cell setVideoInfo:info];
    
    
    return cell;
}

- (void)playLiveStreaming
{
    NSURL *url = [[NSURL alloc] initWithString:self.currInfo.videoSrc];
    if(self.player)
    {
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.view addSubview:self.player.view];
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    //self.player.moviePlayer.fullscreen = YES;
    [self.player setControlStyle:MPMovieControlStyleDefault];
    [self.player setShouldAutoplay:YES];
    [self.player play];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(movieFinishedCallback:)
     
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
     
                                               object:self.player];
    
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(-20);
        make.width.mas_equalTo(@160);
        make.height.mas_equalTo(@130);
    }];
    CALayer* textLayer1 = self.player.view.layer;
    textLayer1.cornerRadius = 10;
    textLayer1.masksToBounds = YES;
    textLayer1.borderWidth = 1;
    textLayer1.borderColor = [[UIColor blackColor] CGColor];

    //[self.player.view setFrame:CGRectMake(0, 80, 300, 300)];
}

-(void)movieFinishedCallback:(NSNotification*)notify {
    NSLog(@"finish");
    
    MPMoviePlayerController* theMovie = [notify object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                        name:MPMoviePlayerPlaybackDidFinishNotification
     
                                                 object:theMovie];
    [theMovie.view removeFromSuperview];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currInfo = (VideoInfo*)self.tableDataArray[indexPath.row];
    NSLog(@"currInfo.src = %@",currInfo.videoSrc);
    [self playLiveStreaming];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return tableview.frame.size.width/3;
    return 91;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
