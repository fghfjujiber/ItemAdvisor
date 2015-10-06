//
//  TabBarViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 10/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "TabBarViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

    switch (item.tag) {
        case 1:
            [tabBar setBarTintColor:UIColorFromRGB(0xbfe5e5)];
            [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xbfe5e5)];
            break;
        case 2:
            [tabBar setBarTintColor:UIColorFromRGB(0xd2d2d2)];
            [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xd2d2d2)];
            break;
        case 3:
            [tabBar setBarTintColor:UIColorFromRGB(0x502d25)];
            [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x502d25)];
            break;
        default:
            [tabBar setBarTintColor:UIColorFromRGB(0x2a477a)];
            [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x2a477a)];
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self.tabBar.items objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"news"] withFinishedUnselectedImage:[UIImage imageNamed:@"news"]];
    [[self.tabBar.items objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"search"] withFinishedUnselectedImage:[UIImage imageNamed:@"search"]];
    [[self.tabBar.items objectAtIndex:2] setFinishedSelectedImage:[UIImage imageNamed:@"msg"] withFinishedUnselectedImage:[UIImage imageNamed:@"msg"]];
    [[self.tabBar.items objectAtIndex:3] setFinishedSelectedImage:[UIImage imageNamed:@"account"] withFinishedUnselectedImage:[UIImage imageNamed:@"account"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
