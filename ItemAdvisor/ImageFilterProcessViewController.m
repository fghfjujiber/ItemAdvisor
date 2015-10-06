//
//  ImageFilterProcessViewController.m
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "ImageFilterProcessViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"
#import "IphoneScreen.h"
@interface ImageFilterProcessViewController ()

@end

@implementation ImageFilterProcessViewController
@synthesize currentImage = currentImage, delegate = delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)backView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [delegate imageFitlerProcessCancel];
}
- (IBAction)fitlerDone:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
    [delegate imageFitlerProcessDone:rootImageView.image];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(10, 10, 35, 35)];
    [leftBtn addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"camera_btn_ok.png"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(275, 10, 35, 35)];
    [rightBtn addTarget:self action:@selector(fitlerDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:0.8]];
    rootImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(40, 130, 240, 240)];
    rootImageView.contentMode = UIViewContentModeScaleAspectFill;
    rootImageView.image = currentImage;
    [self.view addSubview:rootImageView];
    
    NSArray *arr = [NSArray arrayWithObjects:@"原图",@"LOMO",@"浪漫",@"光晕",@"蓝调",@"夜色",@"淡雅",@"酒红",@"青柠",@"黑白",@"复古",@"哥特",@"锐色",@"梦幻", nil];
    scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 100, 320, 100)];
    scrollerView.backgroundColor = [UIColor clearColor];
    scrollerView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.showsVerticalScrollIndicator = NO;//关闭纵向滚动条
    scrollerView.bounces = NO;
  
    float x ;
    for(int i=0;i<14;i++)
    {
        x = 10 + 76*i;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageStyle:)];
        recognizer.numberOfTouchesRequired = 1;
        recognizer.numberOfTapsRequired = 1;
        recognizer.delegate = self;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 80, 40, 25)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[arr objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setUserInteractionEnabled:YES];
        [label setTag:i];
        [label addGestureRecognizer:recognizer];
        
        [scrollerView addSubview:label];
        //[label release];
        
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 10, 65, 65)];
        [bgImageView setTag:i];
        [bgImageView addGestureRecognizer:recognizer];
        [bgImageView setUserInteractionEnabled:YES];
        UIImage *bgImage = [self setImage:i imageView:nil];
        bgImageView.image = bgImage;
        [scrollerView addSubview:bgImageView];
        //[bgImageView release];
        
        //[recognizer release];

    }
    scrollerView.contentSize = CGSizeMake(x + 80, 100);
    [self.view addSubview:scrollerView];
    
	// Do any additional setup after loading the view.
}

- (IBAction)setImageStyle:(UITapGestureRecognizer *)sender
{
    rootImageView.image =  [self changeImage:(int)sender.view.tag imageView:nil];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage *)changeImage:(int)index imageView:(UIImageView *)imageView
{
    switch (index) {
        case 0:
        {
            return currentImage;
        }
            break;
        case 1:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
           return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_langman];
        }
            break;
        case 3:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 4:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_landiao];
        }
            break;
        case 5:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_yese];
        }
            break;
        case 6:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_heibai];
        }
            break;
        case 10:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 11:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_gete];
            
        }
            break;
        case 12:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_ruise];
        
        }
            break;
        case 13:
        {
            return [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_menghuan];
            
        }
        default:
            return currentImage;
    }
}


-(UIImage *)setImage:(int)index imageView:(UIImageView *)imageView
{
    UIImage *image;
    switch (index) {
        case 0:
        {
            return [UIImage imageNamed:@"ocean_0.jpeg"];
        }
            break;
        case 1:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_langman];
        }
            break;
        case 3:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 4:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_landiao];
        }
            break;
        case 5:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_yese];
        }
            break;
        case 6:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_heibai];
        }
            break;
        case 10:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 11:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_gete];
            
        }
            break;
        case 12:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_ruise];
            
        }
            break;
        case 13:
        {
            image = [ImageUtil imageWithImage:[UIImage imageNamed:@"ocean_0.jpeg"] withColorMatrix:colormatrix_menghuan];
            
        }
    }
    return image;
}

- (void)dealloc
{
    //[super dealloc];
    scrollerView = nil;
    rootImageView = nil;
    //[currentImage release],
    currentImage  =nil;
    
}
@end
