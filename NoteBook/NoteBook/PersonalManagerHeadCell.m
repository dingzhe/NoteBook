//
//  PersonalManagerHeadCell.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalManagerHeadCell.h"
#import "UIImage+DzNote.h"
#import "UIImageView+AFNetworking.h"

@interface PersonalManagerHeadCell ()

@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UIImageView *photoImgView;

@end

@implementation PersonalManagerHeadCell
@dynamic viewModel;

- (void)initCell {
    [super initCell];
    
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_bgImgView setImage:[UIImage imageNamed:@"bg_resume_head.png"]];
    [self.contentView addSubview:_bgImgView];
    
    _headImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_headImgView setImage:[UIImage imageNamed:@"ic_resume_head.png"]];
    [self.contentView addSubview:_headImgView];
    
    _photoImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_photoImgView setImage:[UIImage imageNamed:@"ic_resume_camera.png"]];
    _headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_photoImgView];
    
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headBtn setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_headBtn];
    
    _userNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_userNameLab setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_userNameLab];
    
    
    _emailLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_emailLab setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_emailLab];
    
    _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_previewBtn setTitle:@"我的博客" forState:UIControlStateNormal];
    [_previewBtn.titleLabel setFont:[UIFont largeFont]];
    [_previewBtn setTitleColor:[UIColor darkGrayTextColor] forState:UIControlStateNormal];
    [_previewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_previewBtn setBackgroundImage:[UIImage grayBtnNormalImage] forState:UIControlStateNormal];
    [self.contentView addSubview:_previewBtn];
    
    _browseHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_browseHistoryBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    [_browseHistoryBtn.titleLabel setFont:[UIFont largeFont]];
    [_browseHistoryBtn setTitleColor:[UIColor darkGrayTextColor] forState:UIControlStateNormal];
    [_browseHistoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_browseHistoryBtn setBackgroundImage:[UIImage grayBtnNormalImage] forState:UIControlStateNormal];
    [self.contentView addSubview:_browseHistoryBtn];
//    _userNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
//    [_userNameLab setBackgroundColor:[UIColor clearColor]];
//    [self.contentView addSubview:_userNameLab];
//    
//    
//    _emailLab = [[UILabel alloc]initWithFrame:CGRectZero];
//    [_emailLab setBackgroundColor:[UIColor clearColor]];
//    [self.contentView addSubview:_emailLab];
    
    
    
    
    
}


- (void)updateWithViewModel:(PersonalManagerHeadCellViewModel *)viewModel {
    [super updateWithViewModel:viewModel];
    _userNameLab.attributedText = viewModel.username;
    _emailLab.attributedText = viewModel.email;
    [_headImgView setImageWithURL:[NSURL URLWithString:viewModel.headImgUrl] placeholderImage:[UIImage imageNamed:@"ic_resume_head.png"]];
}


- (void) layoutSubviews {
    [super layoutSubviews];
    _userNameLab.frame = self.viewModel.usrnameFrame;
    _emailLab.frame = self.viewModel.emailFrame;
    _bgImgView.frame = self.viewModel.bgImgFrame;
    _headImgView.frame = self.viewModel.headImgFrame;
    _headImgView.layer.cornerRadius = _headImgView.frame.size.width/2;
    _photoImgView.frame = self.viewModel.photoImgFrame;
    _previewBtn.frame = self.viewModel.previewBtnFrame;
    _browseHistoryBtn.frame = self.viewModel.browseHistoryBtnFrame;
    _headBtn.frame = self.viewModel.headImgFrame;
    
}

@end
