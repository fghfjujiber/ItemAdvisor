//
//  UploadPostImageRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 19/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UploadPostImageRequestHandler.h"
#import "PostManager.h"

@implementation UploadPostImageRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber * isUploaded = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];
    if([self.delegate respondsToSelector:@selector(onPostImageUploaded:description:)])
        [self.delegate performSelector:@selector(onPostImageUploaded:description:) withObject:isUploaded withObject:[jsonData objectForKey:@"description"]];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] || [dele respondsToSelector:@selector(onPostImageUploaded:description:)])
            [dele performSelector:@selector(onPostImageUploaded:description:) withObject:isUploaded withObject:[jsonData objectForKey:@"description"]];
    }
    
    [observers removeAllObjects];
}

@end
