//
//  AppDelegate.m
//  romantic
//
//  Created by xiaoyulong on 16/6/22.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "TestVC1.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    
    
    /**
     基本赞同卧云, 但是表述稍有问题，h264是编码方式，flv是文件格式，flv也可以采用h264编码的。
     更为准确的是：
     访问视频网站会根据浏览器User Agent判断你的设备，而输出不同的html。如果是iOS则视频为MP4或者HTTP LIVE STREAMING (TS)格式，并非flv。
     在PC上，就是flash player + flv/f4v/mp4 的方式了。
     
     通过修改电脑浏览器UserAgent伪装iOS设备访问视频网站防广告是很多人都知道的方法。
     
     作者：深蓝加菲
     链接：https://www.zhihu.com/question/20242453/answer/14461209
     来源：知乎
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     
     优酷支持html 5架构.
     iOS不支持Flash.
     Flash可以嵌入代码的形式使其符合html 5的标准，以支持不同的平台浏览.
     例：
     <object type="movie-flash" data="movie.swf" width="x" height="y">
     <param name="movie" value="movie.swf" /> .
     
     作者：玮隶
     链接：https://www.zhihu.com/question/20242453/answer/14457107
     来源：知乎
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     
     
     SWF是flash格式，苹果的IOS系统不支持，任何播放器都打不开，死心吧，
     FLV是一种视频格式，比较偏门，
     你需要把FLA用转换器转成MP4，MOVE这样的格式，
     苹果的IOS系统随便个播放器就能打开了
     
     */
    
    
    
    /**
     作者：姚冬
     链接：https://www.zhihu.com/question/42162310/answer/93858266
     来源：知乎
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     视频直播，可以分为 采集，前处理，编码，传输，解码，渲染 这几个环节，下面分别说下：
     
     采集，iOS是比较简单的，Android则要做些机型适配工作，PC最麻烦各种奇葩摄像头驱动，出了问题特别不好处理，建议放弃PC只支持手机主播，目前几个新进的直播平台都是这样的。
     
     前处理，现在直播美颜已经是标配了，80%的主播没有美颜根本没法看。美颜算法需要用到GPU编程，需要懂图像处理算法的人，没有好的开源实现，要自己参考论文去研究。难点不在于美颜效果，而在于GPU占用和美颜效果之间找平衡。GPU虽然性能好，但是也是有功耗的，GPU占用太高会导致手机发烫，而手机发烫会导致摄像头采集掉帧，iPhone6尤其明显，因为iPhone6的CPU和前置摄像头很近。
     
     编码，肯定要采用硬编码，软编码720p完全没希望，勉强能编码也会导致CPU过热烫到摄像头。硬编码兼容性又是一个大坑，android上要有人去填。编码要在分辨率，帧率，码率，GOP等参数设计上找到最佳平衡点。
     
     传输，自己做不现实，交给CDN服务商吧，也就是贵了点，相信有志于做直播平台改变世界的你不差钱。假设2W PCU大约每月带宽费用100万左右，因为清晰流畅的720p要1.5mbps左右。CDN只提供了带宽和服务器间传输，发送和接收端的网络连接抖动缓冲还是要自己写的。不想要卡顿，必然要加大缓冲，会导致延迟高，延迟高影响互动性，要做权衡。
     
     解码，也肯定要硬解码，目前手机普遍支持硬解了，只是android上还是有兼容性大坑要填。
     
     渲染，这个难点不在于绘制，而在于音画同步，目前几个直播做得都不好。
     
     此外音频还有几个坑要填，比如降噪，音频编码器的选择，各种蓝牙耳机，各种播放模式的适配等，如果你想做主播和观众连线聊天，还有个回声消除问题。
     
     以上是媒体模块，还有信令控制，登录、鉴权、权限管理、状态管理等等，各种应用服务，消息推送，聊天，礼物系统，支付系统，运营支持系统，统计系统等。
     
     后台还有数据库，缓存，分布式文件存储，消息队列，运维系统等。
     
     这些显然不是一个程序员能解决的，如果真的有这样的高手，请联系我，无论你现在薪水多少，我都出两倍。
     
     第一期至少要融资2000万RMB，组建至少10人的技术团队，10人的产品运营团队，争取3个月产品上线，半年达到5W在线（2w 根本不够）然后融资1个亿，或许还有希望一搏。
     
     也许有人对带宽问题存疑，请参考欢聚时代15年四季度财报，带宽成本为人民币1.611亿元，折合每月5000+万，当然不能用这个数去推算在线人数，因为YY采购量很大所以带宽平均成本低，而且YY不只是高清直播，还有很大比例的500kbps左右码率的直播，还有相当一部分带宽是靠P2P解决的。总之带宽非常贵。
     
     祝你朋友好运。
     */
    
    
    TestVC1 *root = [[TestVC1 alloc] init];
    self.window.rootViewController = root;

    
    // MARK: - 放烟花啦
//    RootViewController *root = [[RootViewController alloc] init];
//    self.window.rootViewController = root;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
