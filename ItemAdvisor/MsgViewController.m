//
//  SecondViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "MsgViewController.h"

@interface MsgViewController ()

@end

@implementation MsgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //-----------Create 3 buttons on the top
    _newsButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 50)];
    [_newsButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _newsButton];
    _newsButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 160, 15)];
    _newsButtonText.text = @"通 知";
    _newsButtonText.textColor = [UIColor whiteColor];
    _newsButtonText.textAlignment = NSTextAlignmentCenter;
    [_newsButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_newsButton addSubview:_newsButtonText];
    _newsButtonLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notification"]];
    _newsButtonLogo.frame = CGRectMake(68, 6, 24, 24);
    [_newsButton addSubview:_newsButtonLogo];
    
    
    _msgButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 0, 160, 50)];
    [_msgButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _msgButton];
    _msgButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 160, 15)];
    _msgButtonText.text = @"私 信";
    _msgButtonText.textColor = [UIColor whiteColor];
    _msgButtonText.textAlignment = NSTextAlignmentCenter;
    [_msgButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_msgButton addSubview:_msgButtonText];
    _msgButtonLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"msg"]];
    _msgButtonLogo.frame = CGRectMake(68, 6, 24, 24);
    [_msgButton addSubview:_msgButtonLogo];
    
    
    
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
    return [_contactArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
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
