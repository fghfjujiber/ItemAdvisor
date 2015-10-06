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

static NSString *CellIdentifier = @"PostCellIdentifier";
static NSString *CellIdentifier1 = @"AccountCellIdentifier";

- (void)viewDidLoad
{
    //Create scroll view
//    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 320, 415)];
//    scrollview.showsVerticalScrollIndicator=YES;
//    scrollview.scrollEnabled=YES;
//    scrollview.userInteractionEnabled=YES;
//    [self.view addSubview:scrollview];
//    scrollview.contentSize = CGSizeMake(320,220+([UserManager getUserManager].noPost)*530);
    //create post arrays
    
    //Create 4 buttons switching contents in view
    //日志
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    [post setBackgroundColor:UIColorFromRGB(0x333333)];
    post.frame = CGRectMake(0, 20, 80, 20);
    [post setTitle:@"日志" forState:UIControlStateNormal];
    [post.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: post];
    
    NSUInteger numOfpost = [UserManager getUserManager].noPost;
    NSString *postDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfpost];
    
    UIButton *postNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [postNum setBackgroundColor:UIColorFromRGB(0x333333)];
    postNum.frame = CGRectMake(0, 0, 80, 20);
    [postNum setTitle:postDetailTitle forState:UIControlStateNormal];
    postNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [postNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: postNum];
    
    //关注
    UIButton *follow = [UIButton buttonWithType:UIButtonTypeCustom];
    [follow setBackgroundColor:UIColorFromRGB(0x333333)];
    follow.frame = CGRectMake(80, 20, 80, 20);
    [follow setTitle:@"关注" forState:UIControlStateNormal];
    [follow.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: follow];
    
    NSUInteger numOfFollow = [UserManager getUserManager].noFollowing;
    NSString *followDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfFollow];
    
    UIButton *followNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [followNum setBackgroundColor:UIColorFromRGB(0x333333)];
    followNum.frame = CGRectMake(80, 0, 80, 20);
    [followNum setTitle:followDetailTitle forState:UIControlStateNormal];
    followNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [followNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: followNum];
    
    //粉丝
    UIButton *follower = [UIButton buttonWithType:UIButtonTypeCustom];
    [follower setBackgroundColor:UIColorFromRGB(0x333333)];
    follower.frame = CGRectMake(160, 20, 80, 20);
    [follower setTitle:@"粉丝" forState:UIControlStateNormal];
    [follower.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: follower];
    
    NSUInteger numOfFollower = [UserManager getUserManager].noFollower;
    NSString *followerDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfFollower];
    
    UIButton *followerNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [followerNum setBackgroundColor:UIColorFromRGB(0x333333)];
    followerNum.frame = CGRectMake(160, 0, 80, 20);
    [followerNum setTitle:followerDetailTitle forState:UIControlStateNormal];
    followerNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [followerNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: followerNum];
    
    //物品
    UIButton *things = [UIButton buttonWithType:UIButtonTypeCustom];
    [things setBackgroundColor:UIColorFromRGB(0x333333)];
    things.frame = CGRectMake(240, 20, 80, 20);
    [things setTitle:@"物品" forState:UIControlStateNormal];
    [things.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: things];
    
    NSUInteger numOfThings = [UserManager getUserManager].noItems;
    NSString *thingsDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfThings];
    
    UIButton *thingsNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [thingsNum setBackgroundColor:UIColorFromRGB(0x333333)];
    thingsNum.frame = CGRectMake(240, 0, 80, 20);
    [thingsNum setTitle:thingsDetailTitle forState:UIControlStateNormal];
    thingsNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [thingsNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: thingsNum];

    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _postList = [[NSMutableArray alloc]init];
    
    [[PostManager getPostManager]getUserPost:[UserManager getUserManager].userId range:NSMakeRange(1, [UserManager getUserManager].noPost) withDelegate:self];
    
    _postTable = [self createTableViewWithHeight:415];
    _postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_postTable registerClass:[PostCell class] forCellReuseIdentifier:CellIdentifier];
    [_postTable registerClass:[AccountCell class] forCellReuseIdentifier:CellIdentifier1];
    [self.view addSubview:_postTable];
    
}

- (void)onGetPost:(NSNumber *) isSuccess content:(NSArray *)list{
    if (isSuccess.boolValue) {
        [_postList addObjectsFromArray:list];
        [_postTable reloadData];
    }
}

- (UITableView *)createTableViewWithHeight:(CGFloat)height{
    CGFloat x = 0;
    CGFloat y = 40;
    CGFloat width = self.view.frame.size.width;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_postList count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [AccountCell cellHeight];
    }else{
        return [PostCell cellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AccountCell *cell = (AccountCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        cell.nickname.text = [NSString stringWithFormat:@"%@%@",[UserManager getUserManager].lastName,[UserManager getUserManager].firstName];
        cell.intro.text = [UserManager getUserManager].description;
        [self performSelectorInBackground:@selector(loadProfile:) withObject:cell];
        cell.color = UIColorFromRGB(0x502d25);
        [cell createContent];
        return cell;
    }else{
        PostCell *cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

//        [cell.addedTagArray addObjectsFromArray: ((PostEntity *)[_postList objectAtIndex:indexPath.row-1]).tags];
//        cell.color = UIColorFromRGB(0x502d25);
//        cell.name.text = ((PostEntity *)[_postList objectAtIndex:indexPath.row-1]).username;
//        cell.url = [NSURL URLWithString:[((PostEntity *)[_postList objectAtIndex:indexPath.row-1]).imageURLs objectAtIndex:0]];
//        [self performSelectorInBackground:@selector(loadImage:) withObject:cell];
//        [cell.desc setText:((PostEntity *)[_postList objectAtIndex:indexPath.row-1]).content];
        
        PostEntity* pe = [_postList objectAtIndex:indexPath.row-1];
        cell.post = pe;
        cell.color = UIColorFromRGB(0x502d25);
        cell.name.text = pe.username;

        [cell.desc setText:pe.content];
        [cell.addedTagArray addObjectsFromArray: pe.tags];
        cell.tagInMark = 1;
        
        [cell createContentInCell];

        [[SharedResources getResources] loadImageAtBackend:pe.imageURLs[0] storeAt:cell.firstPic];
        [[SharedResources getResources] loadImageAtBackend:pe.profileURL storeAt:cell.profilePic];
        
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        [self performSegueWithIdentifier:[NSString stringWithFormat:@"AccountToDetailPost"] sender:self];
    }
}

-(void) loadProfile:(AccountCell *)cell{
    if (!cell.profilePic.image) {
        cell.profilePic.image = [UserManager getUserManager].profile;
    }
}

-(void) loadImage:(PostCell*)cell{
    if (!cell.firstPic.image) {
        cell.firstPic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:cell.url]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
