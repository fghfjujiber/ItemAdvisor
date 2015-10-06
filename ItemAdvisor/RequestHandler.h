//
//  RequestHandler.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestHandler : NSObject <NSURLConnectionDelegate>
{
    NSMutableArray * observers;
}
@property (weak) id delegate;

-(instancetype)initWithDelegate:(id) delegate;
-(void)addObserver:(id)observer;
@end
