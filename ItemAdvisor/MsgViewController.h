//
//  SecondViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MsgViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property UIButton *newsButton;
@property UIButton *msgButton;
@property UILabel *newsButtonText;
@property UILabel *msgButtonText;
@property UIImageView *newsButtonLogo;
@property UIImageView *msgButtonLogo;
@property UITableView *msgList;
@property NSMutableArray *contactArray;

@end
