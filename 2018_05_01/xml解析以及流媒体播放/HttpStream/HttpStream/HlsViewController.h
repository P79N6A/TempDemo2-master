//
//  ViewController.h
//  HttpStream
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HlsViewController : RootController
@property  (nonatomic,strong)  MPMoviePlayerController *player;
@end

