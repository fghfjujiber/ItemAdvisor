//
//  ImageFilterProcessViewController.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageFitlerProcessDelegate;
@interface ImageFilterProcessViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIImageView *rootImageView;
    UIScrollView *scrollerView;
    UIImage *currentImage;
    __weak id <ImageFitlerProcessDelegate> delegate;
}
@property(nonatomic,weak) id<ImageFitlerProcessDelegate> delegate;
@property(nonatomic,strong)UIImage *currentImage;
@end

@protocol ImageFitlerProcessDelegate <NSObject>

- (void)imageFitlerProcessDone:(UIImage *)image;
- (void)imageFitlerProcessCancel;

@end
