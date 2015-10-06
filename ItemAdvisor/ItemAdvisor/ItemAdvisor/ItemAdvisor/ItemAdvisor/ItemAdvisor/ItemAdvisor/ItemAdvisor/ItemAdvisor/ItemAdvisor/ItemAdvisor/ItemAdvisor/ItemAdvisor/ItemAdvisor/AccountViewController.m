//
//  SecondViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()


@end

@implementation AccountViewController
@synthesize profileImage;
- (IBAction)editProfile:(UIButton *)sender {
}

- (void)viewDidLoad
{
    //Initialise profile image
    UIImage *image = [UIImage imageNamed:@"haha.jpeg"];
    [profileImage setImage:image];
    
    //Initialise username
    NSString *name = [NSString stringWithFormat:@"%@ %@", [UserManager getUserManager].lastName, [UserManager getUserManager].firstName];
    self.userName.text = [NSString stringWithFormat:@"%@", name];
    [self.userName setFont:[UIFont systemFontOfSize:20]];
    
    //Initialise introduction
    NSString *intro = [NSString stringWithFormat:@"%@", [UserManager getUserManager].description];
    self.userIntroduction.text = [NSString stringWithFormat:@"%@", intro];
    [self.userIntroduction setFont:[UIFont systemFontOfSize:11]];
    
    //Initialise details(POST)
    NSUInteger numOfpost = 88;
    NSString *postDetailTitle = [NSString stringWithFormat:@"日志\n%lu",(unsigned long)numOfpost];
    
    NSMutableAttributedString *postTitle = [[NSMutableAttributedString alloc] initWithString:postDetailTitle];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [postTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, postTitle.length)];
    
    [self.postDetail setAttributedTitle:postTitle forState:UIControlStateNormal];

    //Initialise details(FOLLOWING)
    NSUInteger numOffollowing = 88;
    NSString *followingDetailTitle = [NSString stringWithFormat:@"关注\n%lu",(unsigned long)numOffollowing];
    
    NSMutableAttributedString *followingTitle = [[NSMutableAttributedString alloc] initWithString:followingDetailTitle];
    
    [followingTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, followingTitle.length)];
    
    [self.followingDetail setAttributedTitle:followingTitle forState:UIControlStateNormal];
    
    //Initialise details(FOLLOWER)
    NSUInteger numOffollower = 88;
    NSString *followerDetailTitle = [NSString stringWithFormat:@"粉丝\n%lu",(unsigned long)numOffollower];
    
    NSMutableAttributedString *followerTitle = [[NSMutableAttributedString alloc] initWithString:followerDetailTitle];
    
    [followerTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, followerTitle.length)];
    
    [self.followerDetail setAttributedTitle:followerTitle forState:UIControlStateNormal];
    
    //Initialise details(STUFF)
    NSUInteger numOfstuff = 88;
    NSString *stuffDetailTitle = [NSString stringWithFormat:@"物品\n%lu",(unsigned long)numOfstuff];
    
    NSMutableAttributedString *stuffTitle = [[NSMutableAttributedString alloc] initWithString:stuffDetailTitle];
    
    [stuffTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, stuffTitle.length)];
    
    [self.stuffDetail setAttributedTitle:stuffTitle forState:UIControlStateNormal];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
