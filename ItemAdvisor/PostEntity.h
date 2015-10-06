//
//  PostEntity.h
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostEntity : NSObject

@property NSString *content;
@property NSMutableArray *images; // store UIImage
@property NSMutableArray *imageURLs; // store URL
@property NSMutableArray *tags;   // store NSNumber
@property NSDate *timeStamp;
@property NSString *username;
@property NSString *profileURL;
@property UIImage *profile;
@property NSInteger postID;
@property NSInteger userID;
@property NSInteger NumberOfThumbUp;
@property NSInteger NumberOfThumbDown;
@property NSInteger NumberOfViews;

@end
