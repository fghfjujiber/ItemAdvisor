//
//  PostManager.h
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostTag.h"
#import "AddPostRequestHandler.h"
#import "GetPostRequestHandler.h"
#import "UploadPostImageRequestHandler.h"
#import "ViewPostRequestHandler.h"
#import "LikePostRequestHandler.h"
#import "CommentPostRequestHandler.h"

@protocol PostManagerDelegate
@optional
- (void)onPost:(NSNumber *) isSuccess description:(NSString *)desc;
- (void)onGetPost:(NSNumber *) isSuccess content:(NSArray *)list;
- (void)onPostImageUploaded:(NSNumber *)isUploaded description:(NSString *)desc;
- (void)onViewed:(NSNumber *) isSuccess description:(NSString *)desc;
- (void)onLiked:(NSNumber *) isSuccess description:(NSString *)desc;
- (void)onComment:(NSNumber *) isSuccess description:(NSString *)desc;
@end

@interface PostManager : NSObject

@property AddPostRequestHandler* addPostRH;
@property GetPostRequestHandler* getPostRH;
@property UploadPostImageRequestHandler *uploadPostImageRH;
@property ViewPostRequestHandler *viewPostRH;
@property LikePostRequestHandler *likePostRH;
@property CommentPostRequestHandler *commentPostRH;

+(instancetype) getPostManager;

-(void)newPost:(NSInteger)userID tagList:(NSArray *)tags imageList:(NSArray *)images contents:(NSString *)text withDelegate:(id)delegate;
-(void)getUserPost:(NSInteger)userID range:(NSRange)range withDelegate:(id)delegate;
-(void)getPublicPostwithDelegate:(id)delegate;
-(void)viewPost:(NSInteger)postID withDelegate:(id)delegate;
-(void)likePost:(NSInteger)postID flag:(NSInteger)flag withDelegate:(id)delegate;
-(void)commentPost:(NSInteger)postID replyTo:(NSInteger)replyID content:(NSString*)content withDelegate:(id)delegate;

@end
