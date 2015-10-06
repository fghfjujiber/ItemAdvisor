//
//  SharedResources.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 21/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "SharedResources.h"

@implementation SharedResources
{
    NSMutableDictionary* imgBuffer;
}

+(instancetype) getResources {
    static SharedResources *sharedResources = nil;
    if (sharedResources == nil) {
        sharedResources = [[self alloc] init];
    }
    return sharedResources;
}

- (id)init {
    if (self = [super init]) {
        _serverIP = @"http://113.55.0.233/itemadvisor";
        imgBuffer = [NSMutableDictionary new];
    }
    return self;
}

-(void)loadImageAtBackend:(NSString*)imgURL storeAt:(UIImageView*)imgStore {
    if(imgStore) [imgStore setImage:imgBuffer[imgURL]];
    if(![[imgBuffer allKeys] containsObject:imgURL]) {
        imgBuffer[imgURL] = [[UIImage alloc] init];
        [self performSelectorInBackground:@selector(loadImage:) withObject:@{@"img":imgURL,@"store":imgStore}];
    }
}

-(void)preloadImage:(NSString *)imgURL {
    [self loadImageAtBackend:imgURL storeAt:nil];
}

-(void)loadImage:(NSDictionary*)imgBlock {
    UIImageView* imgView = imgBlock[@"store"];
    UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgBlock[@"img"]]]];
    if(img) imgBuffer[imgBlock[@"img"]] = img;
    if(imgView) [imgView setImage:img];
}

@end
