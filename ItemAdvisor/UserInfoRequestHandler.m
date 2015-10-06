//
//  UserInfoRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UserInfoRequestHandler.h"
#import "UserManager.h"

@implementation UserInfoRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onUserInfoReceived:)])
        [self.delegate performSelector:@selector(onUserInfoReceived:) withObject:jsonData];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(UserManagerDelegate)] && [dele respondsToSelector:@selector(onUserInfoReceived:)])
            [dele performSelector:@selector(onUserInfoReceived:) withObject:jsonData];
    }
    
    [observers removeAllObjects];
}

@end
