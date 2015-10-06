//
//  SecondViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "SearchViewController.h"
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from
    _searchBar.delegate = self;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, 411)];
    _scrollView.contentSize = CGSizeMake(320, 416);
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //Create gesture for scroll view to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditSearch)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    [_scrollView addGestureRecognizer:tapGesture];

}

- (void)endEditSearch{
    [_searchBar resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
