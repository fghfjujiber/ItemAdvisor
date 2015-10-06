//
//  MakePostViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 07/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "XWPhotoEditorViewController.h"
#import "ImageFilterProcessViewController.h"
#import "PostManager.h"
#import "UserManager.h"
#import "TagEntity.h"
#import "ELCImagePickerController.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import "ChooseTagViewController.h"

#define  PIC_WIDTH 86
#define  PIC_HEIGHT 86
#define  INSETS 10
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MakePostViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UINavigationControllerDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, ImageFitlerProcessDelegate, UITextViewDelegate, PostManagerDelegate, UserManagerDelegate, UIAlertViewDelegate, ELCImagePickerControllerDelegate,ChooseTagViewControllerDelegate>
{
    UIScrollView *scrollview;
    UIButton *addTag;
    UILabel *line;
    UIScrollView *photoScroll;
    UIButton *addPic;
    UIImage *newPic;
    UILabel *isCoverPic;

}


@property (strong,nonatomic)NSMutableArray *addedTagArray;
@property (strong,nonatomic)NSMutableArray *addedPicArray;
@property (strong,nonatomic)UIImagePickerController *picker;
@property (strong,nonatomic)ELCImagePickerController *elcPicker;
@property (strong,nonatomic)UITextView *tf;
@property (strong,nonatomic)UITextView *desc;
@property NSUInteger numOfAddTag;


@end
