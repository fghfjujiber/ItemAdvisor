//
//  AccountCell.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 09/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createContent];
    }
    return self;
}

-(void)createContent{
    [self getMainContent];
    [self createEditButton];
}

-(void)getTopBarButtons{
    if (!_postButton) {
        _postButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 80, 20)];
        [_postButton setBackgroundColor:UIColorFromRGB(0x333333)];
        [_postButton setTitle:@"日志" forState:UIControlStateNormal];
        [_postButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
        [self addSubview:_postButton];
    }
    
    if (!_postNum) {
        _postNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postNum setBackgroundColor:UIColorFromRGB(0x333333)];
        _postNum.frame = CGRectMake(0, 0, 80, 20);
        _postNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [_postNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [self addSubview: _postNum];
    }
    
    if (!_followButton) {
        _followButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 20, 80, 20)];
        [_followButton setBackgroundColor:UIColorFromRGB(0x333333)];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
        [self addSubview:_followButton];
    }
    
    if (!_followNum) {
        _followNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followNum setBackgroundColor:UIColorFromRGB(0x333333)];
        _followNum.frame = CGRectMake(80, 0, 80, 20);
        _followNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [_followNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [self addSubview: _followNum];
    }
    
    if (!_followerButton) {
        _followerButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 20, 80, 20)];
        [_followerButton setBackgroundColor:UIColorFromRGB(0x333333)];
        [_followerButton setTitle:@"粉丝" forState:UIControlStateNormal];
        [_followerButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
        [self addSubview:_followerButton];
    }
    
    if (!_followerNum) {
        _followerNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followerNum setBackgroundColor:UIColorFromRGB(0x333333)];
        _followerNum.frame = CGRectMake(160, 0, 80, 20);
        _followerNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [_followerNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [self addSubview: _followerNum];
    }
    
    if (!_tagButton) {
        _tagButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 20, 80, 20)];
        [_tagButton setBackgroundColor:UIColorFromRGB(0x333333)];
        [_tagButton setTitle:@"物品" forState:UIControlStateNormal];
        [_tagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
        [self addSubview:_tagButton];
    }
    
    if (!_tagNum) {
        _tagNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tagNum setBackgroundColor:UIColorFromRGB(0x333333)];
        _tagNum.frame = CGRectMake(240, 0, 80, 20);
        _tagNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [_tagNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [self addSubview: _tagNum];
    }
}

-(void)getMainContent{
    if (!_profilePic) {
        _profilePic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
        [self addSubview:_profilePic];
    }
    
    if (!_nickname) {
        _nickname = [[UILabel alloc]initWithFrame:CGRectMake(165, 60, 150, 30)];
        _nickname.textColor = [UIColor blackColor];
        _nickname.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
        _nickname.numberOfLines = 0;
        [self addSubview:_nickname];
    }
    
    if (!_intro) {
        _intro = [[UILabel alloc]initWithFrame:CGRectMake(165, 90, 150, 65)];
        _intro.textColor = [UIColor blackColor];
        _intro.font = [UIFont fontWithName:@"Trebuchet MS" size:11];
        _intro.numberOfLines = 0;
        [self addSubview:_intro];
    }
}

-(void)setColor:(UIColor *)color{
    _color = color;
    [_editButton setBackgroundColor:color];
}

-(void)createEditButton{
    if (!_editButton) {
        _editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 160, 320, 60)];
        [_editButton setTitle:@"编  辑" forState:UIControlStateNormal];
        [_editButton.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22]];
        [_editButton setBackgroundColor:_color];
        [self addSubview: _editButton];
    }
}

+(CGFloat)cellHeight{
    return 220;
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
