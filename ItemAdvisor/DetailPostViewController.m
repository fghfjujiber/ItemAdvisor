//
//  DetailPostViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "DetailPostViewController.h"

@interface DetailPostViewController ()

@property CGFloat preImageY;
@property CGFloat myComY;
@property CGFloat preComY;
@property CGFloat preLikeY;

@end

@implementation DetailPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //-----------Create 3 buttons on the top
    _textButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 107, 50)];
    [_textButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _textButton];
    _textButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 107, 15)];
    _textButtonText.text = @"文字";
    _textButtonText.textColor = [UIColor whiteColor];
    _textButtonText.textAlignment = NSTextAlignmentCenter;
    [_textButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_textButton addSubview:_textButtonText];
    _textButtonLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"text"]];
    _textButtonLogo.frame = CGRectMake(44.5, 13, 18, 15);
    [_textButton addSubview:_textButtonLogo];
    
    _picButton = [[UIButton alloc]initWithFrame:CGRectMake(107, 0, 107, 50)];
    [_picButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _picButton];
    _picButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 107, 15)];
    _picButtonText.text = @"图片";
    _picButtonText.textColor = [UIColor whiteColor];
    _picButtonText.textAlignment = NSTextAlignmentCenter;
    [_picButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_picButton addSubview:_picButtonText];
    _picButtonLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"picture"]];
    _picButtonLogo.frame = CGRectMake(44.5, 13, 18, 15);
    [_picButton addSubview:_picButtonLogo];
    
    _comButton = [[UIButton alloc]initWithFrame:CGRectMake(213, 0, 107, 50)];
    [_comButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _comButton];
    _comButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 107, 15)];
    _comButtonText.text = @"评论";
    _comButtonText.textColor = [UIColor whiteColor];
    _comButtonText.textAlignment = NSTextAlignmentCenter;
    [_comButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_comButton addSubview:_comButtonText];
    _comButtonLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment"]];
    _comButtonLogo.frame = CGRectMake(44.5, 13, 18, 15);
    [_comButton addSubview:_comButtonLogo];
    
    //create scrollview
    _mainContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, 320, 405)];
    _mainContent.showsVerticalScrollIndicator=YES;
    _mainContent.scrollEnabled=YES;
    _mainContent.userInteractionEnabled=YES;
    _mainContent.delegate = self;
    [self.view addSubview:_mainContent];
    _mainContent.contentSize = CGSizeMake(320,[self contentHeight]);

    //--------load profilePic
    [self performSelectorInBackground:@selector(createAndLoadProfile) withObject:nil];
    
    //-----------username and time
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(67, 14, 270, 25)];
    name.text = _post.username;
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentLeft;
    [name setFont:[UIFont fontWithName:@"Trebuchet MS" size:18]];
    [_mainContent  addSubview:name];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(67, 44, 100, 12)];
    time.text = [NSString stringWithFormat:@"08/08/2014"];
    time.backgroundColor = [UIColor clearColor];
    time.textColor = [UIColor blackColor];
    time.textAlignment = NSTextAlignmentLeft;
    [time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [_mainContent  addSubview:time];
    
    //------------descriptions
    _desc = [[UITextView alloc]initWithFrame:CGRectMake(5, 66, 310, 20)];
    _desc.editable = NO;
    _desc.scrollEnabled = NO;
    [_desc setFont:[UIFont fontWithName:@"Trebuchet MS" size:16]];
    _desc.text = _post.content;
    _desc.delegate = self;
    [_desc sizeToFit];
    [_mainContent addSubview:_desc];
    
    //Create gesture for scroll view to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditDesc)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    [_mainContent addGestureRecognizer:tapGesture];
    
    //-------------Display images
    _picArray = [[NSMutableArray alloc]init];
    [_picArray addObject:[UIImage imageNamed:@"car_v.jpg"]];
    [_picArray addObject:[UIImage imageNamed:@"car_p.jpg"]];
    [_picArray addObject:[UIImage imageNamed:@"choco_1.jpg"]];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 106, 320, [self getImageHeight:[UIImage imageNamed:@"car_v.jpg"]])];
    imageV.backgroundColor = [UIColor clearColor];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [UIImage imageNamed:@"car_v.jpg"];
    [_mainContent addSubview:imageV];
    
    UIImageView *imageP = [[UIImageView alloc]initWithFrame:CGRectMake(0, 587, 320, [self getImageHeight:[UIImage imageNamed:@"car_p.jpg"]])];
    imageP.backgroundColor = [UIColor clearColor];
    imageP.contentMode = UIViewContentModeScaleAspectFit;
    imageP.image = [UIImage imageNamed:@"car_p.jpg"];
    [_mainContent addSubview:imageP];
    
    for (int i=0; i<[_picArray count]; i++) {
        if (i==0) {
            UIImageView *image = [[UIImageView alloc]initWithImage:[_picArray objectAtIndex:i]];
            image.backgroundColor = [UIColor clearColor];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.frame = CGRectMake(0, 106, 320, [self getImageHeight:image.image]);
            [_mainContent addSubview:image];
            _preImageY = image.frame.origin.y+image.frame.size.height;
        }else{
            UIImageView *image = [[UIImageView alloc]initWithImage:[_picArray objectAtIndex:i]];
            image.backgroundColor = [UIColor clearColor];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.frame = CGRectMake(0, _preImageY, 320, [self getImageHeight:image.image]);
            [_mainContent addSubview:image];
            _preImageY = image.frame.origin.y+image.frame.size.height;
        }
    }
    
    //------Comment and like parts
    _comment = [[UIButton alloc]initWithFrame:CGRectMake(0, _preImageY+10, 160, 80)];
    [_comment setTitle:@"评 论" forState:UIControlStateNormal];
    [_comment.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]];
    [_comment setBackgroundColor:UIColorFromRGB(0xACDFF5)];
    [_comment addTarget:self action:@selector(touchComment) forControlEvents:UIControlEventTouchUpInside];
    [_mainContent addSubview: _comment];
    
    _likes = [[UIButton alloc]initWithFrame:CGRectMake(160, _preImageY+10, 160, 80)];
    [_likes setTitle:@"赞" forState:UIControlStateNormal];
    [_likes.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]];
    [_likes setBackgroundColor:UIColorFromRGB(0xFD9196)];
    [_likes addTarget:self action:@selector(touchLike) forControlEvents:UIControlEventTouchUpInside];
    [_mainContent addSubview: _likes];
    
    [self createMyCommentButton];
    [self createCommentButtonsBy:_comArray];
    
    //comments part
    _comArray = [[NSMutableArray alloc]init];
    [_comArray addObject:[UIImage imageNamed:@"car_v.jpg"]];
    [_comArray addObject:[UIImage imageNamed:@"car_p.jpg"]];
    [_comArray addObject:[UIImage imageNamed:@"choco_1.jpg"]];
    
    [self createCommentButtonsBy:_comArray];
    
    _likesArray = [[NSMutableArray alloc]init];
    [_likesArray addObject:[UIImage imageNamed:@"car_v.jpg"]];
    [_likesArray addObject:[UIImage imageNamed:@"car_p.jpg"]];
    [_likesArray addObject:[UIImage imageNamed:@"choco_1.jpg"]];

}

- (void)createMyCommentButton{
    _myCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _preImageY+90, 320, 50)];
    _myCommentLabel.backgroundColor = UIColorFromRGB(0xACDFF5);
    _myCommentLabel.userInteractionEnabled = YES;
    [_mainContent addSubview:_myCommentLabel];
    _myComY = _myCommentLabel.frame.origin.y+_myCommentLabel.frame.size.height;
    
    _myComment = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 250, 30)];
    _myComment.clearButtonMode = UITextFieldViewModeWhileEditing;
    _myComment.backgroundColor = [UIColor whiteColor];
    _myComment.placeholder = [NSString stringWithFormat:@" 写评论..."];
    _myComment.borderStyle = UITextBorderStyleNone;
    _myComment.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    _myComment.returnKeyType = UIReturnKeyDone;
    _myComment.delegate = self;
    [_myCommentLabel addSubview:_myComment];
    
    _sendComment = [[UIButton alloc]initWithFrame:CGRectMake(270, 10, 40, 30)];
    [_sendComment setTitle:@"发表" forState:UIControlStateNormal];
    [_sendComment.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:15]];
    [_sendComment setBackgroundColor:UIColorFromRGB(0x8FABB8)];
    [_myCommentLabel addSubview: _sendComment];
}

- (void)createCommentButtonsBy:(NSMutableArray *)array{
    for (int i=0; i<[array count]; i++) {
        if (i==0) {
            UILabel *comment = [[UILabel alloc]initWithFrame:CGRectMake(0, _myComY, 320, 60)];
            comment.backgroundColor = [UIColor whiteColor];
            [self createContentIn:comment];
            _preComY = comment.frame.origin.y+comment.frame.size.height;
            [_mainContent addSubview:comment];
            comment.tag = 100+i;
        }else{
            UILabel *comment = [[UILabel alloc]initWithFrame:CGRectMake(0, _preComY, 320, 60)];
            comment.backgroundColor = [UIColor whiteColor];
            [self createContentIn:comment];
            _preComY = comment.frame.origin.y+comment.frame.size.height;
            [_mainContent addSubview:comment];
            comment.tag = 100+i;
        }
    }
}

- (void)createContentIn:(UILabel *)label{
    UIImageView *profile = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 32, 32)];
    profile.image = [UIImage imageNamed:@"sky.jpg"];
    [label addSubview:profile];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(52, 11, 178, 14)];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor blackColor];
    name.text = [NSString stringWithFormat:@"小明Jack"];
    name.textAlignment = NSTextAlignmentLeft;
    [name setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [label  addSubview:name];
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(52, 32, 178, 16)];
    text.backgroundColor = [UIColor clearColor];
    text.textColor = [UIColor blackColor];
    text.text = [NSString stringWithFormat:@"我擦!!!!!"];
    text.textAlignment = NSTextAlignmentLeft;
    [text setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [label  addSubview:text];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(240, 3, 70, 5)];
    time.backgroundColor = [UIColor clearColor];
    time.textColor = [UIColor blackColor];
    time.text = [NSString stringWithFormat:@"8/8/2014 14:00"];
    time.textAlignment = NSTextAlignmentRight;
    time.numberOfLines = 2;
    [time sizeToFit];
    time.lineBreakMode = NSLineBreakByWordWrapping;
    [time setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [label  addSubview:time];
}

- (void)createlikeButtonsBy:(NSMutableArray *)array{
    for (int i=0; i<[array count]; i++) {
        if (i==0) {
            UILabel *liker = [[UILabel alloc]initWithFrame:CGRectMake(0, _likes.frame.origin.y+_likes.frame.size.height, 320, 60)];
            liker.backgroundColor = UIColorFromRGB(0xFD9196);
            _preLikeY = liker.frame.origin.y+liker.frame.size.height;
            [_mainContent addSubview:liker];
            liker.tag = 200+i;
        }else{
            UILabel *liker = [[UILabel alloc]initWithFrame:CGRectMake(0, _preLikeY, 320, 60)];
            liker.backgroundColor = UIColorFromRGB(0xFD9196);
            _preLikeY = liker.frame.origin.y+liker.frame.size.height;
            [_mainContent addSubview:liker];
            liker.tag = 200+i;
        }
    }
}

- (void)touchComment{
    [self removeLikePart];
    [self createMyCommentButton];
    [self createCommentButtonsBy:_comArray];
}

- (void)touchLike{
    [self removeCommentPart];
    [self createlikeButtonsBy:_likesArray];
}

- (void)removeCommentPart{
    [_myCommentLabel removeFromSuperview];
    [_myComment removeFromSuperview];
    [_sendComment removeFromSuperview];
    for (int i=0; i<[_comArray count]; i++) {
        UILabel *comment = (UILabel *)[_mainContent viewWithTag:100+i];
        [comment removeFromSuperview];
    }
}

- (void)removeLikePart{
    for (int i=0; i<[_likesArray count]; i++) {
        UILabel *liker = (UILabel *)[_mainContent viewWithTag:200+i];
        [liker removeFromSuperview];
    }
}


//Adjust imageview height
- (CGFloat)getImageHeight:(UIImage *)image{
    if (image.size.height > image.size.width) {
        return 480;
    }else if (image.size.height == image.size.width){
        return 320;
    }else{
        return 214;
    }
}
- (void)endEditDesc{
    [_desc resignFirstResponder];
    [_myComment resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_desc resignFirstResponder];
    [_myComment resignFirstResponder];
}

- (void)createAndLoadProfile{
    UIImageView *profilePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 46, 46)];
    profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_post.profileURL]]]];
    [_mainContent addSubview:profilePic];
}

- (CGFloat)contentHeight{
    return 2500;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//Override function to dismiss keyboard for uitextfield by "Done" button
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];
    CGFloat y = _myCommentLabel.frame.origin.y;
    _mainContent.contentOffset = CGPointMake(0, y);
    [UIView commitAnimations];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
