//
//  AddPostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 18/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "AddPostRequestHandler.h"
#import "PostManager.h"
#import "BridgeManager.h"

@implementation AddPostRequestHandler
{
    NSInteger postid;
}

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber *isSuccess = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];;
    if([isSuccess boolValue]) {
        UIImage *image = [_images lastObject];
        [_images removeLastObject];
        postid = [[jsonData objectForKey:@"postid"] integerValue];
        [[BridgeManager getBridgeManager] uploadPostImage:image forPost:postid];
    } else {
        if([self.delegate respondsToSelector:@selector(onPost:description:)])
            [self.delegate performSelector:@selector(onPost:description:) withObject:isSuccess withObject:[jsonData objectForKey:@"description"]];
        
        for (id dele in observers) {
            if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onPost:description:)])
                [dele performSelector:@selector(onPost:description:) withObject:isSuccess withObject:[jsonData objectForKey:@"description"]];
        }
        
        [observers removeAllObjects];
    }
}

-(void) onPostImageUploaded:(NSNumber *)isUploaded description:(NSString *)desc{
    if([isUploaded boolValue] && [_images count] > 0) {
        UIImage *image = [_images lastObject];
        [_images removeLastObject];
        [[BridgeManager getBridgeManager] uploadPostImage:image forPost:postid];
    } else {
        if([self.delegate respondsToSelector:@selector(onPost:description:)])
            [self.delegate performSelector:@selector(onPost:description:) withObject:isUploaded withObject:desc];
        
        for (id dele in observers) {
            if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onPost:description:)])
                [dele performSelector:@selector(onPost:description:) withObject:isUploaded withObject:desc];
        }
        
        [observers removeAllObjects];
    }
}

@end
