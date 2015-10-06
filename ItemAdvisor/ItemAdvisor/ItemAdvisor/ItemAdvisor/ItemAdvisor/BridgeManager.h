//
//  BridgeManager.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BridgeManager : NSObject

+(instancetype) getBridgeManager;

-(void)requestUserInfo:(NSString *)userid;
-(void)login:(NSString *)useremail password:(NSString *)password;

@end
