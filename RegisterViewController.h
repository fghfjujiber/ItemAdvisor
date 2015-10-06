//
//  RegisterViewController.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWPhotoEditorViewController.h"
#import "ImageFilterProcessViewController.h"
#import "UserManager.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface RegisterViewController : UIViewController <UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,XWFinishEditPhoto,ImageFitlerProcessDelegate,UserManagerDelegate,UITextFieldDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIButton *profilePicButton;
@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (weak,nonatomic) UIImage *profileImageBig;
@property (weak,nonatomic) UIImage *profileImageSmall;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *createdPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmedPassword;
@end
