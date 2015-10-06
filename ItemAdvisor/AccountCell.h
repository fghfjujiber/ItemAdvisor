//
//  AccountCell.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 09/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AccountCell : UITableViewCell

@property UIButton *postButton;
@property UIButton *postNum;
@property UIButton *followButton;
@property UIButton *followNum;
@property UIButton *followerButton;
@property UIButton *followerNum;
@property UIButton *tagButton;
@property UIButton *tagNum;

@property UIImageView *profilePic;
@property UILabel *nickname;
@property UILabel *intro;

@property UIButton *editButton;
@property (strong,nonatomic)UIColor *color;

+(CGFloat)cellHeight;
-(void)createContent;

@end
