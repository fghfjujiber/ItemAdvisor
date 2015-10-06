//
//  LoginViewController.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface LoginViewController : UIViewController <UserManagerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UIView *loginView;

@end
