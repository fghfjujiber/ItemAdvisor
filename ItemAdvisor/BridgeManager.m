//
//  BridgeManager.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "BridgeManager.h"
#import "UserManager.h"
#import "PostManager.h"
#import "TagEntity.h"
#import "SharedResources.h"

@implementation BridgeManager
{
    // User Requests
    NSString* gerUserURL;
    NSString* loginURL;
    NSString* registerURL;
    NSString* uploadProfileURL;
    // Post Requests
    NSString* uploadPostURL;
    NSString* addPostURL;
    NSString* getPostURL;
    NSString* viewPostURL;
    NSString* likePostURL;
    NSString* commentPostURL;
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
        gerUserURL = [NSString stringWithFormat:@"%@/getuser.php", [SharedResources getResources].serverIP];
        loginURL = [NSString stringWithFormat:@"%@/login.php", [SharedResources getResources].serverIP];
        registerURL = [NSString stringWithFormat:@"%@/register.php", [SharedResources getResources].serverIP];
        uploadProfileURL = [NSString stringWithFormat:@"%@/uploadImg.php", [SharedResources getResources].serverIP];
        uploadPostURL = [NSString stringWithFormat:@"%@/uploadPost.php", [SharedResources getResources].serverIP];
        addPostURL = [NSString stringWithFormat:@"%@/addPost.php", [SharedResources getResources].serverIP];
        getPostURL = [NSString stringWithFormat:@"%@/getPost.php", [SharedResources getResources].serverIP];
        viewPostURL = [NSString stringWithFormat:@"%@/viewPost.php", [SharedResources getResources].serverIP];
        likePostURL = [NSString stringWithFormat:@"%@/likePost.php", [SharedResources getResources].serverIP];
        commentPostURL = [NSString stringWithFormat:@"%@/commentPost.php", [SharedResources getResources].serverIP];
    }
    return self;
}

#pragma mark - Private Functions


#pragma mark - UserManager Requests

-(void)requestUserInfo:(NSString *)userid {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:gerUserURL]];
    NSString *postString = [NSString stringWithFormat:@"userid=%@",userid];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].userinfoRH];
    
}

-(void)registUser:(NSDictionary *)user_data {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:registerURL]];
    NSString *postString = [NSString stringWithFormat:@"email=%@&password=%@&firstname=%@&lastname=%@&desc=%@",[user_data objectForKey:@"email"],[user_data objectForKey:@"password"],[user_data objectForKey:@"firstname"],[user_data objectForKey:@"lastname"],[user_data objectForKey:@"desc"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].registRH];
    
}

-(void)login:(NSString *)useremail password:(NSString *)password {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginURL]];
    NSString *postString = [NSString stringWithFormat:@"login=%@&password=%@",useremail, password];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].loginRH];
}

-(void)uploadImage:(UIImage *)image forUser:(NSString *)email{
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:uploadProfileURL]];
    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    NSString *boundary = @"498huj0ije3f874ew20oijfhfsfgk";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n",email] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].uploadImageRH];
    
}

#pragma mark - PostManager Requests

-(void)uploadPostImage:(UIImage *)image forPost:(NSInteger)postid {
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:uploadPostURL]];
    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    NSString *boundary = @"498huj0ije3f874ew20oijfhfsfgk";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%ld.jpg\"\r\n",postid] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    [[NSURLConnection alloc] initWithRequest:request delegate:[PostManager getPostManager].uploadPostImageRH];
}

-(void)newPost:(NSInteger)userID tagList:(NSArray *)tags contents:(NSString *)text {
    NSMutableArray* tagstring = [NSMutableArray array];
    for(TagEntity* te in tags) {
        [tagstring addObject:[NSString stringWithFormat:@"%ld;%@", te.TagType, te.description]];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:addPostURL]];
    NSString *postString = [NSString stringWithFormat:@"userid=%ld&content=%@&tags=%@",userID,text,[tagstring componentsJoinedByString:@","]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[PostManager getPostManager].addPostRH];
}

-(void)getUserPost:(NSInteger)userID range:(NSRange)range {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getPostURL]];
    NSString *postString = [NSString stringWithFormat:@"userid=%ld&location=%ld&range=%ld", userID, range.location, range.length];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[PostManager getPostManager].getPostRH];
}

-(void)getPublicPost {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getPostURL]];
    NSString *postString = [NSString stringWithFormat:@""];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[PostManager getPostManager].getPostRH];
}

-(void)viewPost:(NSInteger)postID {
    
}

-(void)likePost:(NSInteger)postID flag:(NSInteger)flag {
    
}

-(void)commentPost:(NSInteger)postID replyTo:(NSInteger)replyID content:(NSString*)content {
    
}

@end
