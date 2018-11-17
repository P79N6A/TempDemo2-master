//
//  RootViewController.m
//  SocketLearn1
//
//  Created by xiaoyulong on 2018/5/31.
//  Copyright © 2018年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: - 将文件 AsyncSocket 拖进来，
// MARK: —>TARGETS  —> Build Phases —> Compile Sources 中
// MARK: -fno-objc-arc
- (void)demo1
{
    
}


// MARK: - 什么是 Socket？
- (void)demo2
{
    
    /*
     我们已经知道网络中的进程是通过socket来通信的，那什么是socket呢？
     socket起源于Unix，而Unix/Linux基本哲学之一就是“一切皆文件”，都可以用，“打开open –> 读写write/read –> 关闭close”模式来操作。
     我的理解就是Socket就是该模式的一个实现，socket即是一种特殊的文件，一些socket函数就是对其进行的操作（读/写IO、打开、关闭）
     这些函数我们在后面进行介绍。我们在传输数据时，可以只使用（传输层）TCP/IP协议，
     但是那样的话，如果没有应用层，便无法识别数据内容，如果想要使传输的数据有意义，
     则必须使用到应用层协议，应用层协议有很多，比如HTTP、FTP、TELNET等，
     也可以自己定义应用层协议。
     WEB使用HTTP协议作应用层协议，以封装HTTP文本信息，
     然后使用TCP/IP做传输层协议将它发到网络上。
     
     
     1)Socket是一个针对TCP和UDP编程的接口，你可以借助它建立TCP连接等等。而TCP和UDP协议属于传输层。
     而http是个应用层的协议，它实际上也建立在TCP协议之上。
     (HTTP是轿车，提供了封装或者显示数据的具体形式；Socket是发动机，提供了网络通信的能力。)
     2）Socket是对TCP/IP协议的封装，Socket本身并不是协议，而是一个调用接口（API），通过Socket，我们才能使用TCP/IP协议。
     Socket的出现只是使得程序员更方便地使用TCP/IP协议栈而已，
     是对TCP/IP协议的抽象，从而形成了我们知道的一些最基本的函数接口。
     */
    
    
    
    
    /**
     socket连接和http连接的区别
     简单说，你浏览的网页（网址以http://开头)都是http协议传输到你的浏览器的,
     而http是基于socket之上的。socket是一套完成tcp，udp协议的接口。
     
     HTTP协议：简单对象访问协议，对应于应用层  ，HTTP协议是基于TCP连接的
     tcp协议：    对应于传输层
     ip协议：     对应于网络层
     
     TCP/IP是传输层协议，主要解决数据如何在网络中传输；而HTTP是应用层协议，主要解决如何包装数据。
     
     Socket是对TCP/IP协议的封装，Socket本身并不是协议，而是一个调用接口（API），通过Socket，我们才能使用TCP/IP协议。
     http连接：http连接就是所谓的短连接，即客户端向服务器端发送一次请求，服务器端响应后连接即会断掉；
     
     socket连接：socket连接就是所谓的长连接，理论上客户端和服务器端一旦建立起连接将不会主动断掉；
     但是由于各种环境因素可能会是连接断开，比如说：服务器端或客户端主机down了，
     网络故障，或者两者之间长时间没有数据传输，
     网络防火墙可能会断开该连接以释放网络资源。
     所以当一个socket连接中没有数据的传输，那么为了维持连接需要发送心跳消息~~
     具体心跳消息格式是开发者自己定义的
     */
}


// MARK: - 利用Socket建立网络连接的步骤
- (void)demo3
{
    /**
     利用Socket建立网络连接的步骤：
     
     建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket；
     另一个运行于服务端，称为ServerSocket；
     
     套接字的连接过程分为三个步骤：
     1.服务器监听：服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，
     实时监控网络状态，等待客户端的连接请求。
     
     2.客户端请求：指客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。
     为此，客户端的套接字必须首先描述它要连接的服务器的套接字，
     指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。
     
     3.连接确认：当服务器端套接字监听到或者说接收到客户端套接字的连接请求时，
     就响应客户端套接字的请求，建立一个新的线程，
     把服务器端套接字的描述发给客户端，
     一旦客户端确认了此描述，双方就正式建立连接。
     而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。
     */
    
    
    /*
     IM通讯协议（基于TCP/IP和UDP）
     1  A登录 IM服务器纪录A的TCP／UDP端口 ＋ A的ip 地址  A在线
     2  向A的好友列表（存储在IM上）发送A的端口＋IP地址
     3  将A的好友列表 端口＋ip＋在线状态等信息传回登录A的PC 机
     
     IM服务器还提供消息中转服务
     网络好  不中转  点对点通讯
     网络不好   中转（消息先到服务器再到A或者B）
     
     IM通讯方式 xmpp
     1 在线直接通讯   （点对点）
     2 在线代理通讯   （网络情况不好  防火墙 消息先到服务器再转）
     3 离线代理通讯  （服务起保存消息，等你上线  再把消息给你）
     4 扩展方式通讯   （发到手机 ，email,传真）
     */
}


@end
