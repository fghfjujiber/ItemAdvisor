//
//  TagEntity.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 06/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagEntity : NSObject

@property NSString *description;
@property NSInteger TagType;

-(id)initWithType:(NSInteger)tagType Desc:(NSString *)desc;

@end
