//
//  CommentPostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 09/05/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "CommentPostRequestHandler.h"
#import "PostManager.h"

@implementation CommentPostRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onComment:description:)])
        [self.delegate performSelector:@selector(onComment:description:) withObject:jsonData];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onComment:description:)])
            [dele performSelector:@selector(onComment:description:) withObject:jsonData];
    }
    
    [observers removeAllObjects];
}

@end
