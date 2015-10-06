//
//  GetPostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 18/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "GetPostRequestHandler.h"
#import "PostManager.h"
#import "PostEntity.h"
#import "TagEntity.h"

@implementation GetPostRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber *isSuccess = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];
    NSMutableArray *posts = [NSMutableArray new];
    
    if([isSuccess boolValue]) {
        NSArray *postlist = [jsonData objectForKey:@"posts"];
        for (NSDictionary *post in postlist) {
            PostEntity *postEntity = [[PostEntity alloc] init];
            postEntity.postID = [[post objectForKey:@"id"] integerValue];
            postEntity.NumberOfViews = [[post objectForKey:@"no_view"] integerValue];
            postEntity.content = [post objectForKey:@"content"];
            postEntity.timeStamp = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"time_stamp"] integerValue]];
            postEntity.username = [post objectForKey:@"firstname"];
            postEntity.profileURL = [NSString stringWithFormat:@"http://113.55.0.233/itemadvisor/img/profile/%@.jpg", [post objectForKey:@"email"]];
            NSMutableArray *images = [NSMutableArray new];
            NSMutableArray *tags = [NSMutableArray new];
            
            for (NSDictionary *img in [post objectForKey:@"imgs"]) {
                [images addObject:[NSString stringWithFormat:@"http://113.55.0.233/itemadvisor/img/post/%@", [img objectForKey:@"img"]]];
            }
            
            for (NSDictionary *tag in [post objectForKey:@"tags"]) {
                [tags addObject:[[NSNumber alloc] initWithInteger:[[tag objectForKey:@"tag_type"] integerValue]]];
                [tags addObject:[[TagEntity alloc] initWithType:[[tag objectForKey:@"tag_type"] integerValue] Desc:[tag objectForKey:@"tag_desc"]]];
            }
            
            postEntity.imageURLs = images;
            postEntity.tags = tags;
            
            [posts addObject:postEntity];
            
        }
    }
    
    if([self.delegate respondsToSelector:@selector(onGetPost:content:)])
        [self.delegate performSelector:@selector(onGetPost:content:) withObject:isSuccess withObject:posts];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onGetPost:content:)])
            [dele performSelector:@selector(onGetPost:content:) withObject:isSuccess withObject:posts];
    }
    
    [observers removeAllObjects];
}

@end
