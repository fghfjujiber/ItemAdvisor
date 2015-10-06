//
//  FirstViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "NewsViewController.h"
#import "MakePostViewController.h"
#import "SharedResources.h"

@interface NewsViewController ()

//@property (strong,nonatomic)UIScrollView *photoScroll;
//@property (strong,nonatomic)UIPageControl *pageControl;

@end

@implementation NewsViewController

static NSString *CellIdentifier = @"CellIdentifier";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewsToDetailPost"]) {
        DetailPostViewController *vc = [segue destinationViewController];
        NSIndexPath *path = [_postTable indexPathForSelectedRow];
        vc.post = [[PostEntity alloc]init];
        vc.post = [_postList objectAtIndex:path.row];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typicsally from a nib.

    _nameArray = [[NSMutableArray alloc]init];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    
    _addedTagArray = [[NSMutableArray alloc]init];
    [_addedTagArray addObject:[NSNumber numberWithInt:100]];
    [_addedTagArray addObject:[NSNumber numberWithInt:100]];
    [_addedTagArray addObject:[NSNumber numberWithInt:100]];

    
    [[PostManager getPostManager]getPublicPostwithDelegate:self];
    
    _postList = [[NSMutableArray alloc]init];
    
    _postTable = [self createTableViewWithHeight:455];
    _postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_postTable registerClass:[PostCell class] forCellReuseIdentifier:CellIdentifier];
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
    CGFloat y = 0;
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
    return [_postList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PostCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    PostEntity* pe = [_postList objectAtIndex:indexPath.row];
    cell.post = pe;
    cell.color = UIColorFromRGB(0x2a477a);
    cell.name.text = pe.username;
    
    [cell.desc setText:pe.content];
    [cell.addedTagArray addObjectsFromArray: pe.tags];
    cell.tagInMark = 1;

    [cell createContentInCell];
    
    [[SharedResources getResources] loadImageAtBackend:pe.imageURLs[0] storeAt:cell.firstPic];
    [[SharedResources getResources] loadImageAtBackend:pe.profileURL storeAt:cell.profilePic];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:[NSString stringWithFormat:@"NewsToDetailPost"] sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
