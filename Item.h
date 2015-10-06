//
//  Item.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 25/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)UIImage *biglogo;
@property (strong, nonatomic)UIImage *smalllogo;
@property (strong, nonatomic)NSNumber *number;

@end
