//
//  PostCell.m
//  PostTableView
//
//  Created by Xiaoming Chen on 06/04/2014.
//  Copyright (c) 2014 Xiaoming Chen. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createContentInCell];
        _tagInMark = 0;
        _likeMark = 0;
    }
    return self;
}

-(void)createContentInCell{
    [self createTagArray];
    [self createTopPartWithColor:_color];
    if (_tagInMark) {
        [self createMiddlePart];
        [self createBottomPart];
    }
}

-(void)createTagArray{
    if (!_addedTagArray) {
        _addedTagArray = [[NSMutableArray alloc]init];
    }
    if (!_tagsWithText) {
        _tagsWithText = [[NSMutableArray alloc]init];
    }
    if (!_tagsWithoutText) {
        _tagsWithoutText = [[NSMutableArray alloc]init];
    }
}

-(void)setColor:(UIColor *)color{
    _color = color;
    [_toAccountViewButton setBackgroundColor:color];
}

-(void)createTopPartWithColor:(UIColor *)color{
    //头像，名字，和进入个人主页的按键
    if (!_toAccountViewButton) {
        _toAccountViewButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 0, 180, 50)];
        [self addSubview:_toAccountViewButton];
    }
    if (!_profilePic) {
        _profilePic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_toAccountViewButton addSubview:_profilePic];
    }
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 25)];
        _name.textColor = [UIColor whiteColor];
        _name.textAlignment = NSTextAlignmentLeft;
        [_name setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [_toAccountViewButton  addSubview:_name];
    }
    if (!_time) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
        _time.textColor = [UIColor lightGrayColor];
        _time.textAlignment = NSTextAlignmentLeft;
        [_time setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        _time.text = @"2天前";
        [self addSubview:_time];
    }
}

-(void)createMiddlePart{
    //物品标签，包括小图标和文字
    UILabel *truthTagWithText = (UILabel *)[self viewWithTag:100];
    UILabel *truthTagWithoutText = (UILabel *)[self viewWithTag:200];
    
    if (!truthTagWithText && !truthTagWithoutText){
        
        [self splitTagsArray];
        
        for (int i=0; i<[_tagsWithText count]; i++) {
            TagEntity *theTag = [[TagEntity alloc]init];
            theTag = [_tagsWithText objectAtIndex:i];
            
            UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(15, 55+30*i, 20, 20)];
            tag.backgroundColor = [UIColor lightGrayColor];
            tag.layer.cornerRadius = 10.0;
            tag.tag = 100+i;
            [self addSubview:tag];
            UILabel *tagDescription = [[UILabel alloc]initWithFrame:CGRectMake(45, 55+30*i, 255, 20)];
            tagDescription.text = theTag.description;
            tagDescription.textAlignment = NSTextAlignmentLeft;
            [tagDescription setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
            
            _prevTagY = tag.frame.origin.y+20;
        }
    //}
    //if (!truthTagWithText && !truthTagWithoutText) {
        for (int i=0; i<[_tagsWithoutText count]; i++) {
            UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(15+35*i, 145, 20, 20)];
            tag.backgroundColor = [UIColor lightGrayColor];
            tag.layer.cornerRadius = 10.0;
            tag.tag = 200+i;
            [self addSubview:tag];
            NSLog(@"no text in tags");
            
            _prevTagY = tag.frame.origin.y+20;
        }
    }
    //图片
    if (!_firstPic) {
        _firstPic = [[UIImageView alloc]init];
        _firstPic.contentMode = UIViewContentModeScaleAspectFill;
        _firstPic.clipsToBounds = YES;
        if ([_addedTagArray count]) {
            _firstPic.frame = CGRectMake(15, _prevTagY+15, 160, [self getImageHeight:_firstPic.image]);
        }else{
            _firstPic.frame = CGRectMake(15, 85, 160, [self getImageHeight:_firstPic.image]);
        }
        [self addSubview:_firstPic];
            
        _prevImgY = _firstPic.frame.origin.y+_firstPic.frame.size.height+5;
    }
    //文字叙述
    if (!_desc){
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(15, _prevImgY+10, 290, 15)];
        _desc.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _desc.textColor = [UIColor blackColor];
        _desc.textAlignment = NSTextAlignmentLeft;
        _desc.numberOfLines = 0;
        [self addSubview:_desc];
        
        _prevTxtY = _desc.frame.origin.y+_desc.frame.size.height+5;
    }
}

-(void)createBottomPart{
    //先模拟几个数量
    int NumOfReads = 888;
    int NumOfLikes = 689;
    int NumOfCommts = 389;
    
    //浏览，赞，评论的数量
    CGFloat upperY = _prevTxtY+10;
    if (!_readButton) {
        _readButton = [[UIButton alloc]initWithFrame:CGRectMake(0, upperY, 107, 42)];
        _readButton.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [self addSubview:_readButton];
    }
    if (!_readLogo) {
        _readLogo = [[UILabel alloc]initWithFrame:CGRectMake(30, 12, 30, 15)];
        _readLogo.text = @"浏览";
        _readLogo.textColor = [UIColor lightGrayColor];
        _readLogo.textAlignment = NSTextAlignmentCenter;
        [_readLogo setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        [_readButton addSubview:_readLogo];
    }
    if (!_readLogoText) {
        _readLogoText = [[UILabel alloc]initWithFrame:CGRectMake(55, 12, 35, 15)];
        _readLogoText.text = [NSString stringWithFormat:@"%d",NumOfReads];
        _readLogoText.textColor = [UIColor lightGrayColor];
        _readLogoText.textAlignment = NSTextAlignmentCenter;
        [_readLogoText setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        [_readButton addSubview:_readLogoText];
    }
    
    if (!_likeButton) {
        _likeButton = [[UIButton alloc]initWithFrame:CGRectMake(107, upperY, 106, 42)];
        _likeButton.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [_likeButton addTarget:self action:@selector(likeButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeButton];
    }
    if (!_likeLogo) {
        _likeLogo = [[UILabel alloc]initWithFrame:CGRectMake(35, 12, 15, 15)];
        _likeLogo.text = @"赞";
        _likeLogo.textColor = [UIColor lightGrayColor];
        _likeLogo.textAlignment = NSTextAlignmentCenter;
        [_likeLogo setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        [_likeButton  addSubview:_likeLogo];
    }
    if (!_likeLogoText) {
        _likeLogoText = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, 35, 15)];
        _likeLogoText.text = [NSString stringWithFormat:@"%d",NumOfLikes];
        _likeLogoText.textColor = [UIColor lightGrayColor];
        _likeLogoText.textAlignment = NSTextAlignmentCenter;
        [_likeLogoText setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        [_likeButton addSubview:_likeLogoText];
    }
    
    if (!_commentButton) {
        _commentButton = [[UIButton alloc]initWithFrame:CGRectMake(213, upperY, 107, 42)];
        _commentButton.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [self addSubview:_commentButton];
    }
    if (!_commentLogo) {
        _commentLogo = [[UILabel alloc]initWithFrame:CGRectMake(30, 12, 30, 15)];
        _commentLogo.text = @"评论";
        _commentLogo.textColor = [UIColor lightGrayColor];
        _commentLogo.textAlignment = NSTextAlignmentCenter;
        [_commentLogo setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        [_commentButton addSubview:_commentLogo];
    }
    if (!_commentLogoText) {
        _commentLogoText = [[UILabel alloc]initWithFrame:CGRectMake(55, 12, 35, 15)];
        _commentLogoText.text = [NSString stringWithFormat:@"%d",NumOfCommts];
        _commentLogoText.textColor = [UIColor lightGrayColor];
        _commentLogoText.textAlignment = NSTextAlignmentCenter;
        [_commentLogoText setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
        [_commentButton addSubview:_commentLogoText];
    }
}

- (CGFloat)getImageHeight:(UIImage *)image{
    if (image.size.height > image.size.width) {
        return 240;
    }else if (image.size.height == image.size.width){
        return 160;
    }else{
        return 107;
    }
}

-(void)splitTagsArray{
    if (_addedTagArray) {
        for (int i=0; i<[_addedTagArray count]; i++) {
            TagEntity *theTag = [[TagEntity alloc]init];
            theTag = [_addedTagArray objectAtIndex:i];
            if (!theTag.description.length) {
                [_tagsWithoutText addObject:theTag];
            }else{
                [_tagsWithText addObject:theTag];
            }
        }
    }
}

-(void)likeButtonTouched{
    if (!_likeMark) {
        _likeMark = 1;
        _likeButton.backgroundColor = _color;
        _likeLogoText.textColor = [UIColor whiteColor];
        _likeLogo.textColor = [UIColor whiteColor];
    }else{
        _likeMark = 0;
        _likeButton.backgroundColor = UIColorFromRGB(0xe8e8e8);
        _likeLogoText.textColor = [UIColor lightGrayColor];
        _likeLogo.textColor = [UIColor lightGrayColor];
    }
}

+(CGFloat)cellHeight{
    return 380;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
