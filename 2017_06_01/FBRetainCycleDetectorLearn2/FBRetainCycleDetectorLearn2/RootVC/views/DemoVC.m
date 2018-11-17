//
//  DemoVC.m
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "DemoVC.h"
//#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

#import "FBRetainCycleDetector.h"

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(weakSelf) strongSelf = weakSelf
#define kBlockSelf __strong __typeof__(self) blockSelf = weakSelf

#import "Person.h"
#import "Apartment.h"


@interface DemoVC ()
{
    void (^_handlerBlock)();

}

@end

@implementation DemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self demo1];
 
    Person *john = [[Person alloc] init];
    john.name = @"john";
    
    
    Apartment *number73 = [[Apartment alloc] init];
    number73.number = 73;
    
    // 相互强引用
    john.apartment = number73;
    number73.person = john;
    
    
    FBRetainCycleDetector *detector = [[FBRetainCycleDetector alloc] init];
    [detector addCandidate:john];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"retainCycles==%@", retainCycles);
    /**
     retainCycles=={(
     (
         "-> _apartment -> Apartment ",
         "-> _person -> Person "
     )
     )}

     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demo1
{
    kSelfWeak;
    _handlerBlock = ^(){
        kSelfStrong;
        NSLog(@"%@", strongSelf);
    };
    

    _handlerBlock();
    
    
    
    
    /**
     使用FBRetainCycleDetector检测引用循环
     */
    
    FBRetainCycleDetector *detector = [[FBRetainCycleDetector alloc] init];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"retainCycles==%@", retainCycles);

    /**
     retainCycles=={(
     (
         "-> DemoVC ",
         "-> _handlerBlock -> __NSMallocBlock__ "
     )
     )}

     
     很明显，DetailViewController通过_handlerBlock实例变量引用一个Block对象，而该Block又引用了DetailViewController对象。如果不存在引用循环的话，打印的结果将是空的。
     

     */
}



@end
