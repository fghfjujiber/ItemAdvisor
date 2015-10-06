//
//  TagEntity.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 06/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "TagEntity.h"

@implementation TagEntity

-(id)initWithType:(NSInteger)tagType Desc:(NSString *)desc {
    if(self = [super init]) {
        _TagType = tagType;
    }
    return self;
}

@end
