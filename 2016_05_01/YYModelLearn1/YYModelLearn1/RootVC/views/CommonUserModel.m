//
//  CommonUserModel.m
//  YYModelTest1
//
//  Created by xiaoyulong on 16/5/25.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "CommonUserModel.h"

@implementation CommonUserModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
{
    self = [super init];
    if (self) {
        
        self.login = [attributes objectForKey:@"login"];
        self.userId = [attributes objectForKey:@"id"];
        self.avatarURL = [attributes objectForKey:@"avatar_url"];
        self.gravatarID = [attributes objectForKey:@"gravatar_id"];
        self.url = [attributes objectForKey:@"url"];
        self.htmlURL = [attributes objectForKey:@"html_url"];
        self.followersURL = [attributes objectForKey:@"followers_url"];
        self.followingURL = [attributes objectForKey:@"following_url"];
        self.gistsURL = [attributes objectForKey:@"gists_url"];
        self.starredURL = [attributes objectForKey:@"starred_url"];
        self.subscriptionsURL = [attributes objectForKey:@"subscriptions_url"];
        self.organizationsURL = [attributes objectForKey:@"organizations_url"];
        self.reposURL = [attributes objectForKey:@"repos_url"];
        self.eventsURL = [attributes objectForKey:@"events_url"];
        self.receivedEventsURL = [attributes objectForKey:@"received_events_url"];
        self.type = [attributes objectForKey:@"type"];
        self.siteAdmin = (BOOL)[attributes objectForKey:@"site_admin"];
        self.name = [attributes objectForKey:@"name"];
        self.company = [attributes objectForKey:@"company"];
        self.blog = [attributes objectForKey:@"blog"];
        self.location = [attributes objectForKey:@"location"];
        self.email = [attributes objectForKey:@"email"];
        self.hireable = [attributes objectForKey:@"hireable"];
        self.PicList = [attributes objectForKey:@"PicList"];
        self.bio = [attributes objectForKey:@"bio"];
        self.following = [attributes objectForKey:@"following"];
        self.publicRepos = (UInt32)[attributes objectForKey:@"public_repos"];
        self.publicGists = (UInt32)[attributes objectForKey:@"public_gists"];
        self.followers = (UInt32)[attributes objectForKey:@"followers"];
        self.followingPerson = (UInt32)[attributes objectForKey:@"following"];
        self.createdAt = [attributes objectForKey:@"created_at"];
        self.updatedAt = [attributes objectForKey:@"updated_at"];
        
    }
    return self;
}



@end
