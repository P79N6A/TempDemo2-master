//
//  TestVC2.m
//  MLTransitionLearn1
//
//  Created by xiaoyulong on 16/7/30.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC2.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface TestVC2 () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI

- (void)createUI
{
    
    UIColor *navBarColor = [UIColor colorWithRed:0.063 green:0.263 blue:0.455 alpha:1.000];
    UIColor *navBarTintColor = [UIColor whiteColor];
    //导航栏
    [[UINavigationBar appearance]setBarTintColor:navBarColor];
    
    [[UINavigationBar appearance]setTintColor:navBarTintColor];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.0f];
    attributes[NSForegroundColorAttributeName] = navBarTintColor;
    NSShadow *shadow = [NSShadow new];
    shadow.shadowColor = [UIColor clearColor];
    attributes[NSShadowAttributeName] = shadow;
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];

    
    self.navigationItem.title = @"TestVC2";
    [self.view addSubview:self.btn];

}


#pragma mark - 按钮响应事件

- (void)click:(UIButton *)sender
{
    
    //测试在图片浏览器里能否正常执行
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];

    
//    DetailVC2 *detail = [[DetailVC2 alloc] init];
//    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 网络请求


#pragma mark - 代理方法
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"得到了image");
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - setter, getter

- (UIButton *)btn
{
    if (_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor yellowColor];
        _btn.frame = CGRectMake(100, 100, 100, 40);
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
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
