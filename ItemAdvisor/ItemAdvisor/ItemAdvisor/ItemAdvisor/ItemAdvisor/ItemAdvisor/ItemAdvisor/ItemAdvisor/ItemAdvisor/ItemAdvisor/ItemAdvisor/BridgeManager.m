//
//  BridgeManager.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "BridgeManager.h"
#import "UserManager.h"

@implementation BridgeManager
{
    NSString* gerUserURL;
    NSString* loginURL;
}

+ (instancetype)getBridgeManager {
    static BridgeManager *sharedBridgeManager = nil;
    if (sharedBridgeManager == nil) {
        sharedBridgeManager = [[self alloc] init];
    }
    return sharedBridgeManager;
}

- (id)init {	
    if (self = [super init]) {
        // init propertise
        gerUserURL = @"http://113.55.0.233/itemadvisor/getuser.php";
        loginURL = @"http://113.55.0.233/itemadvisor/login.php";
    }
    return self;
}

#pragma mark - UserManager Requests

-(void)requestUserInfo:(NSString *)userid {
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:gerUserURL]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].userinfoRH];
    
}

-(void)login:(NSString *)useremail password:(NSString *)password {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginURL]];
    NSString *postString = [NSString stringWithFormat:@"login=%@&password=%@",useremail, password];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].loginRH];
}
@end
