//
//  DetailPostViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "DetailPostViewController.h"

@interface DetailPostViewController ()

@end

@implementation DetailPostViewController
- (IBAction)backToPreviousView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
