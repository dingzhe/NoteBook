//
//  CommonTextCell.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CommonTextCell.h"

@interface CommonTextCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *subTitleLab;
@property (nonatomic,strong) UILabel *detailTitleLab;

@end

@implementation CommonTextCell
@dynamic viewModel;

- (void)initCell {
    [super initCell];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_titleLab setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_titleLab];
    
    _subTitleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_subTitleLab setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_subTitleLab];
    
    _detailTitleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_detailTitleLab setBackgroundColor:[UIColor clearColor]];
    _detailTitleLab.numberOfLines = 0;
    [self.contentView addSubview:_detailTitleLab];
    
    _switchbtn = [[UISwitch alloc]initWithFrame:CGRectZero];
    [_switchbtn setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_switchbtn];
}


- (void)updateWithViewModel:(CommonTextCellViewModel *)viewModel {
    [super updateWithViewModel:viewModel];
    
    _titleLab.attributedText = viewModel.title;
    _subTitleLab.attributedText = viewModel.subTitle;
    _detailTitleLab.attributedText = viewModel.detailText;
//    _switchbtn.isOn = viewModel.isblog;
//    [_switchbtn setOn:viewModel.isblog];
    if (viewModel.showIndicator == NO) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (viewModel.showSwitch == YES) {
        _switchbtn.hidden = NO;
    }else{
        _switchbtn.hidden = YES;
    }
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    _titleLab.frame = self.viewModel.titleFrame;
    _subTitleLab.frame = self.viewModel.subTitleFrame;
    _detailTitleLab.frame = self.viewModel.detailTextFrame;
    _switchbtn.frame = self.viewModel.switchBtnFrame;
}

@end
