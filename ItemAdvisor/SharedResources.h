//
//  SharedResources.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 21/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedResources : NSObject

@property NSString *serverIP;

+(instancetype) getResources;

-(void)loadImageAtBackend:(NSString*)imgURL storeAt:(UIImageView*)imgStore;
-(void)preloadImage:(NSString*)imgURL;

@end
