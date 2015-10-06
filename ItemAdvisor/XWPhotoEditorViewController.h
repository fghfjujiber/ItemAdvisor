//
//  XWPhotoEditorViewController.h
//  XWEditPhotoDemo
//
//  Created by Xiaonan Wang on 10/5/13.
//  Copyright (c) 2013 Xiaonan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWEditPhotoViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface XWPhotoEditorViewController : XWEditPhotoViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end
