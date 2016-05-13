//
//  ButtonCell.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ButtonCell.h"

@interface ButtonCell ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation ButtonCell
@dynamic viewModel;

- (void)initCell {
    [super initCell];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    [_titleLab setBackgroundColor:[UIColor clearColor]];
    [_titleLab setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_titleLab];
}


- (void)updateWithViewModel:(ButtonCellViewModel *)viewModel {
    [super updateWithViewModel:viewModel];
    
    _titleLab.attributedText = viewModel.title;
    
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    _titleLab.frame = self.viewModel.titleFrame;
    
}


@end
