//
//  AllocManager.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 19/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllocManager : NSObject

@property(strong,nonatomic)UIImagePickerController *picker;

+(instancetype) getAllocManager;
-(void)createImagePicker;

@end
