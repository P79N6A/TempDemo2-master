//
//  ViewController.m
//  reserveDream
//
//  Created by Mac on 14-11-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "HttpKit.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"


@implementation HttpKit
+ (void)HttpConnectionKit:(NSString*)action x:(NSString*)contentType  dataStr:(NSString*)dataStr succeed:(void(^)(NSArray*))myarray  err:(void(^)(NSArray*))err
{
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:contentType];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:action parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData* data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithHeaders:nil body:data];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject = %@",responseObject);
        NSArray* tempArray = [HttpKit GetArray];
        if(myarray)
                myarray(tempArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[self.view makeToast:@"网络异常"];
        NSLog(@"connection failure");
        NSArray* tempArray = [HttpKit GetArray];
        if(err)
                err(tempArray);
    }];
}

+ (NSArray*)GetArray
{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"test" ofType:@"xml"];
    NSMutableArray* tempArray = [NSMutableArray array];
    NSString* xmlstr = [NSString stringWithContentsOfFile:path usedEncoding:NULL error:nil];
    xmlstr = [xmlstr stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNSxml"];
    NSError* error = nil;
    DDXMLDocument* xmlDoc = [[DDXMLDocument alloc] initWithXMLString:xmlstr options:0 error:&error];
    NSArray* array = [xmlDoc nodesForXPath:@"smil/body/par" error:nil];
    
    for(int i = 0; i < [array count]; i++)
    {
        DDXMLElement *child = [array objectAtIndex:i];
        VideoInfo*  info = [VideoInfo new];
        NSString *userId = [[child attributeForName:@"id"] stringValue];
        [info setVideoID:userId];
        NSArray* subarray = [child nodesForXPath:@"text" error:nil];
        if([subarray count]>0)
        {
            DDXMLElement* subchild = subarray[0];
            NSString* title = [[subchild attributeForName:@"title"] stringValue];
            [info setVideoTitle:title];
            NSString* img = [[subchild attributeForName:@"img"] stringValue];
            [info setVideoIcon:img];
            
            NSString* src = [[subchild attributeForName:@"src"] stringValue];
            [info setVideoSrc:src];
        }
        [tempArray addObject:info];
    }
    return tempArray;
}

@end
