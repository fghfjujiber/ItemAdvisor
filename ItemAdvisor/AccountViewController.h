//
//  SecondViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "PostCell.h"
#import "PostManager.h"
#import "PostEntity.h"
#import "TagEntity.h"
#import "AccountCell.h"
#import "SharedResources.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UserManagerDelegate,PostManagerDelegate>

@property (strong,nonatomic)UITableView *postTable;
@property (strong,nonatomic)NSMutableArray *nameArray;
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *addedTagArray;
@property (strong,nonatomic)NSMutableArray *postList;

@end
