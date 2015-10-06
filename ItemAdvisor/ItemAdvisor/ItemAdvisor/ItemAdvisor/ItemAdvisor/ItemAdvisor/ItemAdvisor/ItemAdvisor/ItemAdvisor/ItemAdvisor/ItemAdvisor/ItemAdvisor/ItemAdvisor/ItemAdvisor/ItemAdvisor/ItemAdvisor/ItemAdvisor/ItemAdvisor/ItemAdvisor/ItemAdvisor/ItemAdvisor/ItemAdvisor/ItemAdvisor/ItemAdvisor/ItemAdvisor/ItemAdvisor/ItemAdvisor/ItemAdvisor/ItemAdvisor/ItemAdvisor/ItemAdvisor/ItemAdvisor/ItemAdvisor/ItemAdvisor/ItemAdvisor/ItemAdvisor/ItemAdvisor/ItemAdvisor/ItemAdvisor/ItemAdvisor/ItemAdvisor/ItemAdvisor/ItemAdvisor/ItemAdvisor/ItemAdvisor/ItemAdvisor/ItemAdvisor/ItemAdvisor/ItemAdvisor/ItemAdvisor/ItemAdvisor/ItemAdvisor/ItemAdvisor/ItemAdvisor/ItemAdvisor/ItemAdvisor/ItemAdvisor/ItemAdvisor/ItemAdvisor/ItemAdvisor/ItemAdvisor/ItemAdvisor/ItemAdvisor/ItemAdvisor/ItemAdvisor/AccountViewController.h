//
//  SecondViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface AccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *userName;
@property (weak, nonatomic) IBOutlet UITextView *userIntroduction;
@property (weak, nonatomic) IBOutlet UIButton *postDetail;
@property (weak, nonatomic) IBOutlet UIButton *followingDetail;
@property (weak, nonatomic) IBOutlet UIButton *followerDetail;
@property (weak, nonatomic) IBOutlet UIButton *stuffDetail;

@end
