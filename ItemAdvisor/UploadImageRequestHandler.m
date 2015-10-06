//
//  UploadImageRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 21/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UploadImageRequestHandler.h"
#import "UserManager.h"

@implementation UploadImageRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber * isUploaded = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];
    if([self.delegate respondsToSelector:@selector(onImageUploaded:description:)])
        [self.delegate performSelector:@selector(onImageUploaded:description:) withObject:isUploaded withObject:[jsonData objectForKey:@"description"]];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(UserManagerDelegate)] || [dele respondsToSelector:@selector(onImageUploaded:description:)])
            [dele performSelector:@selector(onImageUploaded:description:) withObject:isUploaded withObject:[jsonData objectForKey:@"description"]];
    }
    
    [observers removeAllObjects];
}

@end
