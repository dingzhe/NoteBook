//
//  PersonalManagerHeadCell.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "PersonalManagerHeadCellViewModel.h"
@interface PersonalManagerHeadCell : NBTableViewCell
@property (nonatomic,strong) UIButton *previewBtn;
@property (nonatomic,strong) UIButton *browseHistoryBtn;
@property (nonatomic,strong) UIButton *headBtn;
@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *emailLab;
@property (nonatomic,strong,readonly) PersonalManagerHeadCellViewModel *viewModel;

@end
