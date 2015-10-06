//
//  RegisterUserRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 21/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "RegisterUserRequestHandler.h"
#import "BridgeManager.h"
#import "UserManager.h"

@implementation RegisterUserRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber * isRegistered = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];
    if([isRegistered boolValue]) {
        [[BridgeManager getBridgeManager] uploadImage:[UserManager getUserManager].profile forUser:[jsonData objectForKey:@"useremail"]];
    } else {
        if([self.delegate respondsToSelector:@selector(onRegistUser:description:)])
            [self.delegate performSelector:@selector(onRegistUser:description:) withObject:isRegistered withObject:[jsonData objectForKey:@"description"]];
        
        for (id dele in observers) {
            if([dele conformsToProtocol:@protocol(UserManagerDelegate)] && [dele respondsToSelector:@selector(onRegistUser:description:)])
                [dele performSelector:@selector(onRegistUser:description:) withObject:isRegistered withObject:[jsonData objectForKey:@"description"]];
        }
        
        [observers removeAllObjects];
    }
}

-(void) onImageUploaded:(NSNumber *)isUploaded description:(NSString *)desc{
    if([self.delegate respondsToSelector:@selector(onRegistUser:description:)])
        [self.delegate performSelector:@selector(onRegistUser:description:) withObject:[NSNumber numberWithBool:isUploaded] withObject:desc];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(UserManagerDelegate)] && [dele respondsToSelector:@selector(onRegistUser:description:)])
            [dele performSelector:@selector(onRegistUser:description:) withObject:[NSNumber numberWithBool:isUploaded] withObject:desc];
    }
    
    [observers removeAllObjects];
}

@end
