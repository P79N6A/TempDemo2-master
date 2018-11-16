//
//  RootViewController.m
//  HTTP_HTTPS_GET_POST
//
//  Created by xiaoyulong on 16/4/2.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     Http协议：超文本传输协议，面向对象的应用层面的网络传输协议（Web开发）
     主机名：计算机的名字 TC毛
     域名：www.baidu.com
     ip地址：域名映射   类似身份证号码和姓名
     端口：区分服务类型  80 网页浏览器端口  21 FTP端口
     消息报头：请求头＋响应头 （可选）传递参数
     
     Get:理论上用于获取服务器数据
     Get 方法通过 URL 请求来传递用户的数据，将表单内各字段名称与其内容，以成对的字符串连接，比如：http://www.mdm.com/test.asp?name=asd&password=sad
     Get 方式传输的数据量非常小，一般限制在 2 KB 左右
     Get 方式提交数据，会带来安全问题
     
     GET协议
     GET /cgi-bin/get.cgi? SrcLatitude=40.029997&SrcLongitude=116. 346653&DestLatitude=40.032112&DestLon gitude=116.35555 HTTP/1.1 \r\n
     Host: localhost \r\n
     
     
     
     Post：理论上用于上传数据至服务器
     Post 方法通过 HTTP post 机制，将表单内各字段名称与其内容放置在 HTML 表头
     Post 方式传递的数据量相对较大
     出于安全性考虑，建议最好使用 Post 提交数据
     
     
     Post上传表单
     表单属性enctype
     enctype="application/x- www-form-urlencoded".这个属性管理的是表单的编码
     application/x-www-form-urlencoded (默认值)
     上传文本内容，不能用于文件上传
     multipart/form-data
     上传非文本内容（图片，MP3 等等），是上传二进制数据
     
     
     POST1协议
     POST /cgi-bin/post1.cgi HTTP/1.0 \r\n
     Host : localhost \r\n
     Content-Length: 213 \r\n
     Content-Type : application/x-www- form-urlencoded \r\n
     \r\n
     SrcLatitude=40.029997&SrcLongitude=116. 346653&DestLatitude=40.032112&DestLon gitude=116.35555
     
     
     
     POST2 协议multipart/form-data ABC123
     POST /php/upload_pic.php HTTP/1.1 \r\n
     Content-Length : 1234 \r\n
     Content-Type : multipart/form-data; boundary=ABC123 \r\n
     Host : localhost \r\n \r\n
     --ABC123\r\n
     Content-Disposition : form-data; name=“action”\r\n
     \r\n
     upload_pic
     \r\n
     --ABC123\r\n
     Content-Disposition: form-data; name=“pic”; filename=“test.png” \r\n
     Content-Type : image/png \r\n (如果是jpg图片 image/jpeg)
     \r\n
     
     文件的内容放在这个地方
     
     \r\n
     --ABC123\r\n Content-Disposition: form-data;
     name=“desc”\r\n 
     \r\n
     
     我的图片
     
     \r\n
     --ABC123\r\n Content-Disposition: form-data;
     name=“video”; filename=“myvideo.mp4”\r\n Content-Type : video/mp4\r\n
     
     \r\n
     
     Myvideo.mp4二进制内容放在这里
     \r\n 
     --ABC123--\r\n
     
    
     */
    
    
    /**
     HTTP 定义了与服务器交互的不同方法，最常用的有4种，Get、Post、Put、Delete,如果我换一下顺序就好记了，Put（增）,Delete（删），Post（改）,Get（查），即增删改查，下面简单叙述一下：
     1）Get， 它用于获取信息，注意，他只是获取、查询数据，也就是说它不会修改服务器上的数据，从这点来讲，它是数据安全的，而稍后会提到的Post它是可以修改数据的，所以这也是两者差别之一了。
     
     2） Post，它是可以向服务器发送修改请求，从而修改服务器的，比方说，我们要在论坛上回贴、在博客上评论，这就要用到Post了，当然它也是可以仅仅获取数据的。
     
     3）Delete 删除数据。可以通过Get/Post来实现。用的不多，暂不多写，以后扩充。
     
     4）Put，增加、放置数据，可以通过Get/Post来实现。用的不多，暂不多写，以后扩充。
     
     下面简述一下Get和Post区别：
     
     1） GET请求的数据是放在HTTP包头中的，也就是URL之后，通常是像下面这样定义格式的，（而Post是把提交的数据放在HTTP正文中的）。
     
     login.action?name=hyddd&password=idontknow&verify=%E4%BD%E5%A5%BD
     
     a，以 ？ 来分隔URL和数据；
     
     b，以& 来分隔参数；
     
     c，如果数据是英文或数字，原样发送；
     
     d，如果数据是中文或其它字符，则进行BASE64编码。
     
     2）GET提交的数据比较少，最多1024B，因为GET数据是附在URL之后的，而URL则会受到不同环境的限制的，比如说IE对其限制为2K+35，而POST可以传送更多的数据（理论上是没有限制的，但一般也会受不同的环境，如浏览器、操作系统、服务器处理能力等限制，IIS4可支持80KB，IIS5可支持100KB）。
     
     3）Post的安全性要比Get高，因为Get时，参数数据是明文传输的，而且使用GET的话，还可能造成Cross-site request forgery攻击。而POST数据则可以加密的，但GET的速度可能会快些。
     
     所以综上几点，总结成下表：
     
     操作方式
     
     数据位置
     
     明文密文
     
     数据安全
     
     长度限制
     
     应用场景
     
     GET
     
     HTTP包头
     
     明文
     
     不安全
     
     长度较小
     
     查询数据
     
     POST
     
     HTTP正文
     
     可明可密
     
     安全
     
     支持较大数据传输
     
     修改数据
     

     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
