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

// User Related Requests
-(void)requestUserInfo:(NSString *)userid;
-(void)login:(NSString *)useremail password:(NSString *)password;
-(void)uploadImage:(UIImage *)image forUser:(NSString *)email;
-(void)registUser:(NSDictionary *)user_data;

// Post Related Requests
-(void)newPost:(NSInteger)userID tagList:(NSArray *)tags contents:(NSString *)text;
-(void)uploadPostImage:(UIImage *)image forPost:(NSInteger)postid;
-(void)getUserPost:(NSInteger)userID range:(NSRange)range;
-(void)getPublicPost;
-(void)viewPost:(NSInteger)postID;
-(void)likePost:(NSInteger)postID flag:(NSInteger)flag;
-(void)commentPost:(NSInteger)postID replyTo:(NSInteger)replyID content:(NSString*)content;

@end
