//
//  ViewPostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 09/05/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "ViewPostRequestHandler.h"
#import "PostManager.h"

@implementation ViewPostRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onViewed:description:)])
        [self.delegate performSelector:@selector(onViewed:description:) withObject:jsonData];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onViewed:description:)])
            [dele performSelector:@selector(onViewed:description:) withObject:jsonData];
    }
    
    [observers removeAllObjects];
}

@end
