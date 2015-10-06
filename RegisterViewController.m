//
//  RegisterViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (strong,nonatomic) UIImagePickerController *picker;
@property (strong,nonatomic) XWPhotoEditorViewController *photoEditor;
@end

@implementation RegisterViewController

- (IBAction)backToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)handInForm:(id)sender {
    if ([self checkLocal]) {
        [self checkOnline];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_nickName becomeFirstResponder];
    
}



//- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
//{
//    for (UIView *subview in actionSheet.subviews) {
//        if ([subview isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)subview;
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self registerView] endEditing:YES];
}
- (IBAction)editProfileImage:(id)sender {

    NSString *libraryTitle = @"照片库";
    NSString *takePhotoTitle = @"相机";
    NSString *cancelTitle = @"取消";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:libraryTitle,takePhotoTitle, nil];
    [actionSheet showInView:_registerView];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _photoEditor = [[XWPhotoEditorViewController alloc] initWithNibName:@"XWPhotoEditorViewController" bundle:nil];
    
    // set photo editor value
    _photoEditor.panEnabled = YES;
    _photoEditor.scaleEnabled = YES;
    _photoEditor.tapToResetEnabled = YES;
    _photoEditor.rotateEnabled = NO;
    _photoEditor.delegate = self;
    // crop window's value
    _photoEditor.cropSize = CGSizeMake(300, 300);
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.photoEditor.sourceImage = [self resizeImage:image toSize:CGSizeMake(900, 1200)];
    
        [picker pushViewController:self.photoEditor animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];


}

-(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    float width = size.width;
    float height = size.height;
    
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (void)finish:(UIImage *)image didCancel:(BOOL)cancel {
    if (!cancel) {
        _profileImageBig = image;
        [_picker dismissViewControllerAnimated:NO completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        [self presentfilter];
        }];
    }else{
        [_picker dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)presentfilter{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = _profileImageBig;
    [self presentViewController:fitler animated:YES completion:nil];
}

- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    //make status bar reappear
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    _profileImageBig = image;
    _profileImageSmall = [self resizeImage:image toSize:CGSizeMake(120, 120)];
    
    [_profilePicButton setBackgroundImage:_profileImageSmall forState:UIControlStateNormal];
    [_profilePicButton setTitle:@"" forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    } else if (buttonIndex == 1) {
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == _nickName) {
        [_emailAddress becomeFirstResponder];
    }else if (textField == _emailAddress) {
        [_createdPassword becomeFirstResponder];
    }else if (textField == _createdPassword){
        [_confirmedPassword becomeFirstResponder];
    }
    return YES;
}

- (BOOL)checkLocal
{
    NSString *passwordInValid = @"密码长度不对；";
    NSString *passwordNotMatched = @"密码不相同；";
    NSString *emailAddressInvalid = @"邮箱地址格式不对；";
    NSString *nickNameInvalid = @"昵称格式不对；";
    NSMutableString *errorContent = [NSMutableString stringWithFormat:@""];
   
    if (![self checkEmailAddress]) {
            [errorContent appendString:emailAddressInvalid];
    }
    if (![self checkNickName]) {
        [errorContent appendString:nickNameInvalid];
    }
    if (![self checkFirstPassword]) {
        [errorContent appendString:passwordInValid];
    }
    if (![self checkTwoPasswords]) {
        [errorContent appendString:passwordNotMatched];
    }
    
    if (![self checkEmailAddress] || ![self checkFirstPassword] || ![self checkTwoPasswords] || ![self checkNickName]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"出错" message: errorContent delegate: _registerView cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }else{
        return TRUE;
    }
}

-(BOOL)checkFirstPassword
{
    if (_createdPassword.text.length > 25 || _createdPassword.text.length <6) {
        return FALSE;
    }else{
        return TRUE;
    }
}

- (BOOL)checkTwoPasswords
{
    if (_createdPassword.text == _confirmedPassword.text) {
        return FALSE;
    }else{
        return TRUE;
    }
}

- (BOOL)checkEmailAddress
{
    if ([_emailAddress.text rangeOfString:@"@"].location != NSNotFound && [_emailAddress.text rangeOfString:@"."].location != NSNotFound) {
        return TRUE;
    }
    else{
        return FALSE;
    }

}

- (BOOL)checkNickName
{
    if (_nickName.text.length > 10 || _nickName.text.length == 0) {
        return FALSE;
    }else{
        return TRUE;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _emailAddress)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }else if(textField == _createdPassword || _confirmedPassword){
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
        else return YES;
}

- (void)checkOnline
{
    [[UserManager getUserManager] registerUser:_emailAddress.text password:_createdPassword.text nickname:_nickName.text image:_profileImageBig withDelegate:self];
}

- (void)onRegistUser:(NSNumber *) isSuccess description:(NSString *)desc
{
    if (![isSuccess boolValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"出错" message: desc delegate: _registerView cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        [[UserManager getUserManager] loginAs:_emailAddress.text withPassword:_createdPassword.text withDelegate:self];
    }
}

- (void)onLogin:(NSDictionary *)response {
    if ([[UserManager getUserManager] isAuthenticated]) {
        [self performSegueWithIdentifier:@"finishRegister" sender:self];
    }
}

@end












