//
//  NoteGroupTableViewCell.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteGroupTableViewCell.h"
#import "UITableViewCell+Ext.h"

@interface NoteGroupTableViewCell ()

@property (nonatomic,strong) UILabel *titleNameLab;
//@property (nonatomic,strong) UILabel *authorNameLab;
@property (nonatomic,strong) UILabel *updateTimeLab;

@end

@implementation NoteGroupTableViewCell
@dynamic viewModel;
- (void)initCell {
    [super initCell];
    //    self.seperatorHidden = YES;
    
    //    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _titleNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_titleNameLab setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_titleNameLab];
    
    
    //    _authorNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
    //    [_authorNameLab setBackgroundColor:[UIColor clearColor]];
    //    [self.contentView addSubview:_authorNameLab];
    
    _updateTimeLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_updateTimeLab setBackgroundColor:[UIColor clearColor]];
//    [self.contentView addSubview:_updateTimeLab];
    
    //    _jobNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
    //    [_jobNameLab setBackgroundColor:[UIColor clearColor]];
    //    [self.contentView addSubview:_jobNameLab];
    
}


- (void)updateWithViewModel:(NoteGroupCellViewModel *)viewModel {
    [super updateWithViewModel:viewModel];
    _titleNameLab.attributedText = viewModel.titleName;
    //    _authorNameLab.attributedText = viewModel.authorName;
    _updateTimeLab.attributedText = viewModel.updateTime;
    //    _companyIndustryLab.attributedText = viewModel.companyIndustry;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    _titleNameLab.frame = self.viewModel.titleNameFrame;
    //    _authorNameLab.frame = self.viewModel.authorNameFrame;
    _updateTimeLab.frame = self.viewModel.updateTimeFrame;
    //    _companyIndustryLab.frame = self.viewModel.companyIndustryFrame;
}

@end
