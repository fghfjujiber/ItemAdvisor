//
//  LikePostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 09/05/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "LikePostRequestHandler.h"
#import "PostManager.h"

@implementation LikePostRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onLiked:description:)])
        [self.delegate performSelector:@selector(onLiked:description:) withObject:jsonData];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onLiked:description:)])
            [dele performSelector:@selector(onLiked:description:) withObject:jsonData];
    }
    
    [observers removeAllObjects];
}

@end
