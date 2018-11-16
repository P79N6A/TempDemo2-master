//
//  RootViewController.m
//  threeDTouchLearn1
//
//  Created by xiaoyulong on 2017/5/27.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
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


// MARK: - 1.静态标签
// MARK: 由于放在了 plist 文件中，所以写死了，更改的话只能修改plist文件然后再发布版本。
- (void)demo1
{
    /**
     1.静态标签
     打开我们项目的plist文件，添加如下项（选择框中并没有，需要我们手工敲上去）
     
     UIApplicationShortcutItems：数组中的元素就是我们的那些快捷选项标签。
     
     UIApplicationShortcutItemTitle：标签标题（必填）
     
     UIApplicationShortcutItemType：标签的唯一标识 （必填）
     
     UIApplicationShortcutItemIconType：使用系统图标的类型，如搜索、定位、home等（可选）
     
     UIApplicationShortcutItemIcon File：使用项目中的图片作为标签图标 （可选）
     
     UIApplicationShortcutItemSubtitle：标签副标题 （可选）
     
     UIApplicationShortcutItemUserInfo：字典信息，如传值使用 （可选）
     

     */
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
