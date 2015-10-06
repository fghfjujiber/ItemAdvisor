//
//  DetailPostViewController.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostEntity.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DetailPostViewController : UIViewController <UIScrollViewDelegate,UITextViewDelegate, UITextFieldDelegate>

@property UIButton *textButton;
@property UILabel *textButtonText;
@property UIImageView *textButtonLogo;
@property UIButton *picButton;
@property UILabel *picButtonText;
@property UIImageView *picButtonLogo;
@property UIButton *comButton;
@property UILabel *comButtonText;
@property UIImageView *comButtonLogo;
@property UIScrollView *mainContent;
@property UITextView *desc;
@property UIButton *comment;
@property UIButton *likes;
@property UIButton *toLike;
@property UILabel *myCommentLabel;
@property UITextField *myComment;
@property UIButton *sendComment;

@property PostEntity *post;
@property NSMutableArray *picArray;
@property NSMutableArray *comArray;
@property NSMutableArray *likesArray;

@end
