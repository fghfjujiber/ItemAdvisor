//
//  PostCell.h
//  PostTableView
//
//  Created by Xiaoming Chen on 06/04/2014.
//  Copyright (c) 2014 Xiaoming Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PostEntity.h"
#import "TagEntity.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PostCell : UITableViewCell

@property (strong,nonatomic)NSMutableArray *addedTagArray;
@property NSMutableArray *tagsWithoutText;
@property NSMutableArray *tagsWithText;
@property CGFloat prevTagY;
@property CGFloat prevImgY;
@property CGFloat prevTxtY;

@property (strong,nonatomic)UIColor *color;

@property (strong,nonatomic)UIButton *toAccountViewButton;
@property (strong,nonatomic)UIImageView *profilePic;
@property (strong,nonatomic)UILabel *name;
@property (strong,nonatomic)UILabel *time;

@property (strong,nonatomic)UIImageView *firstPic;
@property (strong,nonatomic)UILabel *desc;


@property UIButton *readButton;
@property (strong,nonatomic)UILabel * readLogo;
@property (strong,nonatomic)UILabel *readLogoText;

@property UIButton *likeButton;
@property (strong,nonatomic)UILabel * likeLogo;
@property (strong,nonatomic)UILabel *likeLogoText;

@property UIButton *commentButton;
@property (strong,nonatomic)UILabel * commentLogo;
@property (strong,nonatomic)UILabel *commentLogoText;

@property NSURL* url;
@property NSURL* profileUrl;
@property PostEntity* post;
@property NSInteger tagInMark;
@property NSInteger likeMark;

+(CGFloat)cellHeight;
-(void)createContentInCell;

@end
