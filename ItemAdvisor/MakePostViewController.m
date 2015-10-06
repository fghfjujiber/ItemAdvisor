//
//  MakePostViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 07/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "MakePostViewController.h"

@interface MakePostViewController ()

@end

@implementation MakePostViewController
//set cancel button pop up
- (IBAction)CancelOrDraft:(id)sender {
    NSString *draftTitle = @"保存";
    NSString *dontDraftTitle = @"不保存";
    NSString *cancelTitle = @"取消";
    NSString *contentTitle = @"要将内容放入草稿箱吗?";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:contentTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:draftTitle,dontDraftTitle, nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
}

-(void)addItemViewController:(ChooseTagViewController *)controller didFinishEnteringItems:(NSMutableArray *)items{
    if (!_addedTagArray) {
        _addedTagArray = [[NSMutableArray alloc]initWithArray:items];
        [self initTags];
        [self updateUI];
    }else{
        [_addedTagArray addObjectsFromArray:items];
        _numOfAddTag = [items count];
        [self updateTags];
        [self updateUI];
    }
}


- (void)viewDidAppear:(BOOL)animated{
    if (_picker ==nil) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
    }
    if (_elcPicker==nil) {
        _elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        _elcPicker.maximumImagesCount = 9-[_addedPicArray count];
        _elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
        _elcPicker.imagePickerDelegate = self;
    }
}
- (IBAction)sendPost:(id)sender {
    [self checkCover];
    if ([_addedPicArray count] != 0 || _tf.textStorage != nil) {
        [[PostManager getPostManager]newPost:[UserManager getUserManager].userId tagList:[self getTagEntityArray:_addedTagArray] imageList:_addedPicArray contents:[_tf.textStorage string] withDelegate:self];
    }
}

- (NSMutableArray *)getTagEntityArray:(NSMutableArray *)tagNumberArray{
    NSMutableArray *tagEntityArray = [[NSMutableArray alloc]init];
    for (int i=0; i<[tagNumberArray count]; i++) {
        UITextField *tagText = (UITextField *)[scrollview viewWithTag:200+i];
        TagEntity *tag = [[TagEntity alloc]initWithType:(NSInteger)[tagNumberArray objectAtIndex:i] Desc:tagText.text];
        [tagEntityArray addObject:tag];
    }
    return tagEntityArray;
}

- (void)onPost:(NSNumber *) isSuccess description:(NSString *)desc
{
    if ([isSuccess boolValue]) {
        UIAlertView *postDidSent = [[UIAlertView alloc]initWithTitle:@"" message:desc delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [postDidSent show];
        [self performSelector:@selector(dismiss:) withObject:postDidSent afterDelay:0.8];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *postDidSent = [[UIAlertView alloc]initWithTitle:@"" message:desc delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [postDidSent show];
        [self performSelector:@selector(dismiss:) withObject:postDidSent afterDelay:0.8];
    }
}


-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ChooseTag"]){
        ChooseTagViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // call the choose tag view first
    
    //Go to choose tag for 1st time
    if (!_addedTagArray) {
        [self performSegueWithIdentifier:[NSString stringWithFormat:@"ChooseTag"] sender:self];
    }
    
    //Create scroll view
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 504)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,[_addedTagArray count]*50+295+100);
    
    //Create gesture for scroll view to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [scrollview addGestureRecognizer:tapGesture];
    
    //-----------Tag
    
    //[self initTags];
    
    //---------------Text
    //Create textview
    if (_desc == nil) {
        _tf = [[UITextView alloc] initWithFrame:CGRectMake(10, [_addedTagArray count]*50+10, 300, 110)];
        _tf.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
        _tf.text = @"物品描述、使用心得、看法...";
        _tf.textColor = UIColorFromRGB(0xd3d3d3);
        _tf.autocorrectionType = UITextAutocorrectionTypeNo;
        _tf.keyboardType = UIKeyboardTypeDefault;
        _tf.returnKeyType = UIReturnKeyDefault;
        _tf.delegate = self;
        [scrollview addSubview:_tf];
    }else{
        [scrollview addSubview:_desc];
    }
    
    //Create a line below textview
    line = [[UILabel alloc]initWithFrame:CGRectMake(10, [_addedTagArray count]*50+10+88+30, 300, 2)];
    line.text = [NSString stringWithFormat:@""];
    line.backgroundColor = UIColorFromRGB(0xd3d3d3);
    [scrollview addSubview:line];
    
    //-------------Photo
    //Create photo horizontal scroll view
    photoScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, [_addedTagArray count]*50+10+100+30, 320, 155)];
    photoScroll.bounces = YES;
    photoScroll.delegate = self;
    photoScroll.userInteractionEnabled = YES;
    photoScroll.showsHorizontalScrollIndicator = YES;
    [scrollview addSubview:photoScroll];
    
    //Create photo arrays
    UIImage *picOne = [self resizeImageFrom:[UIImage imageNamed:@"ocean_0.jpeg"]];
    UIImage *pic2 = [self resizeImageFrom:[UIImage imageNamed:@"ocean_1.jpg"]];
    _addedPicArray = [[NSMutableArray alloc]init];
    [_addedPicArray addObject:picOne];
    [_addedPicArray addObject:pic2];
    
    //Create image views
    [self initPhotos];
    
    [photoScroll setContentSize:CGSizeMake(([_addedPicArray count]+1)*160 , 155)];
    [photoScroll setContentOffset:CGPointMake(0, 0)];
    [photoScroll scrollRectToVisible:CGRectMake(0,0,320,155) animated:NO];
    
}

//Methods for photos in horizontal scrollview
- (void)imageTapped:(UIGestureRecognizer *)gesture{
    
        [isCoverPic removeFromSuperview];
        [gesture.view addSubview:isCoverPic];

}

- (void)checkCover{
    if (isCoverPic.superview.tag != 1000) {
        [_addedPicArray exchangeObjectAtIndex:0 withObjectAtIndex:isCoverPic.superview.tag-1000];
    }
}

- (void)initPhotos
{
    for (int i = 0;i<[_addedPicArray count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[_addedPicArray objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        tap.numberOfTapsRequired = 1;
        tap.cancelsTouchesInView=YES;
        [imageView addGestureRecognizer:tap];
        
        UIButton *deleteView =[[UIButton alloc] initWithFrame:CGRectMake(100, 0, 20, 20)];
        [deleteView setBackgroundImage:[UIImage imageNamed:@"deleteIcon.png"] forState:UIControlStateNormal];
        [deleteView addTarget:self action:@selector(removePhoto:) forControlEvents:UIControlEventTouchDown];
        [deleteView setTag:2000+i];
        
        if (i == 0) {
            imageView.frame = CGRectMake(20, 20, 120, 120);
            [imageView setTag:1000+i];
            [self initPhotoCover:imageView];
        }else{
            imageView.frame = CGRectMake(160+(140 * (i-1)), 20, 120, 120);
            [imageView setTag:1000+i];
        }
        [imageView addSubview:deleteView];
        [photoScroll addSubview:imageView];
        
    }
    
    addPic = [[UIButton alloc]initWithFrame:CGRectMake(160+(140 * ([_addedPicArray count]-1)), 20, 120, 120)];
    [addPic setBackgroundImage:[UIImage imageNamed:@"addPicCamera.png"] forState:UIControlStateNormal];
    [addPic addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    [photoScroll addSubview:addPic];
    
}

- (void)initPhotoCover:(UIImageView *)firstPic{
    isCoverPic = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 40, 20)];
    isCoverPic.text = [NSString stringWithFormat:@"封面"];
    isCoverPic.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    isCoverPic.textColor = [UIColor whiteColor];
    isCoverPic.backgroundColor = [UIColor blackColor];
    isCoverPic.textAlignment = NSTextAlignmentCenter;
    [firstPic addSubview:isCoverPic];
}

- (void)addPhoto{
    
    NSString *libraryTitle = @"照片库";
    NSString *takePhotoTitle = @"相机";
    NSString *cancelTitle = @"取消";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:libraryTitle,takePhotoTitle, nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void)removePhoto:(UIButton *)sender
{
    NSInteger i = sender.tag - 2000;
    UIImageView *imageView = (UIImageView *)[photoScroll viewWithTag:1000+i];
    if ([imageView.subviews containsObject:isCoverPic]) {
        if ([_addedPicArray count] != 0) {
            UIImageView *firstPic = (UIImageView *)[photoScroll viewWithTag:1000];
            [self initPhotoCover:firstPic];
        }
    }
    [_addedPicArray removeObjectAtIndex:i];
    [imageView removeFromSuperview];
    for (NSInteger j = i+1; j<([_addedPicArray count]+1); j++) {
        UIImageView *imageView = (UIImageView *)[photoScroll viewWithTag:1000+j];
        UIButton *deleteView = (UIButton *)[photoScroll viewWithTag:2000+j];
        [deleteView setTag:2000+j-1];
        if (i == 0 && j == 1) {
            imageView.frame = CGRectMake(20, 20, 120, 120);
            [imageView setTag:1000+j-1];
            [self initPhotoCover:imageView];
        }else{
            imageView.frame = CGRectMake(160+(140 * (j-2)), 20, 120, 120);
            [imageView setTag:1000+j-1];
        }
    }
    
    //set album picker limit
    _elcPicker.maximumImagesCount = 9-[_addedPicArray count];
    
    //set addpic button
    [addPic setFrame:CGRectMake(160+(140 * ([_addedPicArray count]-1)), 20, 120, 120)];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            [self presentViewController:_elcPicker animated:YES completion:nil];
        } else if (buttonIndex == 1) {
            [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        }
    }else{
        if (buttonIndex == 0) {
            [self dismissViewControllerAnimated:self completion:nil];
        } else if (buttonIndex == 1) {
            [self dismissViewControllerAnimated:self completion:nil];
        }
    }
    
}

- (void)showImagePicker:(UIImagePickerControllerSourceType) sourceType {
    _picker.sourceType = sourceType;
    [_picker setAllowsEditing:NO];
    _picker.delegate = self;
    if (_picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        _picker.showsCameraControls = YES;
    }
    if ( [UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self presentViewController:_picker animated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];

    fitler.currentImage = [self resizeImageFrom:image];
    
    [_picker pushViewController:fitler animated:YES];
    [_picker setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

- (UIImage *)resizeImageFrom:(UIImage *)image{
    if (image.size.height > image.size.width) {
        UIGraphicsBeginImageContext(CGSizeMake(320,480));
        [image drawInRect: CGRectMake(0, 0, 320,480)];

    }else if (image.size.height == image.size.width){
        UIGraphicsBeginImageContext(CGSizeMake(320,320));
        [image drawInRect: CGRectMake(0, 0, 320,320)];

    }else if (image.size.height < image.size.width){
        UIGraphicsBeginImageContext(CGSizeMake(480,320));
        [image drawInRect: CGRectMake(0, 0, 480,320)];
    }
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return smallImage;

}

- (void)imageFitlerProcessCancel{

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    //make status bar reappear
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [_addedPicArray addObject:image];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView=YES;
    [imageView addGestureRecognizer:tap];
    
    UIButton *deleteView =[[UIButton alloc] initWithFrame:CGRectMake(100, 0, 20, 20)];
    [deleteView setBackgroundImage:[UIImage imageNamed:@"deleteIcon.png"] forState:UIControlStateNormal];
    [deleteView addTarget:self action:@selector(removePhoto:) forControlEvents:UIControlEventTouchDown];
    [deleteView setTag:2000+[_addedPicArray count]-1];
    
    if ([_addedPicArray count] == 1) {
        imageView.frame = CGRectMake(20, 20, 120, 120);
        [imageView setTag:1000+[_addedPicArray count]-1];
        [self initPhotoCover:imageView];
    }else{
        imageView.frame = CGRectMake(160+(140 * ([_addedPicArray count]-2)), 20, 120, 120);
        [imageView setTag:1000+[_addedPicArray count]-1];
    }
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView addSubview:deleteView];
    [photoScroll addSubview:imageView];
    [addPic setFrame:CGRectMake(160+(140 * ([_addedPicArray count]-1)), 20, 120, 120)];
    
    //reset the photoscroll
    [photoScroll setContentSize:CGSizeMake(([_addedPicArray count]+1)*160 , 155)];
    [photoScroll setContentOffset:CGPointMake(0, 0)];
    [photoScroll scrollRectToVisible:CGRectMake(0,0,320,155) animated:NO];
    [_picker setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //set album picker limit
    _elcPicker.maximumImagesCount = 9-[_addedPicArray count];

}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
	
	for (NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [_addedPicArray addObject:image];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        tap.numberOfTapsRequired = 1;
        tap.cancelsTouchesInView=YES;
        [imageView addGestureRecognizer:tap];
        
        UIButton *deleteView =[[UIButton alloc] initWithFrame:CGRectMake(100, 0, 20, 20)];
        [deleteView setBackgroundImage:[UIImage imageNamed:@"deleteIcon.png"] forState:UIControlStateNormal];
        [deleteView addTarget:self action:@selector(removePhoto:) forControlEvents:UIControlEventTouchDown];
        [deleteView setTag:2000+[_addedPicArray count]-1];
        
        if ([_addedPicArray count] == 1) {
            imageView.frame = CGRectMake(20, 20, 120, 120);
            [imageView setTag:1000+[_addedPicArray count]-1];
            [self initPhotoCover:imageView];
        }else{
            imageView.frame = CGRectMake(160+(140 * ([_addedPicArray count]-2)), 20, 120, 120);
            [imageView setTag:1000+[_addedPicArray count]-1];
        }
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView addSubview:deleteView];
        [photoScroll addSubview:imageView];
    
	}
    
    //set album picker limit
    _elcPicker.maximumImagesCount = 9-[_addedPicArray count];
    
    //reset the photoscroll
    [addPic setFrame:CGRectMake(160+(140 * ([_addedPicArray count]-1)), 20, 120, 120)];
    [photoScroll setContentSize:CGSizeMake(([_addedPicArray count]+1)*160 , 155)];
    [photoScroll setContentOffset:CGPointMake(0, 0)];
    [photoScroll scrollRectToVisible:CGRectMake(0,0,320,155) animated:NO];
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

//Methods for add or delete tag
- (void)initTags
{
    for (int u = 0; u <[_addedTagArray count]; u++) {
        if (u+1 == [_addedTagArray count]){
            //Create the last tag
            //label
            UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+u*50, 40, 40)];
            Views.text = [NSString stringWithFormat:@"J"];
            Views.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
            Views.textColor = [UIColor whiteColor];
            Views.backgroundColor = [UIColor grayColor];
            Views.textAlignment = NSTextAlignmentCenter;
            [Views setTag:100+u];
            [scrollview addSubview:Views];
            
            //textfield
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+u*50+3, 150, 40)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
            textField.placeholder = @"品牌、型号...";
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.delegate = self;
            [textField setTag:200+u];
            [scrollview addSubview:textField];
            
            
            //add underline
            UILabel *aline = [[UILabel alloc]initWithFrame:CGRectMake(60, (u+1)*50-2, 150, 2)];
            aline.text = [NSString stringWithFormat:@""];
            aline.backgroundColor = UIColorFromRGB(0xd3d3d3);
            [aline setTag:300+u];
            [scrollview addSubview:aline];
            
            //add tag button
            addTag = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [addTag setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            addTag.frame = CGRectMake(220, 10+u*50, 40, 40);
            [addTag setTitle:@"+" forState:UIControlStateNormal];
            [addTag.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [addTag addTarget:self action:@selector(addTags) forControlEvents:UIControlEventTouchUpInside];
            [scrollview addSubview: addTag];
            UIButton *cutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            cutTagButton.frame = CGRectMake(270, 10+u*50, 40, 40);
            [cutTagButton setTitle:@"-" forState:UIControlStateNormal];
            [cutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [cutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [cutTagButton setTag:400+u];
            [scrollview addSubview: cutTagButton];
        }else
        {
            //Create normal tag
            //label
            UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+u*50, 40, 40)];
            Views.text = [NSString stringWithFormat:@"J"];
            Views.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
            Views.textColor = [UIColor whiteColor];
            Views.backgroundColor = [UIColor grayColor];
            Views.textAlignment = NSTextAlignmentCenter;
            [Views setTag:100+u];
            [scrollview addSubview:Views];
            
            //textfield
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+u*50+3, 200, 40)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
            textField.placeholder = @"品牌、型号...";
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.delegate = self;
            [textField setTag:200+u];

            [scrollview addSubview:textField];
            
            //add underline
            UILabel *aline = [[UILabel alloc]initWithFrame:CGRectMake(60, (u+1)*50-2, 200, 2)];
            aline.text = [NSString stringWithFormat:@""];
            aline.backgroundColor = UIColorFromRGB(0xd3d3d3);
            [aline setTag:300+u];
            [scrollview addSubview:aline];
            
            //add tag button
            UIButton *cutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            cutTagButton.frame = CGRectMake(270, 10+u*50, 40, 40);
            [cutTagButton setTitle:@"-" forState:UIControlStateNormal];
            [cutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [cutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [cutTagButton setTag:400+u];
            [scrollview addSubview: cutTagButton];
        }
    }

}

-(void)addTags{
    [self performSegueWithIdentifier:[NSString stringWithFormat:@"ChooseTag"] sender:self];
}

- (void)updateTags
{
    //--Change the ex-last tag
    //textfield
    UITextField *textField = (UITextField *)[scrollview viewWithTag:200+[_addedTagArray count]-(1+_numOfAddTag)];
    [textField setFrame:CGRectMake(60, 10+([_addedTagArray count]-(1+_numOfAddTag))*50+3, 200, 40)];
    //change underline
    UILabel *aline = (UILabel *)[scrollview viewWithTag:300+[_addedTagArray count]-(1+_numOfAddTag)];
    [aline setFrame:CGRectMake(60, (([_addedTagArray count]-(1+_numOfAddTag))+1)*50-2, 200, 2)];
    
    //--Create new tags
    for (int u = 1+(int)([_addedTagArray count]-(1+_numOfAddTag)); u <[_addedTagArray count]; u++) {
        if (u+1 == [_addedTagArray count]){
            //Create the last tag
            //label
            UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+u*50, 40, 40)];
            Views.text = [NSString stringWithFormat:@"J"];
            Views.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
            Views.textColor = [UIColor whiteColor];
            Views.backgroundColor = [UIColor grayColor];
            Views.textAlignment = NSTextAlignmentCenter;
            [Views setTag:100+u];
            [scrollview addSubview:Views];
            
            //textfield
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+u*50+3, 150, 40)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
            textField.placeholder = @"品牌、型号...";
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.delegate = self;
            [textField setTag:200+u];
            [scrollview addSubview:textField];
            
            
            //add underline
            UILabel *aline = [[UILabel alloc]initWithFrame:CGRectMake(60, (u+1)*50-2, 150, 2)];
            aline.text = [NSString stringWithFormat:@""];
            aline.backgroundColor = UIColorFromRGB(0xd3d3d3);
            [aline setTag:300+u];
            [scrollview addSubview:aline];
            
            //change tag button
            addTag.frame = CGRectMake(220, 10+u*50, 40, 40);

            UIButton *cutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            cutTagButton.frame = CGRectMake(270, 10+u*50, 40, 40);
            [cutTagButton setTitle:@"-" forState:UIControlStateNormal];
            [cutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [cutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [cutTagButton setTag:400+u];
            [scrollview addSubview: cutTagButton];
        }else
        {
            //Create normal tag
            //label
            UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+u*50, 40, 40)];
            Views.text = [NSString stringWithFormat:@"J"];
            Views.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
            Views.textColor = [UIColor whiteColor];
            Views.backgroundColor = [UIColor grayColor];
            Views.textAlignment = NSTextAlignmentCenter;
            [Views setTag:100+u];
            [scrollview addSubview:Views];
            
            //textfield
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+u*50+3, 200, 40)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
            textField.placeholder = @"品牌、型号...";
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.delegate = self;
            [textField setTag:200+u];
            [scrollview addSubview:textField];
            
            //add underline
            UILabel *aline = [[UILabel alloc]initWithFrame:CGRectMake(60, (u+1)*50-2, 200, 2)];
            aline.text = [NSString stringWithFormat:@""];
            aline.backgroundColor = UIColorFromRGB(0xd3d3d3);
            [aline setTag:300+u];
            [scrollview addSubview:aline];
            
            //add tag button
            UIButton *cutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            cutTagButton.frame = CGRectMake(270, 10+u*50, 40, 40);
            [cutTagButton setTitle:@"-" forState:UIControlStateNormal];
            [cutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [cutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [cutTagButton setTag:400+u];
            [scrollview addSubview: cutTagButton];
        }
    }
    
}

- (void)updateUI
{
    _tf.frame = CGRectMake(10, [_addedTagArray count]*50+10, 300, 80+30);
    line.frame = CGRectMake(10, [_addedTagArray count]*50+10+88+30, 300, 2);
    photoScroll.frame = CGRectMake(0, [_addedTagArray count]*50+10+100+30, 320, 155);
    scrollview.contentSize = CGSizeMake(320,[_addedTagArray count]*50+295+180);
}

- (void)deleteTag:(UIButton *) sender{
    NSInteger u = (sender.frame.origin.y - 10)/50;
    if ([_addedTagArray count]!=1) {
        if (u+1 == [_addedTagArray count]) {
        //delete last object and its components
        [_addedTagArray removeLastObject];
        UILabel *Views = (UILabel *)[scrollview viewWithTag:100+u];
        [Views removeFromSuperview];
        UITextField *textField = (UITextField *)[scrollview viewWithTag:200+u];
        [textField removeFromSuperview];
        UILabel *aline = (UILabel *)[scrollview viewWithTag:300+u];
        [aline removeFromSuperview];
        UIButton *cutTagButton = (UIButton *)[scrollview viewWithTag:400+u];
        [cutTagButton  removeFromSuperview];
        //amend new last object components
        UITextField *nTextfield= (UITextField *)[scrollview viewWithTag:200+u-1];
        [nTextfield setFrame:CGRectMake(60, 10+(u-1)*50+3, 150, 40)];
        UILabel *naLine = (UILabel *)[scrollview viewWithTag:300+u-1];
        [naLine setFrame:CGRectMake(60, u*50-2, 150, 2)];
        [addTag setFrame:CGRectMake(220, 10+(u-1)*50, 40, 40)];
    }else{
        //delete the object and its components
        [_addedTagArray removeObjectAtIndex:u];
        UILabel *Views = (UILabel *)[scrollview viewWithTag:100+u];
        [Views removeFromSuperview];
        UITextField *textField = (UITextField *)[scrollview viewWithTag:200+u];
        [textField removeFromSuperview];
        UILabel *aline = (UILabel *)[scrollview viewWithTag:300+u];
        [aline removeFromSuperview];
        UIButton *cutTagButton = (UIButton *)[scrollview viewWithTag:400+u];
        [cutTagButton  removeFromSuperview];
        for (NSInteger i = u+1; i<([_addedTagArray count]+1); i++) {
            UILabel *Views = (UILabel *)[scrollview viewWithTag:100+i];
            [Views setFrame:CGRectMake(10, 10+(i-1)*50, 40, 40)];
            [Views setTag:100+i-1];
            UIButton *cutTagButton = (UIButton *)[scrollview viewWithTag:400+i];
            [cutTagButton setFrame:CGRectMake(270, 10+(i-1)*50, 40, 40)];
            [cutTagButton setTag:400+i-1];
            UITextField *textField = (UITextField *)[scrollview viewWithTag:200+i];
            [textField setTag:200+i-1];
            UILabel *aline = (UILabel *)[scrollview viewWithTag:300+i];
            [aline setTag:300+i-1];
            [addTag setFrame:CGRectMake(220, 10+(i-1)*50, 40, 40)];
            if (i==[_addedTagArray count]) {
                [textField setFrame:CGRectMake(60, 10+(i-1)*50+3, 150, 40)];
                [aline setFrame:CGRectMake(60, i*50-2, 150, 2)];
            }else{
                [textField setFrame:CGRectMake(60, 10+(i-1)*50+3, 200, 40)];
                [aline setFrame:CGRectMake(60, i*50-2, 200, 2)];
            }
        }
    }
        
        [self updateUI];
    }
}


//Override function to make placeholder for UITextView
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _tf.frame = CGRectMake(10, [_addedTagArray count]*50+10, 300, 110);
    line.frame = CGRectMake(10, [_addedTagArray count]*50+10+88+30, 300, 2);
    photoScroll.frame = CGRectMake(0, [_addedTagArray count]*50+10+100+30, 320, 155);
    scrollview.contentSize = CGSizeMake(320,[_addedTagArray count]*50+295+180);
    if(textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    photoScroll.userInteractionEnabled = NO;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    if(_tf.contentSize.height > _tf.frame.size.height){
        _tf.frame = CGRectMake(10, [_addedTagArray count]*50, 300, _tf.contentSize.height);
        line.frame = CGRectMake(10, [_addedTagArray count]*50+10+88+30+_tf.contentSize.height-110-20, 300, 2);
        photoScroll.frame = CGRectMake(0, [_addedTagArray count]*50+10+100+30+_tf.contentSize.height-110-20, 320, 155);
    }
    if([textView.text length] == 0)
    {
        textView.text = @"物品描述、使用心得、看法...";
        textView.textColor = UIColorFromRGB(0xd3d3d3);
        textView.tag = 0;
    }
    photoScroll.userInteractionEnabled = YES;
    scrollview.scrollEnabled = true;
    CGRect toVisible = CGRectMake(0, 0, 320, 504);
    [scrollview scrollRectToVisible:toVisible animated:YES];

}

- (void)textViewDidChange:(UITextView *)textView {
    CGRect rline = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = rline.origin.y + rline.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}

-(void)hideKeyboard
{
    [_tf resignFirstResponder];
    for (int i=0; i<[_addedTagArray count]; i++) {
        UITextField *textField = (UITextField *)[scrollview viewWithTag:200+i];
        [textField resignFirstResponder];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_tf resignFirstResponder];
    for (int i=0; i<[_addedTagArray count]; i++) {
        UITextField *textField = (UITextField *)[scrollview viewWithTag:200+i];
        [textField resignFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    CGFloat y = _tf.frame.origin.y-10;
    scrollview.contentOffset = CGPointMake(0, y);
}

//Override function to dismiss keyboard for uitextfield by "Done" button
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    photoScroll.userInteractionEnabled = NO;
    _tf.userInteractionEnabled = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    photoScroll.userInteractionEnabled = YES;
    _tf.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
