
_mapView.showsUserLocation = YES
 在iOS 8以上开启定位功能时出现提示：
 Trying to start MapKit location updates without prompting for location authorization. Must call -[CLLocationManager requestWhenInUseAuthorization] or -[CLLocationManager requestAlwaysAuthorization] first.
 并且不进入代理方法CLLocationManagerDelegate。
 用XCode 6编译的原来XCode 5.1.1写的程序时，发现原来写的CLLocationManager定位的代码以及MKmapView的showUserLocation失效。
 查了一下，XCode 6选用iOS 8 SDK编译app的话，需要调用CLLocationManage 的requestAlwaysAuthorization 方法。
 
 操作步骤如下：
 
 1. 在AppDelegate的didFinishLaunchingWithOptions:方法中 [self.window makeKeyAndVisible]; 之后添加以下代码
 
 CLLocationManager *locationManager = [[CLLocationManager alloc] init];
 // 判斷是否 iOS 8
 if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
 [locationManager requestAlwaysAuthorization]; // 永久授权
 [locationManager requestWhenInUseAuthorization]; //使用中授权
 }
 [locationManager startUpdatingLocation];
 
 2. 在 info.plist里加入：
 NSLocationWhenInUseUsageDescription，允许在前台获取GPS的描述
 NSLocationAlwaysUsageDescription，允许在后台获取GPS的描述

//NSLocationAlwaysUseUsageDescription


加 NSLocationWhenInUseUsageDescription
NSLocationAlwaysUsageDescription 和  两个String字段，value可以为空，也可以设置YES，
不过我得问题还是不能解决，最终还是找到得了问题所在，
就是info.plist中还需要包含Supported interface orientations 这个Array字段。然后运行就解决了


